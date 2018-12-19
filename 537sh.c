#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

int batchMode=0;

int showPrompt(void) 
{
      char *cmds[100];
      char buffer[100];
      char * tmp;
      int num_cmds, i, flag, rc=0;

      while (!rc) 
      {
          num_cmds = 0;
          printf("\n./537sh%% "); fgets(buffer, 512, stdin);

	  for(i=0; buffer[i]!='\0'; i++) {
	    if(buffer[i]=='+')
	      flag++;
	  }

	  int j = i-2;
	  int endingWithPlus = 0;
	  for(; j >= 0; j--)
	  {
	    if(buffer[j] == ' ')
	      continue;
	    else if(buffer[j] == '+')
	      {
		endingWithPlus = 1;
		break;
	      }
	    else
	      break;
	  }

	  //printf("%d\n", flag);
          tmp = strtok(buffer,"+");
           
          while (tmp) 
          {
              cmds[num_cmds] = tmp;
              num_cmds++;
              tmp = strtok(NULL,"+");
          } 

	  int numCmndsToFork = num_cmds;
	  
	  if(flag==0)
	  {
	    if((rc=breakString(buffer))==101) {
	      //printf("exiting3..."); 
	      break; 
	      exit(1);
	    }
	  }
	  else
	    {
	      
	      if(endingWithPlus == 0)
	      {
		  numCmndsToFork = num_cmds - 1;
		   if((rc=breakString(cmds[num_cmds-1]))==101)
		   {
		     //printf("exiting3..."); 
		     break; exit(1);
		   }
	      }

	      int i;
	      for (i = 0; i < numCmndsToFork; i++) 
		{
		  //          printf("Word %d: \"%s\"\n",i,cmds[i]);
            
		  int ret;
		  if( (ret=fork()) > 0 )
		    {
		      //   parent(ret);
		    }
		  else if ( ret == 0 )
		    {
		      //    child();
		      //printf("Running %s in background.\n------------------------------\n", cmds[i] );
		      if(breakString(cmds[i])==101) 
			{ 
			  //printf("exiting4..."); 
			  exit(0); 
			}
		      break;
		    }
		  else 
		    {
		      char error_message[30] = "An error has occurred\n";
		      write(STDERR_FILENO, error_message, strlen(error_message));
		    }
		}
	    }
      }
      return 0;
}

