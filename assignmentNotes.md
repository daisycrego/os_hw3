## Testing the scheduler:
```
docker run -v '/Users/porkchop/Library/Mobile Documents/com~apple~CloudDocs/csgy6233/xv6-public/':'/home/root/xv6-public' -it xv6 bash
cd /home/root/xv6-public/
cd /home/root/xv6-public/ && make && make qemu-nox CPUS=1
```

# Lottery scheduling
### Overview:
- Give each process a fixed number of lottery tickets. Effectively giving each process a proportion of the CPU by just giving it that proportion of the tickets.
- When it comes time to schedule, pick a random number between 1 and the number of tickets.
- Schedule the process that won the lottery. The more tickets a process has, the more likely it will be selected by the lottery algorithm.  
### Specifics:
- At scheduling time:
  - Generate a random ticket number winner
  - Loop over processes, keeping a counter
  - If counter >= winner then pick that process
  - Otherwise, increment the counter by numTickets of the current process and advance to the next process in the queue.
### Algorithm:
For an array of processes (proc[NUM_OF_PROCS]), each with its associated number of tickets (num_tickets):
```
for each process in proc[NUM_OF_PROCS]:
  counter = 0
  winner = random number between 0 and total number of tickets
  if counter+process[num_of_tickets] >= winner:
    if process[state] == RUNNABLE
      run the process
    else
    continue
  else:
    counter+=process[num_of_tickets]
    continue

```

# Execution
1. **Keep track of per-process tickets.**
  - **How**: Add int numTickets to the process control block (struct proc).
  - **Implementation**:
```c
// proc.h
// Per-process state
struct proc {
  uint sz;                     // Size of process memory (bytes)
  pde_t* pgdir;                // Page table
  char \*kstack;                // Bottom of kernel stack for this process
  enum procstate state;        // Process state
  int pid;                     // Process ID
  struct proc \*parent;         // Parent process
  struct trapframe \*tf;        // Trap frame for current syscall
  struct context \*context;     // swtch() here to run process
  void \*chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  struct file \*ofile[NOFILE];  // Open files
  struct inode \*cwd;           // Current directory
  char name[16];               // Process name (debugging)
  int numTickets;              // Number of tickets (for lottery)
};
```

2. **Keep track of total tickets (across all processes).**
  - **How**:
    A. Store int numTicketsTotal in CPU state struct (cpu).
    B. Initialize total to 0 during userinit.
    C. Make sure that total is updated whenever a process is created or exited.
  - **Implementation**:
## A
Store int numTicketsTotal in CPU state struct (cpu).
```c
// proc.h
// Per-CPU state
struct cpu {
  uchar id;                    // Local APIC ID; index into cpus[] below
  struct context \*scheduler;   // swtch() here to enter scheduler
  struct taskstate ts;         // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   // x86 global descriptor table
  volatile uint started;       // Has the CPU started?
  int ncli;                    // Depth of pushcli nesting.
  int intena;                  // Were interrupts enabled before pushcli?
  int numTicketsTotal;         // Total number of tickets awarded across all processes (for lottery scheduling)

  // Cpu-local storage variables; see below
  struct cpu \*cpu;
  struct proc \*proc;           // The currently-running process.
};
```

## B
Initialize total tickets to 0 during userinit.
```c
//proc.c
void
userinit(void)
{
  struct proc \*p;
  extern char \_binary_initcode_start[], \_binary_initcode_size[];

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, \_binary_initcode_start, (int)\_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  cpu->numTicketsTotal = 0;

  p->state = RUNNABLE;
}
```

## C
Make sure that numTicketsTotal is updated whenever a process is (a) created or (b) exited, or (c) when a process sets its own tickets using the settickets system call.

(a) created
```
int
fork(void)
{
  [...]

  pid = np->pid;
  np->numTickets = proc->numTickets; //Child gets parent's numTickets

  cpu->numTicketsTotal += proc->numTickets;

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
  np->state = RUNNABLE;
  release(&ptable.lock);

  return pid;
}
```

(b) exited

Whenever the trap handler is called, if the current user process has been killed, it will be forced to call exit.
```
// trap.c
// Force process exit if it has been killed and is in user space.
// (If it is still executing in the kernel, let it keep running
// until it gets to the regular system call return.)
if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  exit();
```

Modifications to exit:
```
// proc.c
void
exit(void)
{
  struct proc \*p;
  int fd;

  [...]

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  if (cpu->numTicketsTotal - proc->numTickets < 0){
    panic("Negative number of tickets!\n");
  }
  cpu->numTicketsTotal -= proc->numTickets;

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

```

Whether a process is forced to call exit (i.e. is killed) or exits voluntarily, exit will be called. numTicketsTotal is decremented during exit. Check is made that numTickets <= numTicketsTotal. If it isn't, decrementing will result in a negative numTicketsTotal, which will throw off the algorithm. Having this check in place and running lotterytest hundreds of times without throwing this error indicates that we are never over-decrementing numTicketsTotal or under-allocating numTickets (we were initially failing with this error and it was because sh and init weren't allocated tickets explicitly, outside of fork). **Note**: this doesn't show that were are never over-allocating tickets. There must be a test to run to confirm that numTicketsTotal isn't growing slowly over time ("leaking tickets").


