

# Set-up notes
- Cloned the new xv6-public folder to csgy6233/
- In order to track my own work on git, I will change the origin’s url to one for my own repository so that I can push up to there. I’m especially noting the details of how I did this because later on, I will need to switch back to push my patch.
- Here is where I got the advice to switch the origin url: https://stackoverflow.com/questions/18200248/cloning-a-repo-from-someone-elses-github-and-pushing-it-to-a-repo-on-my-github
- This is what I did:

```git
git remote set-url origin https://github.com/daisycrego/os_hw4.git
git push origin master
```

I can now checkout the hw4 branch no problem and all of the files are on git.

## Testing the scheduler:
```
docker run -v '/Users/porkchop/Library/Mobile Documents/com~apple~CloudDocs/csgy6233/xv6-public/':'/home/root/xv6-public' -it xv6 bash
cd /home/root/xv6-public/
cd /home/root/xv6-public/ && make && make qemu-nox CPUS=1
```

# Plan:
1. Add tickets to struct proc.
    - proc.h includes the definition of the per-process proc struct, so we will add tickets in here.
2. Add some global tickets value (maybe to the CPU state struct also defined in proc.h)
3. Assign new processes 20 lottery tickets when they are created:
proc.c includes the initialization of the proc structure for the first user process. We will want to set the number of lottery tickets here.
4. When the scheduler runs, it picks a random number between 0 and the total number of tickets. It then uses the algorithm described in class to pick the next process.
    - The scheduler function is defined within proc.c.
5. Create a system call, ```settickets```, that allows a process to specify how many lottery tickets it wants.
    - Instructions on how to create a system call are in the slides.
6. Test the scheduler
    - Use lotterytest (add lottery test to the UPROGS list in the Makefile)

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

### Execution
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
- Changed the scheduler
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

**? Are user processes the only ones "scheduled"?**
   - Yes. The scheduler loops through the proc table, which selects a RUNNABLE user process from the process table (ptable). There isn't really a scheduling of kernel processes. There is no protection because all processes run with equal priority. (?)

### Let's trace the lifetime of a user process, or processes in general in xv6. Looking in proc.c:

The first user process is set up:
```c
//PAGEBREAK: 32
// Set up first user process.
void userinit(void)
{
  struct proc \*p;
  ...
  p = allocproc();
  initproc = p;
  ...

  p->state = RUNNABLE;

  p->numTickets = 20;
  cpu->numTicketsTotal = 20;
}
```

userinit calls allocproc during its execution to find an UNUSED process in the process table, change its state to EMBRYO, and do some other initializations:
```c
//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc \*p;
  char \*sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  release(&ptable.lock);
...

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  \*(uint*)sp = (uint)trapret;

  sp -= sizeof \*p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof \*p->context);
  p->context->eip = (uint)forkret;

  return p;
}
```

allocproc finds a new process an UNUSED entry in the process table and sets up the context for the new process to start executing at forkret, which returns to trapret:

```c
// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
```

So when would forkret be executed? Ah! By the scheduler when a forked child is first scheduled by the scheduler.

Let's look at fork:
1. Calls allocproc:
  - Finds a new process an UNUSED entry in the process table and sets up the **context** (EIP pushed implicitly, ESP serving as the address of the rest of the context, and the other registers absolutely necessary to perform a context switch EBP, EDI, ?). so that EIP points to ```forkret```, which returns to trapret. When the new process is passed through the scheduler, execution will begin in ```forkret```, which will mediate the process of transitioning back to user space.
2. Copies process state from parent:
  - ```np->pgdir = copyuvm(proc->pgdir, proc->sz))```
    1. copyuvm creates a copy of the parent's process table and returns a pointer to the new page directory (stored at np->pgdir).
    2. Copies sz (np->sz)
    3. Copies trap frame of parent (np->tf).
    4. Stores parent (np->parent points to the proc of the parent process. **What happens to np->parent when the parent process exits before the child?**)
    5. Clears %eax (np->tf->eax) so that 0 is returned in the child.
    ...
    6. Skipping some things, what's going on here?
    ```c
    for(i = 0; i < NOFILE; i++)
      if(proc->ofile[i])
        np->ofile[i] = filedup(proc->ofile[i]);
    np->cwd = idup(proc->cwd);

    safestrcpy(np->name, proc->name, sizeof(proc->name));
    ```
    7. Sets pid to np->pid (this will be returned to the parent).
    8. **Sets np->numTickets to 20 and increments cpu->numTicketsTotal by 20.**
3.  Forces the compiler to emit the np->state write last (so the scheduler won't intercept this process and schedule it before it's ready).
  - Acquires lock on the process table.
  - Sets process state to RUNNABLE.
  - Releases lock.  
4. Returns pid (to the parent). The child will return somewhere else (forkret, which will return to trapret). This is very interesting. It's not like we can return in the child and parent "simultaneously". We have no choice when we will occur. That's up to the CPU and "fate". We set ourselves up, set our status to RUNNABLE, and wait. What's so crazy is, during this process of setting ourselves up, we may at any time be interrupted, our state saved, and then resumed at some later time without us knowing anything about it. Even something as complicated as what's going on here. No issue. Frozen and resumed later.
- The elements that make up a process are finite. They can be saved, shelved, and picked back up at any time. In this case it just boils down to a few registers because from them, you can access everything that you need.
= **That would be something interesting to look more into next. The full anatomy of a process, and how each element links to those few really important registers.**
```c
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
  int i, pid;
  struct proc \*np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  \*np->tf = \*proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  np->numTickets = 20; //Each process has 20 tickets initially (for lottery scheduling).
  cpu->numTicketsTotal += 20;

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);

  np->state = RUNNABLE;
  release(&ptable.lock);

  return pid;
}
```

Now let's look at returning in the child:

Now let's look at returning in the parent:

```
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc \*p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

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

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

```


```
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc \*p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
```
```
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  proc->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}
```

```
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc \*p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
```

# Questions:
- Should we check whether a process is RUNNABLE before applying the algorithm? Or after? I think that doing it before would mess up the logic of the lottery…
