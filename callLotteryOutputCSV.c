#include "types.h"
#include "user.h"
#include "date.h"
#include "fcntl.h"


// Do some useless computations
void spin(int tix, int fd) {
    struct rtcdate start;
    gettime(&start);

    struct rtcdate end;
    unsigned x = 0;
    unsigned y = 0;
    while (x < 100000) {
        y = 0;
        while (y < 10000) {
            y++;
        }
        x++;
    }

    gettime(&end);

    int duration = ((end.hour*3600) + (end.minute*60) + end.second) - ((start.hour*3600) + (start.minute*60) + start.second);

    printf(fd, "%d, %d\n", tix, duration);
}

int main(){

  int fd;
  fd= open("lotteryOut.csv", O_CREATE | O_RDWR);
  if(fd < 0)
    exit(-1);

  int i;
  for (i=0; i<1000; i++){
    int pid1;
    int pid2;

    //printf(0, "starting test at %d hours %d minutes %d seconds\n", start.hour, start.minute, start.second);
    if ((pid1 = fork()) == 0) {
        settickets(80);
        spin(80,fd);
        exit();
    }
    else if ((pid2 = fork()) == 0) {
        settickets(20,fd);
        spin(20);
        exit();
    }
    // Go to sleep and wait for subprocesses to finish
    wait();
    wait();
  }

  close(fd); 
exit();

}