int breakCommand(char *str)
{
       char *tmp;
       char *subcmds[1000];
       char buffer[1000];
       strcpy(buffer, str);
       tmp = strtok(buffer," \n\t");
       int num_subcmds = 0;
       int out, flag1=0;
       char *subnew[1000];
        
       while (tmp) 
       {
          subcmds[num_subcmds] = tmp;
          num_subcmds++;
          tmp = strtok(NULL," \n\t");
       } 
            
       int j, loc=0;

       /*if(batchMode == 1)
	 {
	 for (j = 0; j < num_subcmds; j++) 
	   {
	     printf("Command %d: \"%s\"\n",j,subcmds[j]);
	     //write(STDOUT_FILENO, subcmds[j], strlen(subcmds[j]));
	     //if(j!=num_subcmds-1) write(STDOUT_FILENO, " ", strlen(" "));
	   }

	 //write(STDOUT_FILENO, "\n", strlen("\n"));

	     }*/

       /*if(strlen(buffer)>513) 
	 {
	   char error_message[30] = "An error has occurred\n";
	   write(STDERR_FILENO, error_message, strlen(error_message));
	   subcmds[0]=NULL;
	   }*/

       for (j = 0; j < num_subcmds; j++) 
	 {
	 }

       subcmds[j] = NULL;

       if(num_subcmds > 1)
	 {
	   for (j = 0; j < num_subcmds; j++) 
	     {
	       if(strcmp(subcmds[j], ">") == 0)
		 {
		   loc=j;
		   flag1=1;
		   break;
		 }
	     }

	   //printf("%d", flag1);

	   if(flag1==1)
	     {
	       for (j = 0; j < loc; j++) 
		 {
		   subnew[j]=subcmds[j];
		 }
	     }
       
	   subnew[loc]=NULL;
	 }
       
       int i, savedJ, flag2 = 0;

       if(flag1!=1)
	   for (j = 0; j < num_subcmds; j++) 
	     {
	       i = strlen(subcmds[j]) - 1;
	       //write(STDOUT_FILENO, "Gotcha", strlen("Gotcha"));
	       //printf("Val of i: %d", i);
	       if(subcmds[j][i]=='>')
		 {
		   //write(STDOUT_FILENO, "Gotcha", strlen("Gotcha"));
		   subcmds[j][i]='\0';
		   flag2 = 1;
		   savedJ=j;
		 }
	     }

       if(flag2==1)
	 {
	   for (j = 0; j <= savedJ; j++) 
	     {
	       subnew[j]=subcmds[j];
	     }
	   subnew[savedJ+1]=NULL;
	 }
 
       //if(batchMode==1) printf("%s\n", subcmds[0]);
       
       if(flag1==1)
	 {
	   close(STDOUT_FILENO);
	   out = open(subcmds[loc+1], O_RDWR | O_CREAT , 0666 ); 
	     //open(subcmds[loc+1], O_WRONLY | O_TRUNC | O_CREAT, S_IRWXU);
	   if(out < 0)
	     {
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(0);
	       //return 101;
	     }
	   dup2(out, STDOUT_FILENO);
	   if(execvp(subnew[0], subnew) < 0)
	     {
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(101);
	     }
	   close(out);
	   return 101;
	 }
       else if(flag2==1)
	 {
	   close(STDOUT_FILENO);
	   out = open(subcmds[savedJ+1], O_RDWR | O_CREAT , 0666 ); 
	   //open(subcmds[loc+1], O_WRONLY | O_TRUNC | O_CREAT, S_IRWXU);
	   if(out < 0)
	     {
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(0);
	       //return 101;
	     }
	   dup2(out, STDOUT_FILENO);
	   if(execvp(subnew[0], subnew) < 0)
	     {
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(101);
	     }
	   close(out);
	   return 101;
	 }
	 else if(strcmp(subcmds[0], "cd") == 0)
	 {
	   //printf("PATH=%s\n", subcmds[1]);
	   int res;
	   if(subcmds[1]!=NULL)
	     {
	       res = chdir(subcmds[1]);
	     }
	   else
	     {
	       res = chdir(getenv("HOME"));
	     }

	   if(res == -1)
	     {
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(101);
	       //return 101;
	     }
	 }
       else if(strcmp(subcmds[0], "exit") == 0)
	 {
	   //printf("\n");
	   exit(0);
	   //return 10;
	 }
       else if(strcmp(subcmds[0], "pwd") == 0)
	 {
	   if(subcmds[1]!=NULL)
	     {
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(0);
	       //return 101;
	     }
	   else if (execvp(subcmds[0], subcmds) < 0)
	     {
	       //	   printf("\n%s - Failed", subcmds[0]);
	       char error_message[30] = "An error has occurred\n";
	       write(STDERR_FILENO, error_message, strlen(error_message));
	       exit(101); 
	     }
	 }
       else if (execvp(subcmds[0], subcmds) < 0)
	 {
	   //	   printf("\n%s - Failed", subcmds[0]);
	   char error_message[30] = "An error has occurred\n";
	   write(STDERR_FILENO, error_message, strlen(error_message));
	   //exit(101); 
	   return 1;
	 }
       //exit(101);
       return 1;
}

int breakString(char *str)
{
       char *tmp;
       char *subcmds[1000];
       char buffer[1000];
       strcpy(buffer, str);
       tmp = strtok(buffer,";");
       int num_subcmds = 0;
        
       while (tmp) 
       {
          subcmds[num_subcmds] = tmp;
          num_subcmds++;
          tmp = strtok(NULL,";");
       } 


       /*   if(strcmp(subcmds[0], "exit") == 0)
	 {
	   //printf("exiting1...");
	   return 101;
	   }*/

       int j, status;
           
       for (j = 0; j < num_subcmds; j++) 
       {
	 //printf("SubWord %d: \"%s\"\n",j,subcmds[j]); 
	 int ret;
	 /*if(strcmp(str, subcmds[j]) == 0 && strcmp(subcmds[j], "ls") != 0 && strcmp(subcmds[j], "pwd") != 0)
	   {
	     if(breakCommand(subcmds[j])==1);
	     	     return (101);
		     }

		     else */if((subcmds[j][0]=='c' && subcmds[j][1]=='d') == 1)
	   {
	     breakCommand(subcmds[j]);
	   }
	 else if(strcmp(subcmds[j],"exit") == 0)
	   {
	     breakCommand(subcmds[j]);
	   }
	 else
	   {
	     if( (ret=fork()) > 0 )
	       {
                 //   parent(ret);
                 //wait(&status);
		 waitpid(ret,&status,WUNTRACED);
		 int x = WEXITSTATUS(status);
		 //printf("parent - Status: %d\n", status);
		 if(x==101)
		   return 101;
		   //exit(101);
	       }
	     else if ( ret == 0 )
	       {
		 //    child();
		 //printf("child\n");
		 if(breakCommand(subcmds[j])==1)  
		   { 
		     //printf("exiting2..."); 
		     exit(1);
		     return 101; 
		   }
		 else return 0;
		 break;
	       }
	     else 
	       {
		 char error_message[30] = "An error has occurred\n";
		 write(STDERR_FILENO, error_message, strlen(error_message));
		 exit(101);
	       }
	   }
       }
}

