#include "types.h"
#include "user.h"

int main(){

  if (fork() == 0){
    printf(1,"hello, i am the child.\n");
    exit();
  }
  else{
    sleep(5);
  }

  exit();
}
