
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 5c 0f 00 00       	call   f6d <exit>

  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 a4 15 00 00 	mov    0x15a4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	c7 04 24 78 15 00 00 	movl   $0x1578,(%esp)
      2b:	e8 33 03 00 00       	call   363 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      30:	8b 45 08             	mov    0x8(%ebp),%eax
      33:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      36:	8b 45 f4             	mov    -0xc(%ebp),%eax
      39:	8b 40 04             	mov    0x4(%eax),%eax
      3c:	85 c0                	test   %eax,%eax
      3e:	75 05                	jne    45 <runcmd+0x45>
      exit();
      40:	e8 28 0f 00 00       	call   f6d <exit>
    exec(ecmd->argv[0], ecmd->argv);
      45:	8b 45 f4             	mov    -0xc(%ebp),%eax
      48:	8d 50 04             	lea    0x4(%eax),%edx
      4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4e:	8b 40 04             	mov    0x4(%eax),%eax
      51:	89 54 24 04          	mov    %edx,0x4(%esp)
      55:	89 04 24             	mov    %eax,(%esp)
      58:	e8 48 0f 00 00       	call   fa5 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      60:	8b 40 04             	mov    0x4(%eax),%eax
      63:	89 44 24 08          	mov    %eax,0x8(%esp)
      67:	c7 44 24 04 7f 15 00 	movl   $0x157f,0x4(%esp)
      6e:	00 
      6f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      76:	e8 f3 10 00 00       	call   116e <printf>
    break;
      7b:	e9 86 01 00 00       	jmp    206 <runcmd+0x206>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	89 04 24             	mov    %eax,(%esp)
      8f:	e8 01 0f 00 00       	call   f95 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      94:	8b 45 f0             	mov    -0x10(%ebp),%eax
      97:	8b 50 10             	mov    0x10(%eax),%edx
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	8b 40 08             	mov    0x8(%eax),%eax
      a0:	89 54 24 04          	mov    %edx,0x4(%esp)
      a4:	89 04 24             	mov    %eax,(%esp)
      a7:	e8 01 0f 00 00       	call   fad <open>
      ac:	85 c0                	test   %eax,%eax
      ae:	79 23                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b3:	8b 40 08             	mov    0x8(%eax),%eax
      b6:	89 44 24 08          	mov    %eax,0x8(%esp)
      ba:	c7 44 24 04 8f 15 00 	movl   $0x158f,0x4(%esp)
      c1:	00 
      c2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      c9:	e8 a0 10 00 00       	call   116e <printf>
      exit();
      ce:	e8 9a 0e 00 00       	call   f6d <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	89 04 24             	mov    %eax,(%esp)
      dc:	e8 1f ff ff ff       	call   0 <runcmd>
    break;
      e1:	e9 20 01 00 00       	jmp    206 <runcmd+0x206>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      e6:	8b 45 08             	mov    0x8(%ebp),%eax
      e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      ec:	e8 98 02 00 00       	call   389 <fork1>
      f1:	85 c0                	test   %eax,%eax
      f3:	75 0e                	jne    103 <runcmd+0x103>
      runcmd(lcmd->left);
      f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
      f8:	8b 40 04             	mov    0x4(%eax),%eax
      fb:	89 04 24             	mov    %eax,(%esp)
      fe:	e8 fd fe ff ff       	call   0 <runcmd>
    wait();
     103:	e8 6d 0e 00 00       	call   f75 <wait>
    runcmd(lcmd->right);
     108:	8b 45 ec             	mov    -0x14(%ebp),%eax
     10b:	8b 40 08             	mov    0x8(%eax),%eax
     10e:	89 04 24             	mov    %eax,(%esp)
     111:	e8 ea fe ff ff       	call   0 <runcmd>
    break;
     116:	e9 eb 00 00 00       	jmp    206 <runcmd+0x206>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     11b:	8b 45 08             	mov    0x8(%ebp),%eax
     11e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     121:	8d 45 dc             	lea    -0x24(%ebp),%eax
     124:	89 04 24             	mov    %eax,(%esp)
     127:	e8 51 0e 00 00       	call   f7d <pipe>
     12c:	85 c0                	test   %eax,%eax
     12e:	79 0c                	jns    13c <runcmd+0x13c>
      panic("pipe");
     130:	c7 04 24 9f 15 00 00 	movl   $0x159f,(%esp)
     137:	e8 27 02 00 00       	call   363 <panic>
    if(fork1() == 0){
     13c:	e8 48 02 00 00       	call   389 <fork1>
     141:	85 c0                	test   %eax,%eax
     143:	75 3b                	jne    180 <runcmd+0x180>
      close(1);
     145:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     14c:	e8 44 0e 00 00       	call   f95 <close>
      dup(p[1]);
     151:	8b 45 e0             	mov    -0x20(%ebp),%eax
     154:	89 04 24             	mov    %eax,(%esp)
     157:	e8 89 0e 00 00       	call   fe5 <dup>
      close(p[0]);
     15c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     15f:	89 04 24             	mov    %eax,(%esp)
     162:	e8 2e 0e 00 00       	call   f95 <close>
      close(p[1]);
     167:	8b 45 e0             	mov    -0x20(%ebp),%eax
     16a:	89 04 24             	mov    %eax,(%esp)
     16d:	e8 23 0e 00 00       	call   f95 <close>
      runcmd(pcmd->left);
     172:	8b 45 e8             	mov    -0x18(%ebp),%eax
     175:	8b 40 04             	mov    0x4(%eax),%eax
     178:	89 04 24             	mov    %eax,(%esp)
     17b:	e8 80 fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     180:	e8 04 02 00 00       	call   389 <fork1>
     185:	85 c0                	test   %eax,%eax
     187:	75 3b                	jne    1c4 <runcmd+0x1c4>
      close(0);
     189:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     190:	e8 00 0e 00 00       	call   f95 <close>
      dup(p[0]);
     195:	8b 45 dc             	mov    -0x24(%ebp),%eax
     198:	89 04 24             	mov    %eax,(%esp)
     19b:	e8 45 0e 00 00       	call   fe5 <dup>
      close(p[0]);
     1a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1a3:	89 04 24             	mov    %eax,(%esp)
     1a6:	e8 ea 0d 00 00       	call   f95 <close>
      close(p[1]);
     1ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1ae:	89 04 24             	mov    %eax,(%esp)
     1b1:	e8 df 0d 00 00       	call   f95 <close>
      runcmd(pcmd->right);
     1b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1b9:	8b 40 08             	mov    0x8(%eax),%eax
     1bc:	89 04 24             	mov    %eax,(%esp)
     1bf:	e8 3c fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1c7:	89 04 24             	mov    %eax,(%esp)
     1ca:	e8 c6 0d 00 00       	call   f95 <close>
    close(p[1]);
     1cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1d2:	89 04 24             	mov    %eax,(%esp)
     1d5:	e8 bb 0d 00 00       	call   f95 <close>
    wait();
     1da:	e8 96 0d 00 00       	call   f75 <wait>
    wait();
     1df:	e8 91 0d 00 00       	call   f75 <wait>
    break;
     1e4:	eb 20                	jmp    206 <runcmd+0x206>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     1e6:	8b 45 08             	mov    0x8(%ebp),%eax
     1e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     1ec:	e8 98 01 00 00       	call   389 <fork1>
     1f1:	85 c0                	test   %eax,%eax
     1f3:	75 10                	jne    205 <runcmd+0x205>
      runcmd(bcmd->cmd);
     1f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     1f8:	8b 40 04             	mov    0x4(%eax),%eax
     1fb:	89 04 24             	mov    %eax,(%esp)
     1fe:	e8 fd fd ff ff       	call   0 <runcmd>
    break;
     203:	eb 00                	jmp    205 <runcmd+0x205>
     205:	90                   	nop
  }
  exit();
     206:	e8 62 0d 00 00       	call   f6d <exit>

0000020b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     20b:	55                   	push   %ebp
     20c:	89 e5                	mov    %esp,%ebp
     20e:	83 ec 18             	sub    $0x18,%esp
  printf(2, "$ ");
     211:	c7 44 24 04 bc 15 00 	movl   $0x15bc,0x4(%esp)
     218:	00 
     219:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     220:	e8 49 0f 00 00       	call   116e <printf>
  memset(buf, 0, nbuf);
     225:	8b 45 0c             	mov    0xc(%ebp),%eax
     228:	89 44 24 08          	mov    %eax,0x8(%esp)
     22c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     233:	00 
     234:	8b 45 08             	mov    0x8(%ebp),%eax
     237:	89 04 24             	mov    %eax,(%esp)
     23a:	e8 81 0b 00 00       	call   dc0 <memset>
  gets(buf, nbuf);
     23f:	8b 45 0c             	mov    0xc(%ebp),%eax
     242:	89 44 24 04          	mov    %eax,0x4(%esp)
     246:	8b 45 08             	mov    0x8(%ebp),%eax
     249:	89 04 24             	mov    %eax,(%esp)
     24c:	e8 c6 0b 00 00       	call   e17 <gets>
  if(buf[0] == 0) // EOF
     251:	8b 45 08             	mov    0x8(%ebp),%eax
     254:	0f b6 00             	movzbl (%eax),%eax
     257:	84 c0                	test   %al,%al
     259:	75 07                	jne    262 <getcmd+0x57>
    return -1;
     25b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     260:	eb 05                	jmp    267 <getcmd+0x5c>
  return 0;
     262:	b8 00 00 00 00       	mov    $0x0,%eax
}
     267:	c9                   	leave  
     268:	c3                   	ret    

00000269 <main>:

int
main(void)
{
     269:	55                   	push   %ebp
     26a:	89 e5                	mov    %esp,%ebp
     26c:	83 e4 f0             	and    $0xfffffff0,%esp
     26f:	83 ec 20             	sub    $0x20,%esp
  static char buf[100];
  int fd;

  settickets(20); 
     272:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
     279:	e8 97 0d 00 00       	call   1015 <settickets>

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     27e:	eb 15                	jmp    295 <main+0x2c>
    if(fd >= 3){
     280:	83 7c 24 1c 02       	cmpl   $0x2,0x1c(%esp)
     285:	7e 0e                	jle    295 <main+0x2c>
      close(fd);
     287:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     28b:	89 04 24             	mov    %eax,(%esp)
     28e:	e8 02 0d 00 00       	call   f95 <close>
      break;
     293:	eb 1f                	jmp    2b4 <main+0x4b>
  int fd;

  settickets(20); 

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     295:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     29c:	00 
     29d:	c7 04 24 bf 15 00 00 	movl   $0x15bf,(%esp)
     2a4:	e8 04 0d 00 00       	call   fad <open>
     2a9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     2ad:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
     2b2:	79 cc                	jns    280 <main+0x17>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2b4:	e9 89 00 00 00       	jmp    342 <main+0xd9>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2b9:	0f b6 05 40 1b 00 00 	movzbl 0x1b40,%eax
     2c0:	3c 63                	cmp    $0x63,%al
     2c2:	75 5c                	jne    320 <main+0xb7>
     2c4:	0f b6 05 41 1b 00 00 	movzbl 0x1b41,%eax
     2cb:	3c 64                	cmp    $0x64,%al
     2cd:	75 51                	jne    320 <main+0xb7>
     2cf:	0f b6 05 42 1b 00 00 	movzbl 0x1b42,%eax
     2d6:	3c 20                	cmp    $0x20,%al
     2d8:	75 46                	jne    320 <main+0xb7>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     2da:	c7 04 24 40 1b 00 00 	movl   $0x1b40,(%esp)
     2e1:	e8 b3 0a 00 00       	call   d99 <strlen>
     2e6:	83 e8 01             	sub    $0x1,%eax
     2e9:	c6 80 40 1b 00 00 00 	movb   $0x0,0x1b40(%eax)
      if(chdir(buf+3) < 0)
     2f0:	c7 04 24 43 1b 00 00 	movl   $0x1b43,(%esp)
     2f7:	e8 e1 0c 00 00       	call   fdd <chdir>
     2fc:	85 c0                	test   %eax,%eax
     2fe:	79 1e                	jns    31e <main+0xb5>
        printf(2, "cannot cd %s\n", buf+3);
     300:	c7 44 24 08 43 1b 00 	movl   $0x1b43,0x8(%esp)
     307:	00 
     308:	c7 44 24 04 c7 15 00 	movl   $0x15c7,0x4(%esp)
     30f:	00 
     310:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     317:	e8 52 0e 00 00       	call   116e <printf>
      continue;
     31c:	eb 24                	jmp    342 <main+0xd9>
     31e:	eb 22                	jmp    342 <main+0xd9>
    }
    if(fork1() == 0)
     320:	e8 64 00 00 00       	call   389 <fork1>
     325:	85 c0                	test   %eax,%eax
     327:	75 14                	jne    33d <main+0xd4>
      runcmd(parsecmd(buf));
     329:	c7 04 24 40 1b 00 00 	movl   $0x1b40,(%esp)
     330:	e8 c9 03 00 00       	call   6fe <parsecmd>
     335:	89 04 24             	mov    %eax,(%esp)
     338:	e8 c3 fc ff ff       	call   0 <runcmd>
    wait();
     33d:	e8 33 0c 00 00       	call   f75 <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     342:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     349:	00 
     34a:	c7 04 24 40 1b 00 00 	movl   $0x1b40,(%esp)
     351:	e8 b5 fe ff ff       	call   20b <getcmd>
     356:	85 c0                	test   %eax,%eax
     358:	0f 89 5b ff ff ff    	jns    2b9 <main+0x50>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     35e:	e8 0a 0c 00 00       	call   f6d <exit>

00000363 <panic>:
}

void
panic(char *s)
{
     363:	55                   	push   %ebp
     364:	89 e5                	mov    %esp,%ebp
     366:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     369:	8b 45 08             	mov    0x8(%ebp),%eax
     36c:	89 44 24 08          	mov    %eax,0x8(%esp)
     370:	c7 44 24 04 d5 15 00 	movl   $0x15d5,0x4(%esp)
     377:	00 
     378:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     37f:	e8 ea 0d 00 00       	call   116e <printf>
  exit();
     384:	e8 e4 0b 00 00       	call   f6d <exit>

00000389 <fork1>:
}