int main(int argc, char *argv[]) 
{
      char *cmds[1000];
      char buffer[1000]="test";
      char * tmp;
      int num_cmds, i, flag, rc=0;
      //int batchMode=0;
      char *fileToRead = "/no/such/file";

      if(argc>2) 
	{
	  char error_message[30] = "An error has occurred\n";
	  write(STDERR_FILENO, error_message, strlen(error_message));
	  exit(1);
	}
      else if(argc==2)
	{
	  batchMode = 1;	        
	  fileToRead = argv[1];
	}

      FILE *new;
      FILE *fp;

      if(batchMode==1)
	{
	  fp = fopen(fileToRead,"r");
	  if (fp==NULL) 
	    {
	      char error_message[30] = "An error has occurred\n";
	      write(STDERR_FILENO, error_message, strlen(error_message));
	      exit(1);
	    }
	  new=fp;
	}
      else
	new=stdin;
	
      while (!feof(new)) 
      {
          num_cmds = 0;
          if(batchMode==0) write(STDOUT_FILENO, "537sh% ", strlen("537sh% ")); 
	    //printf("%s%% ",argv[0]); 
	  if(batchMode==1)
	      fgets(buffer, 1000, fp);
	  else
	      fgets(buffer, 1000, stdin);

	  int j;

	  strtok(buffer, "\n\r");

	  if(batchMode == 1 && strcmp(buffer,"xyz")!=0)
	    {
		  //printf("Command %d: \"%s\"\n",j,subcmds[j]);
		  write(STDOUT_FILENO, buffer, strlen(buffer));
		  write(STDOUT_FILENO, "\n", strlen("\n"));
		  //if(j!=num_subcmds-1) write(STDOUT_FILENO, " ", strlen(" "));
		  if(strcmp(buffer,"+")==0)
		    {
		      //printf("%s",buffer);
		      exit(0);
		    }
	    }

	  if(strcmp(buffer,"xyz")==0) exit(0);
	  
	  //printf("Buffer is: %s\n", buffer);

	  for(i=0; buffer[i]!='\0'; i++) {
	    if(buffer[i]=='+')
	      flag++;
	  }
	  
	  if(strlen(buffer)==0)
	    {
	      char error_message[30] = "An error has occurred\n";
	      write(STDERR_FILENO, error_message, strlen(error_message));
	    }

	  j = i-2;
	  int endingWithPlus = 0;
	  for(; j >= 0; j--)
	  {
	    if(buffer[j] == ' ')
	      continue;
	    else if(buffer[j] == '+')
	      {
		endingWithPlus = 1;
		break;
	      }
	    else
	      break;
	  }

	  //printf("%d\n", flag);
          tmp = strtok(buffer,"+");
           
          while (tmp) 
          {
              cmds[num_cmds] = tmp;
              num_cmds++;
              tmp = strtok(NULL,"+");
          } 

	  int numCmndsToFork = num_cmds;
	  
	  if(flag==0)
	  {
	    if((rc=breakString(buffer))==101) {
	      //printf("exiting3..."); 
	      break; exit(0);
	    }
	  }
	  else
	    {
	      
	      if(endingWithPlus == 0)
	      {
		  numCmndsToFork = num_cmds - 1;
		   if((rc=breakString(cmds[num_cmds-1]))==101)
		   {
		     //printf("exiting3..."); 
		     break; 
		     exit(0);
		   }
	      }

	      int i, status;
	      for (i = numCmndsToFork-1; i >= 0; i--) 
		{
		  //          printf("Word %d: \"%s\"\n",i,cmds[i]);
            
		  int ret;
		  if( (ret=fork()) > 0 )
		    {
		      //   parent();
		      //printf("Hello");
		      //showPrompt();
		      //wait(&status);
		      while (1) {
			int status;
			pid_t done = waitpid(ret,&status,WUNTRACED);
			if (done == -1) {
			  if (errno == ECHILD) break; // no more child processes
			} else {
			  int x = WEXITSTATUS(status);
			  //printf("parent - main - Status: %d\n", x);

			  if (!WIFEXITED(x) || WEXITSTATUS(x) != 101) {
			    //cerr << "pid " << done << " failed" << endl;
			    exit(0);
			  }
			}
		      }
		    }
		  else if ( ret == 0 )
		    {
		      //    child();
		      //close(STDOUT_FILENO);
		      //printf("Running %s in background.\n------------------------------\n", cmds[i] );
		      if(breakString(cmds[i])==101) 
			{ 
			  //printf("exiting4..."); 
			  exit(0); 
			}
		      //break;
		    }
		  else 
		    {
		      char error_message[30] = "An error has occurred\n";
		      write(STDERR_FILENO, error_message, strlen(error_message));
		      exit(0);
		    }
		}
	    }
	  strcpy(buffer,"xyz");
      }
      return 0;
}
