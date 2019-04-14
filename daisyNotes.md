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
Make sure to set the CPUs to 1:
```
make qemu CPUS=1
```

# Plan:
[] Add tickets to struct proc.
  - proc.h includes the definition of the per-process proc struct, so we will add tickets in here.
[] Add some global tickets value (maybe to the CPU state struct also defined in proc.h)
[] Assign new processes 20 lottery tickets when they are created:
proc.c includes the initialization of the proc structure for the first user process. We will want to set the number of lottery tickets here.
[] When the scheduler runs, it picks a random number between 0 and the total number of tickets. It then uses the algorithm described in class to pick the next process.
  - The scheduler function is defined within proc.c.
[] Create a system call, ```settickets```, that allows a process to specify how many lottery tickets it wants.
  - Instructions on how to create a system call are in the slides.
[] Test the scheduler
  - Use lotterytest (add lottery test to the UPROGS list in the Makefile)

# Lottery scheduling
### Overview:
Give each process a fixed number of lottery tickets. Effectively giving each process a proportion of the CPU by just giving it that proportion of the tickets.
When it comes time to schedule, pick a random number between 1 and the number of tickets.
Schedule the process that won the lottery.
### Specifics:
Take the existing PCB (struct proc) and augment it with a num_tickets field.
At scheduling time:
Generate a random ticket number winner
Loop over processes, keeping a counter
If counter >= winner then pick that process
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
  - Added numTickets to proc struct in proc.h
  - Added numTicketsTotal to proc cpu in proc.h
  - Assigned each new process 20 tickets.
      - Method A: During userinit, give the first user process 20 tickets.
      - Method B:
        - During userinit, give the first user process 20 tickets and increment numTicketsTotal by 20.
        - Each time a fork occurs, give the new user process 20 tickets (because its parent could have changed its number of tickets using settickets), and increment numTicketsTotal by 20.
 -[ ] @TODO: Make sure numTicketsTotal is cleaned up whenever a process is closed.
    - Method A:
      - During exit, decrement numTicketsTotal by numTickets in struct proc.
    - But is exit the only way to close a process? What code do all closing processes go through?
      - Kill
      - Exit
      - Wait…?

```c
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

# Questions:
Should we check whether a process is RUNNABLE before applying the algorithm? Or after? I think that doing it before would mess up the logic of the lottery…