int
fork1(void)
{
     389:	55                   	push   %ebp
     38a:	89 e5                	mov    %esp,%ebp
     38c:	83 ec 28             	sub    $0x28,%esp
  int pid;

  pid = fork();
     38f:	e8 d1 0b 00 00       	call   f65 <fork>
     394:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     397:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     39b:	75 0c                	jne    3a9 <fork1+0x20>
    panic("fork");
     39d:	c7 04 24 d9 15 00 00 	movl   $0x15d9,(%esp)
     3a4:	e8 ba ff ff ff       	call   363 <panic>
  return pid;
     3a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3ac:	c9                   	leave  
     3ad:	c3                   	ret    

000003ae <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3ae:	55                   	push   %ebp
     3af:	89 e5                	mov    %esp,%ebp
     3b1:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b4:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3bb:	e8 d8 10 00 00       	call   1498 <malloc>
     3c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3c3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3ca:	00 
     3cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3d2:	00 
     3d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3d6:	89 04 24             	mov    %eax,(%esp)
     3d9:	e8 e2 09 00 00       	call   dc0 <memset>
  cmd->type = EXEC;
     3de:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3e1:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     3e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3ea:	c9                   	leave  
     3eb:	c3                   	ret    

000003ec <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3ec:	55                   	push   %ebp
     3ed:	89 e5                	mov    %esp,%ebp
     3ef:	83 ec 28             	sub    $0x28,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f2:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3f9:	e8 9a 10 00 00       	call   1498 <malloc>
     3fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     401:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     408:	00 
     409:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     410:	00 
     411:	8b 45 f4             	mov    -0xc(%ebp),%eax
     414:	89 04 24             	mov    %eax,(%esp)
     417:	e8 a4 09 00 00       	call   dc0 <memset>
  cmd->type = REDIR;
     41c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     41f:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     425:	8b 45 f4             	mov    -0xc(%ebp),%eax
     428:	8b 55 08             	mov    0x8(%ebp),%edx
     42b:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     42e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     431:	8b 55 0c             	mov    0xc(%ebp),%edx
     434:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     437:	8b 45 f4             	mov    -0xc(%ebp),%eax
     43a:	8b 55 10             	mov    0x10(%ebp),%edx
     43d:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     440:	8b 45 f4             	mov    -0xc(%ebp),%eax
     443:	8b 55 14             	mov    0x14(%ebp),%edx
     446:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     449:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44c:	8b 55 18             	mov    0x18(%ebp),%edx
     44f:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     452:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     455:	c9                   	leave  
     456:	c3                   	ret    

00000457 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     457:	55                   	push   %ebp
     458:	89 e5                	mov    %esp,%ebp
     45a:	83 ec 28             	sub    $0x28,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     45d:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     464:	e8 2f 10 00 00       	call   1498 <malloc>
     469:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     46c:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     473:	00 
     474:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     47b:	00 
     47c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47f:	89 04 24             	mov    %eax,(%esp)
     482:	e8 39 09 00 00       	call   dc0 <memset>
  cmd->type = PIPE;
     487:	8b 45 f4             	mov    -0xc(%ebp),%eax
     48a:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     490:	8b 45 f4             	mov    -0xc(%ebp),%eax
     493:	8b 55 08             	mov    0x8(%ebp),%edx
     496:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     499:	8b 45 f4             	mov    -0xc(%ebp),%eax
     49c:	8b 55 0c             	mov    0xc(%ebp),%edx
     49f:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4a5:	c9                   	leave  
     4a6:	c3                   	ret    

000004a7 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4a7:	55                   	push   %ebp
     4a8:	89 e5                	mov    %esp,%ebp
     4aa:	83 ec 28             	sub    $0x28,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4ad:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     4b4:	e8 df 0f 00 00       	call   1498 <malloc>
     4b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4bc:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     4c3:	00 
     4c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4cb:	00 
     4cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4cf:	89 04 24             	mov    %eax,(%esp)
     4d2:	e8 e9 08 00 00       	call   dc0 <memset>
  cmd->type = LIST;
     4d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4da:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e3:	8b 55 08             	mov    0x8(%ebp),%edx
     4e6:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ec:	8b 55 0c             	mov    0xc(%ebp),%edx
     4ef:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4f5:	c9                   	leave  
     4f6:	c3                   	ret    

000004f7 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4f7:	55                   	push   %ebp
     4f8:	89 e5                	mov    %esp,%ebp
     4fa:	83 ec 28             	sub    $0x28,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     504:	e8 8f 0f 00 00       	call   1498 <malloc>
     509:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     50c:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     513:	00 
     514:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     51b:	00 
     51c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     51f:	89 04 24             	mov    %eax,(%esp)
     522:	e8 99 08 00 00       	call   dc0 <memset>
  cmd->type = BACK;
     527:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52a:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     530:	8b 45 f4             	mov    -0xc(%ebp),%eax
     533:	8b 55 08             	mov    0x8(%ebp),%edx
     536:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     539:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     53c:	c9                   	leave  
     53d:	c3                   	ret    

0000053e <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     53e:	55                   	push   %ebp
     53f:	89 e5                	mov    %esp,%ebp
     541:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int ret;

  s = *ps;
     544:	8b 45 08             	mov    0x8(%ebp),%eax
     547:	8b 00                	mov    (%eax),%eax
     549:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     54c:	eb 04                	jmp    552 <gettoken+0x14>
    s++;
     54e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     552:	8b 45 f4             	mov    -0xc(%ebp),%eax
     555:	3b 45 0c             	cmp    0xc(%ebp),%eax
     558:	73 1d                	jae    577 <gettoken+0x39>
     55a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55d:	0f b6 00             	movzbl (%eax),%eax
     560:	0f be c0             	movsbl %al,%eax
     563:	89 44 24 04          	mov    %eax,0x4(%esp)
     567:	c7 04 24 10 1b 00 00 	movl   $0x1b10,(%esp)
     56e:	e8 71 08 00 00       	call   de4 <strchr>
     573:	85 c0                	test   %eax,%eax
     575:	75 d7                	jne    54e <gettoken+0x10>
    s++;
  if(q)
     577:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     57b:	74 08                	je     585 <gettoken+0x47>
    *q = s;
     57d:	8b 45 10             	mov    0x10(%ebp),%eax
     580:	8b 55 f4             	mov    -0xc(%ebp),%edx
     583:	89 10                	mov    %edx,(%eax)
  ret = *s;
     585:	8b 45 f4             	mov    -0xc(%ebp),%eax
     588:	0f b6 00             	movzbl (%eax),%eax
     58b:	0f be c0             	movsbl %al,%eax
     58e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     591:	8b 45 f4             	mov    -0xc(%ebp),%eax
     594:	0f b6 00             	movzbl (%eax),%eax
     597:	0f be c0             	movsbl %al,%eax
     59a:	83 f8 29             	cmp    $0x29,%eax
     59d:	7f 14                	jg     5b3 <gettoken+0x75>
     59f:	83 f8 28             	cmp    $0x28,%eax
     5a2:	7d 28                	jge    5cc <gettoken+0x8e>
     5a4:	85 c0                	test   %eax,%eax
     5a6:	0f 84 94 00 00 00    	je     640 <gettoken+0x102>
     5ac:	83 f8 26             	cmp    $0x26,%eax
     5af:	74 1b                	je     5cc <gettoken+0x8e>
     5b1:	eb 3c                	jmp    5ef <gettoken+0xb1>
     5b3:	83 f8 3e             	cmp    $0x3e,%eax
     5b6:	74 1a                	je     5d2 <gettoken+0x94>
     5b8:	83 f8 3e             	cmp    $0x3e,%eax
     5bb:	7f 0a                	jg     5c7 <gettoken+0x89>
     5bd:	83 e8 3b             	sub    $0x3b,%eax
     5c0:	83 f8 01             	cmp    $0x1,%eax
     5c3:	77 2a                	ja     5ef <gettoken+0xb1>
     5c5:	eb 05                	jmp    5cc <gettoken+0x8e>
     5c7:	83 f8 7c             	cmp    $0x7c,%eax
     5ca:	75 23                	jne    5ef <gettoken+0xb1>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5d0:	eb 6f                	jmp    641 <gettoken+0x103>
  case '>':
    s++;
     5d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5d9:	0f b6 00             	movzbl (%eax),%eax
     5dc:	3c 3e                	cmp    $0x3e,%al
     5de:	75 0d                	jne    5ed <gettoken+0xaf>
      ret = '+';
     5e0:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     5eb:	eb 54                	jmp    641 <gettoken+0x103>
     5ed:	eb 52                	jmp    641 <gettoken+0x103>
  default:
    ret = 'a';
     5ef:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f6:	eb 04                	jmp    5fc <gettoken+0xbe>
      s++;
     5f8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ff:	3b 45 0c             	cmp    0xc(%ebp),%eax
     602:	73 3a                	jae    63e <gettoken+0x100>
     604:	8b 45 f4             	mov    -0xc(%ebp),%eax
     607:	0f b6 00             	movzbl (%eax),%eax
     60a:	0f be c0             	movsbl %al,%eax
     60d:	89 44 24 04          	mov    %eax,0x4(%esp)
     611:	c7 04 24 10 1b 00 00 	movl   $0x1b10,(%esp)
     618:	e8 c7 07 00 00       	call   de4 <strchr>
     61d:	85 c0                	test   %eax,%eax
     61f:	75 1d                	jne    63e <gettoken+0x100>
     621:	8b 45 f4             	mov    -0xc(%ebp),%eax
     624:	0f b6 00             	movzbl (%eax),%eax
     627:	0f be c0             	movsbl %al,%eax
     62a:	89 44 24 04          	mov    %eax,0x4(%esp)
     62e:	c7 04 24 16 1b 00 00 	movl   $0x1b16,(%esp)
     635:	e8 aa 07 00 00       	call   de4 <strchr>
     63a:	85 c0                	test   %eax,%eax
     63c:	74 ba                	je     5f8 <gettoken+0xba>
      s++;
    break;
     63e:	eb 01                	jmp    641 <gettoken+0x103>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     640:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     641:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     645:	74 0a                	je     651 <gettoken+0x113>
    *eq = s;
     647:	8b 45 14             	mov    0x14(%ebp),%eax
     64a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     64d:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
     64f:	eb 06                	jmp    657 <gettoken+0x119>
     651:	eb 04                	jmp    657 <gettoken+0x119>
    s++;
     653:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     657:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     65d:	73 1d                	jae    67c <gettoken+0x13e>
     65f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     662:	0f b6 00             	movzbl (%eax),%eax
     665:	0f be c0             	movsbl %al,%eax
     668:	89 44 24 04          	mov    %eax,0x4(%esp)
     66c:	c7 04 24 10 1b 00 00 	movl   $0x1b10,(%esp)
     673:	e8 6c 07 00 00       	call   de4 <strchr>
     678:	85 c0                	test   %eax,%eax
     67a:	75 d7                	jne    653 <gettoken+0x115>
    s++;
  *ps = s;
     67c:	8b 45 08             	mov    0x8(%ebp),%eax
     67f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     682:	89 10                	mov    %edx,(%eax)
  return ret;
     684:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     687:	c9                   	leave  
     688:	c3                   	ret    

00000689 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     689:	55                   	push   %ebp
     68a:	89 e5                	mov    %esp,%ebp
     68c:	83 ec 28             	sub    $0x28,%esp
  char *s;

  s = *ps;
     68f:	8b 45 08             	mov    0x8(%ebp),%eax
     692:	8b 00                	mov    (%eax),%eax
     694:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     697:	eb 04                	jmp    69d <peek+0x14>
    s++;
     699:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     69d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6a3:	73 1d                	jae    6c2 <peek+0x39>
     6a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a8:	0f b6 00             	movzbl (%eax),%eax
     6ab:	0f be c0             	movsbl %al,%eax
     6ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     6b2:	c7 04 24 10 1b 00 00 	movl   $0x1b10,(%esp)
     6b9:	e8 26 07 00 00       	call   de4 <strchr>
     6be:	85 c0                	test   %eax,%eax
     6c0:	75 d7                	jne    699 <peek+0x10>
    s++;
  *ps = s;
     6c2:	8b 45 08             	mov    0x8(%ebp),%eax
     6c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6c8:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6cd:	0f b6 00             	movzbl (%eax),%eax
     6d0:	84 c0                	test   %al,%al
     6d2:	74 23                	je     6f7 <peek+0x6e>
     6d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d7:	0f b6 00             	movzbl (%eax),%eax
     6da:	0f be c0             	movsbl %al,%eax
     6dd:	89 44 24 04          	mov    %eax,0x4(%esp)
     6e1:	8b 45 10             	mov    0x10(%ebp),%eax
     6e4:	89 04 24             	mov    %eax,(%esp)
     6e7:	e8 f8 06 00 00       	call   de4 <strchr>
     6ec:	85 c0                	test   %eax,%eax
     6ee:	74 07                	je     6f7 <peek+0x6e>
     6f0:	b8 01 00 00 00       	mov    $0x1,%eax
     6f5:	eb 05                	jmp    6fc <peek+0x73>
     6f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     6fc:	c9                   	leave  
     6fd:	c3                   	ret    

000006fe <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     6fe:	55                   	push   %ebp
     6ff:	89 e5                	mov    %esp,%ebp
     701:	53                   	push   %ebx
     702:	83 ec 24             	sub    $0x24,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     705:	8b 5d 08             	mov    0x8(%ebp),%ebx
     708:	8b 45 08             	mov    0x8(%ebp),%eax
     70b:	89 04 24             	mov    %eax,(%esp)
     70e:	e8 86 06 00 00       	call   d99 <strlen>
     713:	01 d8                	add    %ebx,%eax
     715:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     718:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71b:	89 44 24 04          	mov    %eax,0x4(%esp)
     71f:	8d 45 08             	lea    0x8(%ebp),%eax
     722:	89 04 24             	mov    %eax,(%esp)
     725:	e8 60 00 00 00       	call   78a <parseline>
     72a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     72d:	c7 44 24 08 de 15 00 	movl   $0x15de,0x8(%esp)
     734:	00 
     735:	8b 45 f4             	mov    -0xc(%ebp),%eax
     738:	89 44 24 04          	mov    %eax,0x4(%esp)
     73c:	8d 45 08             	lea    0x8(%ebp),%eax
     73f:	89 04 24             	mov    %eax,(%esp)
     742:	e8 42 ff ff ff       	call   689 <peek>
  if(s != es){
     747:	8b 45 08             	mov    0x8(%ebp),%eax
     74a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     74d:	74 27                	je     776 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     74f:	8b 45 08             	mov    0x8(%ebp),%eax
     752:	89 44 24 08          	mov    %eax,0x8(%esp)
     756:	c7 44 24 04 df 15 00 	movl   $0x15df,0x4(%esp)
     75d:	00 
     75e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     765:	e8 04 0a 00 00       	call   116e <printf>
    panic("syntax");
     76a:	c7 04 24 ee 15 00 00 	movl   $0x15ee,(%esp)
     771:	e8 ed fb ff ff       	call   363 <panic>
  }
  nulterminate(cmd);
     776:	8b 45 f0             	mov    -0x10(%ebp),%eax
     779:	89 04 24             	mov    %eax,(%esp)
     77c:	e8 a3 04 00 00       	call   c24 <nulterminate>
  return cmd;
     781:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     784:	83 c4 24             	add    $0x24,%esp
     787:	5b                   	pop    %ebx
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    

0000078a <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     78a:	55                   	push   %ebp
     78b:	89 e5                	mov    %esp,%ebp
     78d:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     790:	8b 45 0c             	mov    0xc(%ebp),%eax
     793:	89 44 24 04          	mov    %eax,0x4(%esp)
     797:	8b 45 08             	mov    0x8(%ebp),%eax
     79a:	89 04 24             	mov    %eax,(%esp)
     79d:	e8 bc 00 00 00       	call   85e <parsepipe>
     7a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7a5:	eb 30                	jmp    7d7 <parseline+0x4d>
    gettoken(ps, es, 0, 0);
     7a7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     7ae:	00 
     7af:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     7b6:	00 
     7b7:	8b 45 0c             	mov    0xc(%ebp),%eax
     7ba:	89 44 24 04          	mov    %eax,0x4(%esp)
     7be:	8b 45 08             	mov    0x8(%ebp),%eax
     7c1:	89 04 24             	mov    %eax,(%esp)
     7c4:	e8 75 fd ff ff       	call   53e <gettoken>
    cmd = backcmd(cmd);
     7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cc:	89 04 24             	mov    %eax,(%esp)
     7cf:	e8 23 fd ff ff       	call   4f7 <backcmd>
     7d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     7d7:	c7 44 24 08 f5 15 00 	movl   $0x15f5,0x8(%esp)
     7de:	00 
     7df:	8b 45 0c             	mov    0xc(%ebp),%eax
     7e2:	89 44 24 04          	mov    %eax,0x4(%esp)
     7e6:	8b 45 08             	mov    0x8(%ebp),%eax
     7e9:	89 04 24             	mov    %eax,(%esp)
     7ec:	e8 98 fe ff ff       	call   689 <peek>
     7f1:	85 c0                	test   %eax,%eax
     7f3:	75 b2                	jne    7a7 <parseline+0x1d>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     7f5:	c7 44 24 08 f7 15 00 	movl   $0x15f7,0x8(%esp)
     7fc:	00 
     7fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     800:	89 44 24 04          	mov    %eax,0x4(%esp)
     804:	8b 45 08             	mov    0x8(%ebp),%eax
     807:	89 04 24             	mov    %eax,(%esp)
     80a:	e8 7a fe ff ff       	call   689 <peek>
     80f:	85 c0                	test   %eax,%eax
     811:	74 46                	je     859 <parseline+0xcf>
    gettoken(ps, es, 0, 0);
     813:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     81a:	00 
     81b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     822:	00 
     823:	8b 45 0c             	mov    0xc(%ebp),%eax
     826:	89 44 24 04          	mov    %eax,0x4(%esp)
     82a:	8b 45 08             	mov    0x8(%ebp),%eax
     82d:	89 04 24             	mov    %eax,(%esp)
     830:	e8 09 fd ff ff       	call   53e <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     835:	8b 45 0c             	mov    0xc(%ebp),%eax
     838:	89 44 24 04          	mov    %eax,0x4(%esp)
     83c:	8b 45 08             	mov    0x8(%ebp),%eax
     83f:	89 04 24             	mov    %eax,(%esp)
     842:	e8 43 ff ff ff       	call   78a <parseline>
     847:	89 44 24 04          	mov    %eax,0x4(%esp)
     84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84e:	89 04 24             	mov    %eax,(%esp)
     851:	e8 51 fc ff ff       	call   4a7 <listcmd>
     856:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     859:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     85c:	c9                   	leave  
     85d:	c3                   	ret    

0000085e <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     85e:	55                   	push   %ebp
     85f:	89 e5                	mov    %esp,%ebp
     861:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     864:	8b 45 0c             	mov    0xc(%ebp),%eax
     867:	89 44 24 04          	mov    %eax,0x4(%esp)
     86b:	8b 45 08             	mov    0x8(%ebp),%eax
     86e:	89 04 24             	mov    %eax,(%esp)
     871:	e8 68 02 00 00       	call   ade <parseexec>
     876:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     879:	c7 44 24 08 f9 15 00 	movl   $0x15f9,0x8(%esp)
     880:	00 
     881:	8b 45 0c             	mov    0xc(%ebp),%eax
     884:	89 44 24 04          	mov    %eax,0x4(%esp)
     888:	8b 45 08             	mov    0x8(%ebp),%eax
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 f6 fd ff ff       	call   689 <peek>
     893:	85 c0                	test   %eax,%eax
     895:	74 46                	je     8dd <parsepipe+0x7f>
    gettoken(ps, es, 0, 0);
     897:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     89e:	00 
     89f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8a6:	00 
     8a7:	8b 45 0c             	mov    0xc(%ebp),%eax
     8aa:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ae:	8b 45 08             	mov    0x8(%ebp),%eax
     8b1:	89 04 24             	mov    %eax,(%esp)
     8b4:	e8 85 fc ff ff       	call   53e <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     8bc:	89 44 24 04          	mov    %eax,0x4(%esp)
     8c0:	8b 45 08             	mov    0x8(%ebp),%eax
     8c3:	89 04 24             	mov    %eax,(%esp)
     8c6:	e8 93 ff ff ff       	call   85e <parsepipe>
     8cb:	89 44 24 04          	mov    %eax,0x4(%esp)
     8cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d2:	89 04 24             	mov    %eax,(%esp)
     8d5:	e8 7d fb ff ff       	call   457 <pipecmd>
     8da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8e0:	c9                   	leave  
     8e1:	c3                   	ret    

000008e2 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8e2:	55                   	push   %ebp
     8e3:	89 e5                	mov    %esp,%ebp
     8e5:	83 ec 38             	sub    $0x38,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8e8:	e9 f6 00 00 00       	jmp    9e3 <parseredirs+0x101>
    tok = gettoken(ps, es, 0, 0);
     8ed:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8f4:	00 
     8f5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8fc:	00 
     8fd:	8b 45 10             	mov    0x10(%ebp),%eax
     900:	89 44 24 04          	mov    %eax,0x4(%esp)
     904:	8b 45 0c             	mov    0xc(%ebp),%eax
     907:	89 04 24             	mov    %eax,(%esp)
     90a:	e8 2f fc ff ff       	call   53e <gettoken>
     90f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     912:	8d 45 ec             	lea    -0x14(%ebp),%eax
     915:	89 44 24 0c          	mov    %eax,0xc(%esp)
     919:	8d 45 f0             	lea    -0x10(%ebp),%eax
     91c:	89 44 24 08          	mov    %eax,0x8(%esp)
     920:	8b 45 10             	mov    0x10(%ebp),%eax
     923:	89 44 24 04          	mov    %eax,0x4(%esp)
     927:	8b 45 0c             	mov    0xc(%ebp),%eax
     92a:	89 04 24             	mov    %eax,(%esp)
     92d:	e8 0c fc ff ff       	call   53e <gettoken>
     932:	83 f8 61             	cmp    $0x61,%eax
     935:	74 0c                	je     943 <parseredirs+0x61>
      panic("missing file for redirection");
     937:	c7 04 24 fb 15 00 00 	movl   $0x15fb,(%esp)
     93e:	e8 20 fa ff ff       	call   363 <panic>
    switch(tok){
     943:	8b 45 f4             	mov    -0xc(%ebp),%eax
     946:	83 f8 3c             	cmp    $0x3c,%eax
     949:	74 0f                	je     95a <parseredirs+0x78>
     94b:	83 f8 3e             	cmp    $0x3e,%eax
     94e:	74 38                	je     988 <parseredirs+0xa6>
     950:	83 f8 2b             	cmp    $0x2b,%eax
     953:	74 61                	je     9b6 <parseredirs+0xd4>
     955:	e9 89 00 00 00       	jmp    9e3 <parseredirs+0x101>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     95a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     95d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     960:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     967:	00 
     968:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     96f:	00 
     970:	89 54 24 08          	mov    %edx,0x8(%esp)
     974:	89 44 24 04          	mov    %eax,0x4(%esp)
     978:	8b 45 08             	mov    0x8(%ebp),%eax
     97b:	89 04 24             	mov    %eax,(%esp)
     97e:	e8 69 fa ff ff       	call   3ec <redircmd>
     983:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     986:	eb 5b                	jmp    9e3 <parseredirs+0x101>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     988:	8b 55 ec             	mov    -0x14(%ebp),%edx
     98b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     98e:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     995:	00 
     996:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     99d:	00 
     99e:	89 54 24 08          	mov    %edx,0x8(%esp)
     9a2:	89 44 24 04          	mov    %eax,0x4(%esp)
     9a6:	8b 45 08             	mov    0x8(%ebp),%eax
     9a9:	89 04 24             	mov    %eax,(%esp)
     9ac:	e8 3b fa ff ff       	call   3ec <redircmd>
     9b1:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     9b4:	eb 2d                	jmp    9e3 <parseredirs+0x101>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     9b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     9b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9bc:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     9c3:	00 
     9c4:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     9cb:	00 
     9cc:	89 54 24 08          	mov    %edx,0x8(%esp)
     9d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     9d4:	8b 45 08             	mov    0x8(%ebp),%eax
     9d7:	89 04 24             	mov    %eax,(%esp)
     9da:	e8 0d fa ff ff       	call   3ec <redircmd>
     9df:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     9e2:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     9e3:	c7 44 24 08 18 16 00 	movl   $0x1618,0x8(%esp)
     9ea:	00 
     9eb:	8b 45 10             	mov    0x10(%ebp),%eax
     9ee:	89 44 24 04          	mov    %eax,0x4(%esp)
     9f2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9f5:	89 04 24             	mov    %eax,(%esp)
     9f8:	e8 8c fc ff ff       	call   689 <peek>
     9fd:	85 c0                	test   %eax,%eax
     9ff:	0f 85 e8 fe ff ff    	jne    8ed <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     a05:	8b 45 08             	mov    0x8(%ebp),%eax
}
     a08:	c9                   	leave  
     a09:	c3                   	ret    

00000a0a <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     a0a:	55                   	push   %ebp
     a0b:	89 e5                	mov    %esp,%ebp
     a0d:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     a10:	c7 44 24 08 1b 16 00 	movl   $0x161b,0x8(%esp)
     a17:	00 
     a18:	8b 45 0c             	mov    0xc(%ebp),%eax
     a1b:	89 44 24 04          	mov    %eax,0x4(%esp)
     a1f:	8b 45 08             	mov    0x8(%ebp),%eax
     a22:	89 04 24             	mov    %eax,(%esp)
     a25:	e8 5f fc ff ff       	call   689 <peek>
     a2a:	85 c0                	test   %eax,%eax
     a2c:	75 0c                	jne    a3a <parseblock+0x30>
    panic("parseblock");
     a2e:	c7 04 24 1d 16 00 00 	movl   $0x161d,(%esp)
     a35:	e8 29 f9 ff ff       	call   363 <panic>
  gettoken(ps, es, 0, 0);
     a3a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a41:	00 
     a42:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a49:	00 
     a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a4d:	89 44 24 04          	mov    %eax,0x4(%esp)
     a51:	8b 45 08             	mov    0x8(%ebp),%eax
     a54:	89 04 24             	mov    %eax,(%esp)
     a57:	e8 e2 fa ff ff       	call   53e <gettoken>
  cmd = parseline(ps, es);
     a5c:	8b 45 0c             	mov    0xc(%ebp),%eax
     a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
     a63:	8b 45 08             	mov    0x8(%ebp),%eax
     a66:	89 04 24             	mov    %eax,(%esp)
     a69:	e8 1c fd ff ff       	call   78a <parseline>
     a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     a71:	c7 44 24 08 28 16 00 	movl   $0x1628,0x8(%esp)
     a78:	00 
     a79:	8b 45 0c             	mov    0xc(%ebp),%eax
     a7c:	89 44 24 04          	mov    %eax,0x4(%esp)
     a80:	8b 45 08             	mov    0x8(%ebp),%eax
     a83:	89 04 24             	mov    %eax,(%esp)
     a86:	e8 fe fb ff ff       	call   689 <peek>
     a8b:	85 c0                	test   %eax,%eax
     a8d:	75 0c                	jne    a9b <parseblock+0x91>
    panic("syntax - missing )");
     a8f:	c7 04 24 2a 16 00 00 	movl   $0x162a,(%esp)
     a96:	e8 c8 f8 ff ff       	call   363 <panic>
  gettoken(ps, es, 0, 0);
     a9b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     aa2:	00 
     aa3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     aaa:	00 
     aab:	8b 45 0c             	mov    0xc(%ebp),%eax
     aae:	89 44 24 04          	mov    %eax,0x4(%esp)
     ab2:	8b 45 08             	mov    0x8(%ebp),%eax
     ab5:	89 04 24             	mov    %eax,(%esp)
     ab8:	e8 81 fa ff ff       	call   53e <gettoken>
  cmd = parseredirs(cmd, ps, es);
     abd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ac0:	89 44 24 08          	mov    %eax,0x8(%esp)
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	89 44 24 04          	mov    %eax,0x4(%esp)
     acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ace:	89 04 24             	mov    %eax,(%esp)
     ad1:	e8 0c fe ff ff       	call   8e2 <parseredirs>
     ad6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     adc:	c9                   	leave  
     add:	c3                   	ret    

00000ade <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     ade:	55                   	push   %ebp
     adf:	89 e5                	mov    %esp,%ebp
     ae1:	83 ec 38             	sub    $0x38,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     ae4:	c7 44 24 08 1b 16 00 	movl   $0x161b,0x8(%esp)
     aeb:	00 
     aec:	8b 45 0c             	mov    0xc(%ebp),%eax
     aef:	89 44 24 04          	mov    %eax,0x4(%esp)
     af3:	8b 45 08             	mov    0x8(%ebp),%eax
     af6:	89 04 24             	mov    %eax,(%esp)
     af9:	e8 8b fb ff ff       	call   689 <peek>
     afe:	85 c0                	test   %eax,%eax
     b00:	74 17                	je     b19 <parseexec+0x3b>
    return parseblock(ps, es);
     b02:	8b 45 0c             	mov    0xc(%ebp),%eax
     b05:	89 44 24 04          	mov    %eax,0x4(%esp)
     b09:	8b 45 08             	mov    0x8(%ebp),%eax
     b0c:	89 04 24             	mov    %eax,(%esp)
     b0f:	e8 f6 fe ff ff       	call   a0a <parseblock>
     b14:	e9 09 01 00 00       	jmp    c22 <parseexec+0x144>

  ret = execcmd();
     b19:	e8 90 f8 ff ff       	call   3ae <execcmd>
     b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     b21:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b24:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     b27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     b2e:	8b 45 0c             	mov    0xc(%ebp),%eax
     b31:	89 44 24 08          	mov    %eax,0x8(%esp)
     b35:	8b 45 08             	mov    0x8(%ebp),%eax
     b38:	89 44 24 04          	mov    %eax,0x4(%esp)
     b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b3f:	89 04 24             	mov    %eax,(%esp)
     b42:	e8 9b fd ff ff       	call   8e2 <parseredirs>
     b47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     b4a:	e9 8f 00 00 00       	jmp    bde <parseexec+0x100>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     b4f:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b52:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b56:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b59:	89 44 24 08          	mov    %eax,0x8(%esp)
     b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     b60:	89 44 24 04          	mov    %eax,0x4(%esp)
     b64:	8b 45 08             	mov    0x8(%ebp),%eax
     b67:	89 04 24             	mov    %eax,(%esp)
     b6a:	e8 cf f9 ff ff       	call   53e <gettoken>
     b6f:	89 45 e8             	mov    %eax,-0x18(%ebp)
     b72:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     b76:	75 05                	jne    b7d <parseexec+0x9f>
      break;
     b78:	e9 83 00 00 00       	jmp    c00 <parseexec+0x122>
    if(tok != 'a')
     b7d:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     b81:	74 0c                	je     b8f <parseexec+0xb1>
      panic("syntax");
     b83:	c7 04 24 ee 15 00 00 	movl   $0x15ee,(%esp)
     b8a:	e8 d4 f7 ff ff       	call   363 <panic>
    cmd->argv[argc] = q;
     b8f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     b92:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b95:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b98:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     b9c:	8b 55 e0             	mov    -0x20(%ebp),%edx
     b9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ba2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     ba5:	83 c1 08             	add    $0x8,%ecx
     ba8:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     bac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     bb0:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     bb4:	7e 0c                	jle    bc2 <parseexec+0xe4>
      panic("too many args");
     bb6:	c7 04 24 3d 16 00 00 	movl   $0x163d,(%esp)
     bbd:	e8 a1 f7 ff ff       	call   363 <panic>
    ret = parseredirs(ret, ps, es);
     bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc5:	89 44 24 08          	mov    %eax,0x8(%esp)
     bc9:	8b 45 08             	mov    0x8(%ebp),%eax
     bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
     bd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd3:	89 04 24             	mov    %eax,(%esp)
     bd6:	e8 07 fd ff ff       	call   8e2 <parseredirs>
     bdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     bde:	c7 44 24 08 4b 16 00 	movl   $0x164b,0x8(%esp)
     be5:	00 
     be6:	8b 45 0c             	mov    0xc(%ebp),%eax
     be9:	89 44 24 04          	mov    %eax,0x4(%esp)
     bed:	8b 45 08             	mov    0x8(%ebp),%eax
     bf0:	89 04 24             	mov    %eax,(%esp)
     bf3:	e8 91 fa ff ff       	call   689 <peek>
     bf8:	85 c0                	test   %eax,%eax
     bfa:	0f 84 4f ff ff ff    	je     b4f <parseexec+0x71>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     c00:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c03:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c06:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     c0d:	00 
  cmd->eargv[argc] = 0;
     c0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c11:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c14:	83 c2 08             	add    $0x8,%edx
     c17:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     c1e:	00 
  return ret;
     c1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     c22:	c9                   	leave  
     c23:	c3                   	ret    

00000c24 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c24:	55                   	push   %ebp
     c25:	89 e5                	mov    %esp,%ebp
     c27:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     c2a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     c2e:	75 0a                	jne    c3a <nulterminate+0x16>
    return 0;
     c30:	b8 00 00 00 00       	mov    $0x0,%eax
     c35:	e9 c9 00 00 00       	jmp    d03 <nulterminate+0xdf>

  switch(cmd->type){
     c3a:	8b 45 08             	mov    0x8(%ebp),%eax
     c3d:	8b 00                	mov    (%eax),%eax
     c3f:	83 f8 05             	cmp    $0x5,%eax
     c42:	0f 87 b8 00 00 00    	ja     d00 <nulterminate+0xdc>
     c48:	8b 04 85 50 16 00 00 	mov    0x1650(,%eax,4),%eax
     c4f:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     c57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c5e:	eb 14                	jmp    c74 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     c60:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c63:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c66:	83 c2 08             	add    $0x8,%edx
     c69:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     c6d:	c6 00 00             	movb   $0x0,(%eax)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     c70:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c77:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c7a:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     c7e:	85 c0                	test   %eax,%eax
     c80:	75 de                	jne    c60 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     c82:	eb 7c                	jmp    d00 <nulterminate+0xdc>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     c8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c8d:	8b 40 04             	mov    0x4(%eax),%eax
     c90:	89 04 24             	mov    %eax,(%esp)
     c93:	e8 8c ff ff ff       	call   c24 <nulterminate>
    *rcmd->efile = 0;
     c98:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c9b:	8b 40 0c             	mov    0xc(%eax),%eax
     c9e:	c6 00 00             	movb   $0x0,(%eax)
    break;
     ca1:	eb 5d                	jmp    d00 <nulterminate+0xdc>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     ca3:	8b 45 08             	mov    0x8(%ebp),%eax
     ca6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     ca9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cac:	8b 40 04             	mov    0x4(%eax),%eax
     caf:	89 04 24             	mov    %eax,(%esp)
     cb2:	e8 6d ff ff ff       	call   c24 <nulterminate>
    nulterminate(pcmd->right);
     cb7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cba:	8b 40 08             	mov    0x8(%eax),%eax
     cbd:	89 04 24             	mov    %eax,(%esp)
     cc0:	e8 5f ff ff ff       	call   c24 <nulterminate>
    break;
     cc5:	eb 39                	jmp    d00 <nulterminate+0xdc>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     cc7:	8b 45 08             	mov    0x8(%ebp),%eax
     cca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     ccd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cd0:	8b 40 04             	mov    0x4(%eax),%eax
     cd3:	89 04 24             	mov    %eax,(%esp)
     cd6:	e8 49 ff ff ff       	call   c24 <nulterminate>
    nulterminate(lcmd->right);
     cdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cde:	8b 40 08             	mov    0x8(%eax),%eax
     ce1:	89 04 24             	mov    %eax,(%esp)
     ce4:	e8 3b ff ff ff       	call   c24 <nulterminate>
    break;
     ce9:	eb 15                	jmp    d00 <nulterminate+0xdc>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     ceb:	8b 45 08             	mov    0x8(%ebp),%eax
     cee:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     cf1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cf4:	8b 40 04             	mov    0x4(%eax),%eax
     cf7:	89 04 24             	mov    %eax,(%esp)
     cfa:	e8 25 ff ff ff       	call   c24 <nulterminate>
    break;
     cff:	90                   	nop
  }
  return cmd;
     d00:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d03:	c9                   	leave  
     d04:	c3                   	ret    

00000d05 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     d05:	55                   	push   %ebp
     d06:	89 e5                	mov    %esp,%ebp
     d08:	57                   	push   %edi
     d09:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     d0a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d0d:	8b 55 10             	mov    0x10(%ebp),%edx
     d10:	8b 45 0c             	mov    0xc(%ebp),%eax
     d13:	89 cb                	mov    %ecx,%ebx
     d15:	89 df                	mov    %ebx,%edi
     d17:	89 d1                	mov    %edx,%ecx
     d19:	fc                   	cld    
     d1a:	f3 aa                	rep stos %al,%es:(%edi)
     d1c:	89 ca                	mov    %ecx,%edx
     d1e:	89 fb                	mov    %edi,%ebx
     d20:	89 5d 08             	mov    %ebx,0x8(%ebp)
     d23:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     d26:	5b                   	pop    %ebx
     d27:	5f                   	pop    %edi
     d28:	5d                   	pop    %ebp
     d29:	c3                   	ret    

00000d2a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     d2a:	55                   	push   %ebp
     d2b:	89 e5                	mov    %esp,%ebp
     d2d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     d30:	8b 45 08             	mov    0x8(%ebp),%eax
     d33:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     d36:	90                   	nop
     d37:	8b 45 08             	mov    0x8(%ebp),%eax
     d3a:	8d 50 01             	lea    0x1(%eax),%edx
     d3d:	89 55 08             	mov    %edx,0x8(%ebp)
     d40:	8b 55 0c             	mov    0xc(%ebp),%edx
     d43:	8d 4a 01             	lea    0x1(%edx),%ecx
     d46:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     d49:	0f b6 12             	movzbl (%edx),%edx
     d4c:	88 10                	mov    %dl,(%eax)
     d4e:	0f b6 00             	movzbl (%eax),%eax
     d51:	84 c0                	test   %al,%al
     d53:	75 e2                	jne    d37 <strcpy+0xd>
    ;
  return os;
     d55:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d58:	c9                   	leave  
     d59:	c3                   	ret    

00000d5a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d5a:	55                   	push   %ebp
     d5b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     d5d:	eb 08                	jmp    d67 <strcmp+0xd>
    p++, q++;
     d5f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d63:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     d67:	8b 45 08             	mov    0x8(%ebp),%eax
     d6a:	0f b6 00             	movzbl (%eax),%eax
     d6d:	84 c0                	test   %al,%al
     d6f:	74 10                	je     d81 <strcmp+0x27>
     d71:	8b 45 08             	mov    0x8(%ebp),%eax
     d74:	0f b6 10             	movzbl (%eax),%edx
     d77:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7a:	0f b6 00             	movzbl (%eax),%eax
     d7d:	38 c2                	cmp    %al,%dl
     d7f:	74 de                	je     d5f <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     d81:	8b 45 08             	mov    0x8(%ebp),%eax
     d84:	0f b6 00             	movzbl (%eax),%eax
     d87:	0f b6 d0             	movzbl %al,%edx
     d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8d:	0f b6 00             	movzbl (%eax),%eax
     d90:	0f b6 c0             	movzbl %al,%eax
     d93:	29 c2                	sub    %eax,%edx
     d95:	89 d0                	mov    %edx,%eax
}
     d97:	5d                   	pop    %ebp
     d98:	c3                   	ret    

