#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <assert.h>

char *message[] = {"this message should appear  FIRST\n1\n",
		   "this message should appear  SECOND\n2\n",
		   "this message should appear  THIRD\n3\n"};
int main(int argc, char* argv[]) {
  assert(argc > 1);
  sleep(atoi(argv[1])*2+1);
  
  int fd;
  if (argc ==2) fd = STDOUT_FILENO;
  else { 
    if (argc == 3) 
      fd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
    else
      fd = open(argv[2], O_WRONLY | O_CREAT | O_APPEND, S_IRWXU);
  }
  assert(fd > -1);
  write(fd, message[atoi(argv[1])], strlen(message[atoi(argv[1])]));
  //fsync(fd);
  close(fd);
  //sync();
  return(0);
}