(c) when a process sets its own tickets using the settickets system call.

```
//sysproc.c
int
sys_settickets(void){
  int inputNumTickets;
  if(argint(0, &inputNumTickets) < 0)
      return -1;
  int oldNumTickets = proc->numTickets;
  proc->numTickets = inputNumTickets;
  if((cpu->numTicketsTotal + inputNumTickets - oldNumTickets) < 0)
    return -1
  cpu->numTicketsTotal += (inputNumTickets - oldNumTickets);
  return 0;
}
```

**STOPPED HERE**

3. Assign new user processes lottery tickets when they are created. A child will be awarded the same number of tickets as their parent in this implementation. Update total number of tickets after each allocation:
  - How:  
    - Most user processes are created by the shell (fork + exec), so award tickets during fork to the child process.
    - But, some user processes are not the result of a fork, so they will need their tickets to be awarded explicitly.  
      - The init process (the first user process)
      - The shell (called by the first user process)
  - Implementation:
4. When a process exits, update total number of tickets.
  - How: During exit, decrement cpu->numTicketsTotal.
  - Implementation:
5. Revise the scheduler:
  - How:
  - Implementation:
6. Create a system call, ```settickets```, that allows a process to specify how many lottery tickets it wants.
    - Instructions on how to create a system call are in the slides.
6. Test the scheduler
    - Use lotterytest (add lottery test to the UPROGS list in the Makefile)

### Details
  - Add default num of tickets (DEFTICKETS) variable to param.h.
  - Added numTickets to proc struct in proc.h
  - Add cpu-global numTicketsTotal
    - Added numTicketsTotal to proc cpu in proc.h
    - Initialize to 0 in main.c - mpmain().
  - Assigned each new process 20 tickets.
      - Method A: During userinit, give the first user process 20 tickets.
      - **Method B** (**current implementation**):
        - During userinit, give the first user process 20 tickets and increment numTicketsTotal by 20.
        - Each time a fork occurs, give the new user process 20 tickets (because its parent could have changed its number of tickets using settickets), and increment numTicketsTotal by 20.
        - When userinit calls shell, give shell 20 tickets (because shell isn't called by fork, while all processes that it calls will be fine because of fork... )
          - sh.c: explicitly give sh tickets here.
 - Make sure numTicketsTotal is cleaned up whenever a process is closed.
    - Method A (**current implementation**):
      - During exit, decrement numTicketsTotal by numTickets in struct proc.
    - But is exit the only way to close a process? What code do all closing processes go through?
      - Kill - calls exit
      - **Exit**
      - Wait - too late
    - But are user processes the only ones passing through exit? Could we end up with negative numTicketsTotal because non-user processes will also result in decrementing of numTicketsTotal? No. This is a scheduler of user processes. These user processes may invoke the kernel at any point in their execution, but no kernel processes will be scheduled.  
    - Changed the scheduler:
```c
    void
    scheduler(void)
    {
      //cprintf("ENTERING THE SCHEDULER!\n");
      //procdump();

      struct proc \*p;
      int foundproc = 1;

      for(;;){
        // Enable interrupts on this processor.
        sti();

        if (!foundproc) hlt();
        foundproc = 0;

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        int counter = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          long winner = random_at_most(cpu->numTicketsTotal);
          if (counter+(p->numTickets) >= winner){
            if (p->state!= RUNNABLE){
              counter+= p->numTickets;
              continue;
            }
          }
          else{
            counter+= p->numTickets;
            continue;
          }

          // Switch to chosen process.  It is the process's job
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          foundproc = 1;
          proc = p;
          switchuvm(p);
          p->state = RUNNING;
          swtch(&cpu->scheduler, proc->context);
          switchkvm();

          // Process is done running for now.
          // It should have changed its p->state before coming back.
          proc = 0;
        }
        release(&ptable.lock);

      }
    }
    ```

    - Added the settickets system call.
      - Add settickets to syscall.c
      - Assign it a number in syscall.h
      - Give it a prototype in user.h
      - Add it to usys.S, which generates the user-space assembly code for it
      - Add implementation in sysproc.c
    - Ran testLottery: forks, in child runs normally, in the parent sleeps forever. Checks whether numTicketsTotal is incremented properly.
    - Ran lotterytest: Awards 2 processes a different number of tickets (20 vs 80), runs CPU-intensive spin program, clocks runtimes of each.
      - Added lotterytest to UPROGS in Makefile
      - Ran 100 and then 500 and then 1000 times. During the 1000x run, we recorded the random number selected by the scheduler. The distribution of the winning numbers was ____(uniform, non-uniform).

      A=100
      B=500

      Tickets	Average Duration
      A 20	8.32
      A 80	6.89
      B 20	8.29
      B 80	6.84

      I don't see any significant imbalance in scheduling between the 2 processes over time.

      But what about more processes? How fair will lottery scheduling be then?