00000d99 <strlen>:

uint
strlen(char *s)
{
     d99:	55                   	push   %ebp
     d9a:	89 e5                	mov    %esp,%ebp
     d9c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     da6:	eb 04                	jmp    dac <strlen+0x13>
     da8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     dac:	8b 55 fc             	mov    -0x4(%ebp),%edx
     daf:	8b 45 08             	mov    0x8(%ebp),%eax
     db2:	01 d0                	add    %edx,%eax
     db4:	0f b6 00             	movzbl (%eax),%eax
     db7:	84 c0                	test   %al,%al
     db9:	75 ed                	jne    da8 <strlen+0xf>
    ;
  return n;
     dbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     dbe:	c9                   	leave  
     dbf:	c3                   	ret    

00000dc0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     dc6:	8b 45 10             	mov    0x10(%ebp),%eax
     dc9:	89 44 24 08          	mov    %eax,0x8(%esp)
     dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd0:	89 44 24 04          	mov    %eax,0x4(%esp)
     dd4:	8b 45 08             	mov    0x8(%ebp),%eax
     dd7:	89 04 24             	mov    %eax,(%esp)
     dda:	e8 26 ff ff ff       	call   d05 <stosb>
  return dst;
     ddf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     de2:	c9                   	leave  
     de3:	c3                   	ret    

00000de4 <strchr>:

char*
strchr(const char *s, char c)
{
     de4:	55                   	push   %ebp
     de5:	89 e5                	mov    %esp,%ebp
     de7:	83 ec 04             	sub    $0x4,%esp
     dea:	8b 45 0c             	mov    0xc(%ebp),%eax
     ded:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     df0:	eb 14                	jmp    e06 <strchr+0x22>
    if(*s == c)
     df2:	8b 45 08             	mov    0x8(%ebp),%eax
     df5:	0f b6 00             	movzbl (%eax),%eax
     df8:	3a 45 fc             	cmp    -0x4(%ebp),%al
     dfb:	75 05                	jne    e02 <strchr+0x1e>
      return (char*)s;
     dfd:	8b 45 08             	mov    0x8(%ebp),%eax
     e00:	eb 13                	jmp    e15 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     e02:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e06:	8b 45 08             	mov    0x8(%ebp),%eax
     e09:	0f b6 00             	movzbl (%eax),%eax
     e0c:	84 c0                	test   %al,%al
     e0e:	75 e2                	jne    df2 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     e10:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e15:	c9                   	leave  
     e16:	c3                   	ret    

00000e17 <gets>:

char*
gets(char *buf, int max)
{
     e17:	55                   	push   %ebp
     e18:	89 e5                	mov    %esp,%ebp
     e1a:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e1d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e24:	eb 4c                	jmp    e72 <gets+0x5b>
    cc = read(0, &c, 1);
     e26:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e2d:	00 
     e2e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     e31:	89 44 24 04          	mov    %eax,0x4(%esp)
     e35:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e3c:	e8 44 01 00 00       	call   f85 <read>
     e41:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     e44:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e48:	7f 02                	jg     e4c <gets+0x35>
      break;
     e4a:	eb 31                	jmp    e7d <gets+0x66>
    buf[i++] = c;
     e4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4f:	8d 50 01             	lea    0x1(%eax),%edx
     e52:	89 55 f4             	mov    %edx,-0xc(%ebp)
     e55:	89 c2                	mov    %eax,%edx
     e57:	8b 45 08             	mov    0x8(%ebp),%eax
     e5a:	01 c2                	add    %eax,%edx
     e5c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e60:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     e62:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e66:	3c 0a                	cmp    $0xa,%al
     e68:	74 13                	je     e7d <gets+0x66>
     e6a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e6e:	3c 0d                	cmp    $0xd,%al
     e70:	74 0b                	je     e7d <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e75:	83 c0 01             	add    $0x1,%eax
     e78:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e7b:	7c a9                	jl     e26 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     e7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e80:	8b 45 08             	mov    0x8(%ebp),%eax
     e83:	01 d0                	add    %edx,%eax
     e85:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     e88:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e8b:	c9                   	leave  
     e8c:	c3                   	ret    

00000e8d <stat>:

int
stat(char *n, struct stat *st)
{
     e8d:	55                   	push   %ebp
     e8e:	89 e5                	mov    %esp,%ebp
     e90:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e93:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e9a:	00 
     e9b:	8b 45 08             	mov    0x8(%ebp),%eax
     e9e:	89 04 24             	mov    %eax,(%esp)
     ea1:	e8 07 01 00 00       	call   fad <open>
     ea6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     ea9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ead:	79 07                	jns    eb6 <stat+0x29>
    return -1;
     eaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     eb4:	eb 23                	jmp    ed9 <stat+0x4c>
  r = fstat(fd, st);
     eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb9:	89 44 24 04          	mov    %eax,0x4(%esp)
     ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec0:	89 04 24             	mov    %eax,(%esp)
     ec3:	e8 fd 00 00 00       	call   fc5 <fstat>
     ec8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     ecb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ece:	89 04 24             	mov    %eax,(%esp)
     ed1:	e8 bf 00 00 00       	call   f95 <close>
  return r;
     ed6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     ed9:	c9                   	leave  
     eda:	c3                   	ret    

00000edb <atoi>:

int
atoi(const char *s)
{
     edb:	55                   	push   %ebp
     edc:	89 e5                	mov    %esp,%ebp
     ede:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     ee1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     ee8:	eb 25                	jmp    f0f <atoi+0x34>
    n = n*10 + *s++ - '0';
     eea:	8b 55 fc             	mov    -0x4(%ebp),%edx
     eed:	89 d0                	mov    %edx,%eax
     eef:	c1 e0 02             	shl    $0x2,%eax
     ef2:	01 d0                	add    %edx,%eax
     ef4:	01 c0                	add    %eax,%eax
     ef6:	89 c1                	mov    %eax,%ecx
     ef8:	8b 45 08             	mov    0x8(%ebp),%eax
     efb:	8d 50 01             	lea    0x1(%eax),%edx
     efe:	89 55 08             	mov    %edx,0x8(%ebp)
     f01:	0f b6 00             	movzbl (%eax),%eax
     f04:	0f be c0             	movsbl %al,%eax
     f07:	01 c8                	add    %ecx,%eax
     f09:	83 e8 30             	sub    $0x30,%eax
     f0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f0f:	8b 45 08             	mov    0x8(%ebp),%eax
     f12:	0f b6 00             	movzbl (%eax),%eax
     f15:	3c 2f                	cmp    $0x2f,%al
     f17:	7e 0a                	jle    f23 <atoi+0x48>
     f19:	8b 45 08             	mov    0x8(%ebp),%eax
     f1c:	0f b6 00             	movzbl (%eax),%eax
     f1f:	3c 39                	cmp    $0x39,%al
     f21:	7e c7                	jle    eea <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     f23:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     f26:	c9                   	leave  
     f27:	c3                   	ret    

00000f28 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     f28:	55                   	push   %ebp
     f29:	89 e5                	mov    %esp,%ebp
     f2b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     f2e:	8b 45 08             	mov    0x8(%ebp),%eax
     f31:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     f34:	8b 45 0c             	mov    0xc(%ebp),%eax
     f37:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     f3a:	eb 17                	jmp    f53 <memmove+0x2b>
    *dst++ = *src++;
     f3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     f3f:	8d 50 01             	lea    0x1(%eax),%edx
     f42:	89 55 fc             	mov    %edx,-0x4(%ebp)
     f45:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f48:	8d 4a 01             	lea    0x1(%edx),%ecx
     f4b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     f4e:	0f b6 12             	movzbl (%edx),%edx
     f51:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     f53:	8b 45 10             	mov    0x10(%ebp),%eax
     f56:	8d 50 ff             	lea    -0x1(%eax),%edx
     f59:	89 55 10             	mov    %edx,0x10(%ebp)
     f5c:	85 c0                	test   %eax,%eax
     f5e:	7f dc                	jg     f3c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     f60:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f63:	c9                   	leave  
     f64:	c3                   	ret    

00000f65 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     f65:	b8 01 00 00 00       	mov    $0x1,%eax
     f6a:	cd 40                	int    $0x40
     f6c:	c3                   	ret    

00000f6d <exit>:
SYSCALL(exit)
     f6d:	b8 02 00 00 00       	mov    $0x2,%eax
     f72:	cd 40                	int    $0x40
     f74:	c3                   	ret    

00000f75 <wait>:
SYSCALL(wait)
     f75:	b8 03 00 00 00       	mov    $0x3,%eax
     f7a:	cd 40                	int    $0x40
     f7c:	c3                   	ret    

00000f7d <pipe>:
SYSCALL(pipe)
     f7d:	b8 04 00 00 00       	mov    $0x4,%eax
     f82:	cd 40                	int    $0x40
     f84:	c3                   	ret    

00000f85 <read>:
SYSCALL(read)
     f85:	b8 05 00 00 00       	mov    $0x5,%eax
     f8a:	cd 40                	int    $0x40
     f8c:	c3                   	ret    

00000f8d <write>:
SYSCALL(write)
     f8d:	b8 10 00 00 00       	mov    $0x10,%eax
     f92:	cd 40                	int    $0x40
     f94:	c3                   	ret    

00000f95 <close>:
SYSCALL(close)
     f95:	b8 15 00 00 00       	mov    $0x15,%eax
     f9a:	cd 40                	int    $0x40
     f9c:	c3                   	ret    

00000f9d <kill>:
SYSCALL(kill)
     f9d:	b8 06 00 00 00       	mov    $0x6,%eax
     fa2:	cd 40                	int    $0x40
     fa4:	c3                   	ret    

00000fa5 <exec>:
SYSCALL(exec)
     fa5:	b8 07 00 00 00       	mov    $0x7,%eax
     faa:	cd 40                	int    $0x40
     fac:	c3                   	ret    

00000fad <open>:
SYSCALL(open)
     fad:	b8 0f 00 00 00       	mov    $0xf,%eax
     fb2:	cd 40                	int    $0x40
     fb4:	c3                   	ret    

00000fb5 <mknod>:
SYSCALL(mknod)
     fb5:	b8 11 00 00 00       	mov    $0x11,%eax
     fba:	cd 40                	int    $0x40
     fbc:	c3                   	ret    

00000fbd <unlink>:
SYSCALL(unlink)
     fbd:	b8 12 00 00 00       	mov    $0x12,%eax
     fc2:	cd 40                	int    $0x40
     fc4:	c3                   	ret    

00000fc5 <fstat>:
SYSCALL(fstat)
     fc5:	b8 08 00 00 00       	mov    $0x8,%eax
     fca:	cd 40                	int    $0x40
     fcc:	c3                   	ret    

00000fcd <link>:
SYSCALL(link)
     fcd:	b8 13 00 00 00       	mov    $0x13,%eax
     fd2:	cd 40                	int    $0x40
     fd4:	c3                   	ret    

00000fd5 <mkdir>:
SYSCALL(mkdir)
     fd5:	b8 14 00 00 00       	mov    $0x14,%eax
     fda:	cd 40                	int    $0x40
     fdc:	c3                   	ret    

00000fdd <chdir>:
SYSCALL(chdir)
     fdd:	b8 09 00 00 00       	mov    $0x9,%eax
     fe2:	cd 40                	int    $0x40
     fe4:	c3                   	ret    

00000fe5 <dup>:
SYSCALL(dup)
     fe5:	b8 0a 00 00 00       	mov    $0xa,%eax
     fea:	cd 40                	int    $0x40
     fec:	c3                   	ret    

00000fed <getpid>:
SYSCALL(getpid)
     fed:	b8 0b 00 00 00       	mov    $0xb,%eax
     ff2:	cd 40                	int    $0x40
     ff4:	c3                   	ret    

00000ff5 <sbrk>:
SYSCALL(sbrk)
     ff5:	b8 0c 00 00 00       	mov    $0xc,%eax
     ffa:	cd 40                	int    $0x40
     ffc:	c3                   	ret    

00000ffd <sleep>:
SYSCALL(sleep)
     ffd:	b8 0d 00 00 00       	mov    $0xd,%eax
    1002:	cd 40                	int    $0x40
    1004:	c3                   	ret    

00001005 <uptime>:
SYSCALL(uptime)
    1005:	b8 0e 00 00 00       	mov    $0xe,%eax
    100a:	cd 40                	int    $0x40
    100c:	c3                   	ret    

0000100d <gettime>:
SYSCALL(gettime)
    100d:	b8 16 00 00 00       	mov    $0x16,%eax
    1012:	cd 40                	int    $0x40
    1014:	c3                   	ret    

00001015 <settickets>:
SYSCALL(settickets)
    1015:	b8 17 00 00 00       	mov    $0x17,%eax
    101a:	cd 40                	int    $0x40
    101c:	c3                   	ret    

0000101d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    101d:	55                   	push   %ebp
    101e:	89 e5                	mov    %esp,%ebp
    1020:	83 ec 18             	sub    $0x18,%esp
    1023:	8b 45 0c             	mov    0xc(%ebp),%eax
    1026:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1029:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1030:	00 
    1031:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1034:	89 44 24 04          	mov    %eax,0x4(%esp)
    1038:	8b 45 08             	mov    0x8(%ebp),%eax
    103b:	89 04 24             	mov    %eax,(%esp)
    103e:	e8 4a ff ff ff       	call   f8d <write>
}
    1043:	c9                   	leave  
    1044:	c3                   	ret    

00001045 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1045:	55                   	push   %ebp
    1046:	89 e5                	mov    %esp,%ebp
    1048:	56                   	push   %esi
    1049:	53                   	push   %ebx
    104a:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    104d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1054:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1058:	74 17                	je     1071 <printint+0x2c>
    105a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    105e:	79 11                	jns    1071 <printint+0x2c>
    neg = 1;
    1060:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1067:	8b 45 0c             	mov    0xc(%ebp),%eax
    106a:	f7 d8                	neg    %eax
    106c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    106f:	eb 06                	jmp    1077 <printint+0x32>
  } else {
    x = xx;
    1071:	8b 45 0c             	mov    0xc(%ebp),%eax
    1074:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1077:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    107e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1081:	8d 41 01             	lea    0x1(%ecx),%eax
    1084:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1087:	8b 5d 10             	mov    0x10(%ebp),%ebx
    108a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    108d:	ba 00 00 00 00       	mov    $0x0,%edx
    1092:	f7 f3                	div    %ebx
    1094:	89 d0                	mov    %edx,%eax
    1096:	0f b6 80 1e 1b 00 00 	movzbl 0x1b1e(%eax),%eax
    109d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    10a1:	8b 75 10             	mov    0x10(%ebp),%esi
    10a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10a7:	ba 00 00 00 00       	mov    $0x0,%edx
    10ac:	f7 f6                	div    %esi
    10ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
    10b1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10b5:	75 c7                	jne    107e <printint+0x39>
  if(neg)
    10b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10bb:	74 10                	je     10cd <printint+0x88>
    buf[i++] = '-';
    10bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c0:	8d 50 01             	lea    0x1(%eax),%edx
    10c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    10c6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    10cb:	eb 1f                	jmp    10ec <printint+0xa7>
    10cd:	eb 1d                	jmp    10ec <printint+0xa7>
    putc(fd, buf[i]);
    10cf:	8d 55 dc             	lea    -0x24(%ebp),%edx
    10d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d5:	01 d0                	add    %edx,%eax
    10d7:	0f b6 00             	movzbl (%eax),%eax
    10da:	0f be c0             	movsbl %al,%eax
    10dd:	89 44 24 04          	mov    %eax,0x4(%esp)
    10e1:	8b 45 08             	mov    0x8(%ebp),%eax
    10e4:	89 04 24             	mov    %eax,(%esp)
    10e7:	e8 31 ff ff ff       	call   101d <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    10ec:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    10f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10f4:	79 d9                	jns    10cf <printint+0x8a>
    putc(fd, buf[i]);
}
    10f6:	83 c4 30             	add    $0x30,%esp
    10f9:	5b                   	pop    %ebx
    10fa:	5e                   	pop    %esi
    10fb:	5d                   	pop    %ebp
    10fc:	c3                   	ret    

000010fd <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
    10fd:	55                   	push   %ebp
    10fe:	89 e5                	mov    %esp,%ebp
    1100:	83 ec 38             	sub    $0x38,%esp
    1103:	8b 45 0c             	mov    0xc(%ebp),%eax
    1106:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1109:	8b 45 10             	mov    0x10(%ebp),%eax
    110c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
    110f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1112:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1115:	89 d0                	mov    %edx,%eax
    1117:	31 d2                	xor    %edx,%edx
    1119:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
    111c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    111f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
    1122:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1126:	74 22                	je     114a <printlong+0x4d>
    1128:	8b 45 f4             	mov    -0xc(%ebp),%eax
    112b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1132:	00 
    1133:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    113a:	00 
    113b:	89 44 24 04          	mov    %eax,0x4(%esp)
    113f:	8b 45 08             	mov    0x8(%ebp),%eax
    1142:	89 04 24             	mov    %eax,(%esp)
    1145:	e8 fb fe ff ff       	call   1045 <printint>
    printint(fd, lower, 16, 0);
    114a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    114d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1154:	00 
    1155:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    115c:	00 
    115d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
    1164:	89 04 24             	mov    %eax,(%esp)
    1167:	e8 d9 fe ff ff       	call   1045 <printint>
}
    116c:	c9                   	leave  
    116d:	c3                   	ret    

0000116e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
    116e:	55                   	push   %ebp
    116f:	89 e5                	mov    %esp,%ebp
    1171:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1174:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    117b:	8d 45 0c             	lea    0xc(%ebp),%eax
    117e:	83 c0 04             	add    $0x4,%eax
    1181:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1184:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    118b:	e9 ba 01 00 00       	jmp    134a <printf+0x1dc>
    c = fmt[i] & 0xff;
    1190:	8b 55 0c             	mov    0xc(%ebp),%edx
    1193:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1196:	01 d0                	add    %edx,%eax
    1198:	0f b6 00             	movzbl (%eax),%eax
    119b:	0f be c0             	movsbl %al,%eax
    119e:	25 ff 00 00 00       	and    $0xff,%eax
    11a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    11a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11aa:	75 2c                	jne    11d8 <printf+0x6a>
      if(c == '%'){
    11ac:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11b0:	75 0c                	jne    11be <printf+0x50>
        state = '%';
    11b2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    11b9:	e9 88 01 00 00       	jmp    1346 <printf+0x1d8>
      } else {
        putc(fd, c);
    11be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11c1:	0f be c0             	movsbl %al,%eax
    11c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    11c8:	8b 45 08             	mov    0x8(%ebp),%eax
    11cb:	89 04 24             	mov    %eax,(%esp)
    11ce:	e8 4a fe ff ff       	call   101d <putc>
    11d3:	e9 6e 01 00 00       	jmp    1346 <printf+0x1d8>
      }
    } else if(state == '%'){
    11d8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    11dc:	0f 85 64 01 00 00    	jne    1346 <printf+0x1d8>
      if(c == 'd'){
    11e2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    11e6:	75 2d                	jne    1215 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    11e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11eb:	8b 00                	mov    (%eax),%eax
    11ed:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    11f4:	00 
    11f5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    11fc:	00 
    11fd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1201:	8b 45 08             	mov    0x8(%ebp),%eax
    1204:	89 04 24             	mov    %eax,(%esp)
    1207:	e8 39 fe ff ff       	call   1045 <printint>
        ap++;
    120c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1210:	e9 2a 01 00 00       	jmp    133f <printf+0x1d1>
      } else if(c == 'l') {
    1215:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
    1219:	75 38                	jne    1253 <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
    121b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    121e:	8b 50 04             	mov    0x4(%eax),%edx
    1221:	8b 00                	mov    (%eax),%eax
    1223:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    122a:	00 
    122b:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
    1232:	00 
    1233:	89 44 24 04          	mov    %eax,0x4(%esp)
    1237:	89 54 24 08          	mov    %edx,0x8(%esp)
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	89 04 24             	mov    %eax,(%esp)
    1241:	e8 b7 fe ff ff       	call   10fd <printlong>
        // long longs take up 2 argument slots
        ap++;
    1246:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
    124a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    124e:	e9 ec 00 00 00       	jmp    133f <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
    1253:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1257:	74 06                	je     125f <printf+0xf1>
    1259:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    125d:	75 2d                	jne    128c <printf+0x11e>
        printint(fd, *ap, 16, 0);
    125f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1262:	8b 00                	mov    (%eax),%eax
    1264:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    126b:	00 
    126c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1273:	00 
    1274:	89 44 24 04          	mov    %eax,0x4(%esp)
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	89 04 24             	mov    %eax,(%esp)
    127e:	e8 c2 fd ff ff       	call   1045 <printint>
        ap++;
    1283:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1287:	e9 b3 00 00 00       	jmp    133f <printf+0x1d1>
      } else if(c == 's'){
    128c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1290:	75 45                	jne    12d7 <printf+0x169>
        s = (char*)*ap;
    1292:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1295:	8b 00                	mov    (%eax),%eax
    1297:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    129a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    129e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12a2:	75 09                	jne    12ad <printf+0x13f>
          s = "(null)";
    12a4:	c7 45 f4 68 16 00 00 	movl   $0x1668,-0xc(%ebp)
        while(*s != 0){
    12ab:	eb 1e                	jmp    12cb <printf+0x15d>
    12ad:	eb 1c                	jmp    12cb <printf+0x15d>
          putc(fd, *s);
    12af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12b2:	0f b6 00             	movzbl (%eax),%eax
    12b5:	0f be c0             	movsbl %al,%eax
    12b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    12bc:	8b 45 08             	mov    0x8(%ebp),%eax
    12bf:	89 04 24             	mov    %eax,(%esp)
    12c2:	e8 56 fd ff ff       	call   101d <putc>
          s++;
    12c7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    12cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ce:	0f b6 00             	movzbl (%eax),%eax
    12d1:	84 c0                	test   %al,%al
    12d3:	75 da                	jne    12af <printf+0x141>
    12d5:	eb 68                	jmp    133f <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12d7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    12db:	75 1d                	jne    12fa <printf+0x18c>
        putc(fd, *ap);
    12dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12e0:	8b 00                	mov    (%eax),%eax
    12e2:	0f be c0             	movsbl %al,%eax
    12e5:	89 44 24 04          	mov    %eax,0x4(%esp)
    12e9:	8b 45 08             	mov    0x8(%ebp),%eax
    12ec:	89 04 24             	mov    %eax,(%esp)
    12ef:	e8 29 fd ff ff       	call   101d <putc>
        ap++;
    12f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    12f8:	eb 45                	jmp    133f <printf+0x1d1>
      } else if(c == '%'){
    12fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    12fe:	75 17                	jne    1317 <printf+0x1a9>
        putc(fd, c);
    1300:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1303:	0f be c0             	movsbl %al,%eax
    1306:	89 44 24 04          	mov    %eax,0x4(%esp)
    130a:	8b 45 08             	mov    0x8(%ebp),%eax
    130d:	89 04 24             	mov    %eax,(%esp)
    1310:	e8 08 fd ff ff       	call   101d <putc>
    1315:	eb 28                	jmp    133f <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1317:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    131e:	00 
    131f:	8b 45 08             	mov    0x8(%ebp),%eax
    1322:	89 04 24             	mov    %eax,(%esp)
    1325:	e8 f3 fc ff ff       	call   101d <putc>
        putc(fd, c);
    132a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    132d:	0f be c0             	movsbl %al,%eax
    1330:	89 44 24 04          	mov    %eax,0x4(%esp)
    1334:	8b 45 08             	mov    0x8(%ebp),%eax
    1337:	89 04 24             	mov    %eax,(%esp)
    133a:	e8 de fc ff ff       	call   101d <putc>
      }
      state = 0;
    133f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1346:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    134a:	8b 55 0c             	mov    0xc(%ebp),%edx
    134d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1350:	01 d0                	add    %edx,%eax
    1352:	0f b6 00             	movzbl (%eax),%eax
    1355:	84 c0                	test   %al,%al
    1357:	0f 85 33 fe ff ff    	jne    1190 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    135d:	c9                   	leave  
    135e:	c3                   	ret    

0000135f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    135f:	55                   	push   %ebp
    1360:	89 e5                	mov    %esp,%ebp
    1362:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1365:	8b 45 08             	mov    0x8(%ebp),%eax
    1368:	83 e8 08             	sub    $0x8,%eax
    136b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    136e:	a1 ac 1b 00 00       	mov    0x1bac,%eax
    1373:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1376:	eb 24                	jmp    139c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1378:	8b 45 fc             	mov    -0x4(%ebp),%eax
    137b:	8b 00                	mov    (%eax),%eax
    137d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1380:	77 12                	ja     1394 <free+0x35>
    1382:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1385:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1388:	77 24                	ja     13ae <free+0x4f>
    138a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    138d:	8b 00                	mov    (%eax),%eax
    138f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1392:	77 1a                	ja     13ae <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1394:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1397:	8b 00                	mov    (%eax),%eax
    1399:	89 45 fc             	mov    %eax,-0x4(%ebp)
    139c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    139f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13a2:	76 d4                	jbe    1378 <free+0x19>
    13a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13a7:	8b 00                	mov    (%eax),%eax
    13a9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13ac:	76 ca                	jbe    1378 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    13ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13b1:	8b 40 04             	mov    0x4(%eax),%eax
    13b4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    13bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13be:	01 c2                	add    %eax,%edx
    13c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13c3:	8b 00                	mov    (%eax),%eax
    13c5:	39 c2                	cmp    %eax,%edx
    13c7:	75 24                	jne    13ed <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    13c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13cc:	8b 50 04             	mov    0x4(%eax),%edx
    13cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13d2:	8b 00                	mov    (%eax),%eax
    13d4:	8b 40 04             	mov    0x4(%eax),%eax
    13d7:	01 c2                	add    %eax,%edx
    13d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13dc:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    13df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13e2:	8b 00                	mov    (%eax),%eax
    13e4:	8b 10                	mov    (%eax),%edx
    13e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13e9:	89 10                	mov    %edx,(%eax)
    13eb:	eb 0a                	jmp    13f7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    13ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f0:	8b 10                	mov    (%eax),%edx
    13f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13f5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    13f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13fa:	8b 40 04             	mov    0x4(%eax),%eax
    13fd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1404:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1407:	01 d0                	add    %edx,%eax
    1409:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    140c:	75 20                	jne    142e <free+0xcf>
    p->s.size += bp->s.size;
    140e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1411:	8b 50 04             	mov    0x4(%eax),%edx
    1414:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1417:	8b 40 04             	mov    0x4(%eax),%eax
    141a:	01 c2                	add    %eax,%edx
    141c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    141f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1422:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1425:	8b 10                	mov    (%eax),%edx
    1427:	8b 45 fc             	mov    -0x4(%ebp),%eax
    142a:	89 10                	mov    %edx,(%eax)
    142c:	eb 08                	jmp    1436 <free+0xd7>
  } else
    p->s.ptr = bp;
    142e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1431:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1434:	89 10                	mov    %edx,(%eax)
  freep = p;
    1436:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1439:	a3 ac 1b 00 00       	mov    %eax,0x1bac
}
    143e:	c9                   	leave  
    143f:	c3                   	ret    

00001440 <morecore>:

static Header*
morecore(uint nu)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1446:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    144d:	77 07                	ja     1456 <morecore+0x16>
    nu = 4096;
    144f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1456:	8b 45 08             	mov    0x8(%ebp),%eax
    1459:	c1 e0 03             	shl    $0x3,%eax
    145c:	89 04 24             	mov    %eax,(%esp)
    145f:	e8 91 fb ff ff       	call   ff5 <sbrk>
    1464:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1467:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    146b:	75 07                	jne    1474 <morecore+0x34>
    return 0;
    146d:	b8 00 00 00 00       	mov    $0x0,%eax
    1472:	eb 22                	jmp    1496 <morecore+0x56>
  hp = (Header*)p;
    1474:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1477:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    147a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    147d:	8b 55 08             	mov    0x8(%ebp),%edx
    1480:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1483:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1486:	83 c0 08             	add    $0x8,%eax
    1489:	89 04 24             	mov    %eax,(%esp)
    148c:	e8 ce fe ff ff       	call   135f <free>
  return freep;
    1491:	a1 ac 1b 00 00       	mov    0x1bac,%eax
}
    1496:	c9                   	leave  
    1497:	c3                   	ret    

