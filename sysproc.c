#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_gettime(void) {
  struct rtcdate *d;
  if (argptr(0, (char **)&d, sizeof(struct rtcdate)) < 0)
      return -1;
  cmostime(d);
  return 0;
}

int
sys_settickets(void){
  int inputNumTickets;
  if(argint(0, &inputNumTickets) < 0) //get me the 0th parameter from the user’s stack - argint  is doing “surgery” on the trap frame, and store it in the local pid variable, which is on the kernel stack - effectively we are fishing it out of the user stack and putting it on the kernel stack
      return -1;
  else{
    //cprintf("inputNumTickets: %d\n", inputNumTickets);
    int oldNumTickets = proc->numTickets;
    proc->numTickets = inputNumTickets;
    cpu->numTicketsTotal += (inputNumTickets - oldNumTickets);
    //cprintf("New numTickets: %d\n", proc->numTickets);
  }
  return 0;
}
