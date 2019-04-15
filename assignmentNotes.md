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
- Schedule the process that won the lottery.
### Specifics:
- Take the existing PCB (struct proc) and augment it with a num_tickets field.
- At scheduling time:
  - Generate a random ticket number winner
  - Loop over processes, keeping a counter
  - If counter >= winner then pick that process
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
1. Keep track of per-process tickets.
  - How: Add int numTickets to the process control block (struct proc).
  - Implementation:
2. Keep track of total tickets (across all processes).
  - How: Store int numTicketsTotal along with other per-processor variables (struct cpu).  
  - Implementation:
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