00001498 <malloc>:

void*
malloc(uint nbytes)
{
    1498:	55                   	push   %ebp
    1499:	89 e5                	mov    %esp,%ebp
    149b:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    149e:	8b 45 08             	mov    0x8(%ebp),%eax
    14a1:	83 c0 07             	add    $0x7,%eax
    14a4:	c1 e8 03             	shr    $0x3,%eax
    14a7:	83 c0 01             	add    $0x1,%eax
    14aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    14ad:	a1 ac 1b 00 00       	mov    0x1bac,%eax
    14b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    14b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14b9:	75 23                	jne    14de <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    14bb:	c7 45 f0 a4 1b 00 00 	movl   $0x1ba4,-0x10(%ebp)
    14c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c5:	a3 ac 1b 00 00       	mov    %eax,0x1bac
    14ca:	a1 ac 1b 00 00       	mov    0x1bac,%eax
    14cf:	a3 a4 1b 00 00       	mov    %eax,0x1ba4
    base.s.size = 0;
    14d4:	c7 05 a8 1b 00 00 00 	movl   $0x0,0x1ba8
    14db:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14e1:	8b 00                	mov    (%eax),%eax
    14e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	8b 40 04             	mov    0x4(%eax),%eax
    14ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    14ef:	72 4d                	jb     153e <malloc+0xa6>
      if(p->s.size == nunits)
    14f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f4:	8b 40 04             	mov    0x4(%eax),%eax
    14f7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    14fa:	75 0c                	jne    1508 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    14fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ff:	8b 10                	mov    (%eax),%edx
    1501:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1504:	89 10                	mov    %edx,(%eax)
    1506:	eb 26                	jmp    152e <malloc+0x96>
      else {
        p->s.size -= nunits;
    1508:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150b:	8b 40 04             	mov    0x4(%eax),%eax
    150e:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1511:	89 c2                	mov    %eax,%edx
    1513:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1516:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1519:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151c:	8b 40 04             	mov    0x4(%eax),%eax
    151f:	c1 e0 03             	shl    $0x3,%eax
    1522:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1525:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1528:	8b 55 ec             	mov    -0x14(%ebp),%edx
    152b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    152e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1531:	a3 ac 1b 00 00       	mov    %eax,0x1bac
      return (void*)(p + 1);
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	83 c0 08             	add    $0x8,%eax
    153c:	eb 38                	jmp    1576 <malloc+0xde>
    }
    if(p == freep)
    153e:	a1 ac 1b 00 00       	mov    0x1bac,%eax
    1543:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1546:	75 1b                	jne    1563 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1548:	8b 45 ec             	mov    -0x14(%ebp),%eax
    154b:	89 04 24             	mov    %eax,(%esp)
    154e:	e8 ed fe ff ff       	call   1440 <morecore>
    1553:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1556:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    155a:	75 07                	jne    1563 <malloc+0xcb>
        return 0;
    155c:	b8 00 00 00 00       	mov    $0x0,%eax
    1561:	eb 13                	jmp    1576 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1563:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1566:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1569:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156c:	8b 00                	mov    (%eax),%eax
    156e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1571:	e9 70 ff ff ff       	jmp    14e6 <malloc+0x4e>
}
    1576:	c9                   	leave  
    1577:	c3                   	ret    
