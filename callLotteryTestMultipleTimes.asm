
_callLotteryTestMultipleTimes:     file format elf32-i386


Disassembly of section .text:

00000000 <spin>:
#include "date.h"
#include "fcntl.h"


// Do some useless computations
void spin(int tix) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 54             	sub    $0x54,%esp
    struct rtcdate start;
    gettime(&start);
   7:	8d 45 d4             	lea    -0x2c(%ebp),%eax
   a:	89 04 24             	mov    %eax,(%esp)
   d:	e8 3f 04 00 00       	call   451 <gettime>

    struct rtcdate end;
    unsigned x = 0;
  12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    unsigned y = 0;
  19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while (x < 100000) {
  20:	eb 1a                	jmp    3c <spin+0x3c>
        y = 0;
  22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        while (y < 10000) {
  29:	eb 04                	jmp    2f <spin+0x2f>
            y++;
  2b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    struct rtcdate end;
    unsigned x = 0;
    unsigned y = 0;
    while (x < 100000) {
        y = 0;
        while (y < 10000) {
  2f:	81 7d f0 0f 27 00 00 	cmpl   $0x270f,-0x10(%ebp)
  36:	76 f3                	jbe    2b <spin+0x2b>
            y++;
        }
        x++;
  38:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    gettime(&start);

    struct rtcdate end;
    unsigned x = 0;
    unsigned y = 0;
    while (x < 100000) {
  3c:	81 7d f4 9f 86 01 00 	cmpl   $0x1869f,-0xc(%ebp)
  43:	76 dd                	jbe    22 <spin+0x22>
            y++;
        }
        x++;
    }

    gettime(&end);
  45:	8d 45 bc             	lea    -0x44(%ebp),%eax
  48:	89 04 24             	mov    %eax,(%esp)
  4b:	e8 01 04 00 00       	call   451 <gettime>

    int duration = ((end.hour*3600) + (end.minute*60) + end.second) - ((start.hour*3600) + (start.minute*60) + start.second);
  50:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  53:	69 d0 10 0e 00 00    	imul   $0xe10,%eax,%edx
  59:	8b 45 c0             	mov    -0x40(%ebp),%eax
  5c:	c1 e0 02             	shl    $0x2,%eax
  5f:	89 c1                	mov    %eax,%ecx
  61:	c1 e1 04             	shl    $0x4,%ecx
  64:	29 c1                	sub    %eax,%ecx
  66:	89 c8                	mov    %ecx,%eax
  68:	01 c2                	add    %eax,%edx
  6a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  6d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  70:	8b 45 dc             	mov    -0x24(%ebp),%eax
  73:	69 d0 10 0e 00 00    	imul   $0xe10,%eax,%edx
  79:	8b 45 d8             	mov    -0x28(%ebp),%eax
  7c:	c1 e0 02             	shl    $0x2,%eax
  7f:	89 c3                	mov    %eax,%ebx
  81:	c1 e3 04             	shl    $0x4,%ebx
  84:	29 c3                	sub    %eax,%ebx
  86:	89 d8                	mov    %ebx,%eax
  88:	01 c2                	add    %eax,%edx
  8a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8d:	01 d0                	add    %edx,%eax
  8f:	29 c1                	sub    %eax,%ecx
  91:	89 c8                	mov    %ecx,%eax
  93:	89 45 ec             	mov    %eax,-0x14(%ebp)

    printf(0, "%d, %d\n", tix, duration);
  96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  99:	89 44 24 0c          	mov    %eax,0xc(%esp)
  9d:	8b 45 08             	mov    0x8(%ebp),%eax
  a0:	89 44 24 08          	mov    %eax,0x8(%esp)
  a4:	c7 44 24 04 bc 09 00 	movl   $0x9bc,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b3:	e8 fa 04 00 00       	call   5b2 <printf>

    //printf(0, "spin with %d tickets ended at %d hours %d minutes %d seconds\n", tix, end.hour, end.minute, end.second);
}
  b8:	83 c4 54             	add    $0x54,%esp
  bb:	5b                   	pop    %ebx
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    

000000be <main>:

int main(){
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 e4 f0             	and    $0xfffffff0,%esp
  c4:	83 ec 20             	sub    $0x20,%esp

  int i;
  for (i=0; i<1000; i++){
  c7:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  ce:	00 
  cf:	eb 69                	jmp    13a <main+0x7c>
    int pid1;
    int pid2;

    //printf(0, "starting test at %d hours %d minutes %d seconds\n", start.hour, start.minute, start.second);
    if ((pid1 = fork()) == 0) {
  d1:	e8 d3 02 00 00       	call   3a9 <fork>
  d6:	89 44 24 18          	mov    %eax,0x18(%esp)
  da:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  df:	75 1d                	jne    fe <main+0x40>
        settickets(80);
  e1:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
  e8:	e8 6c 03 00 00       	call   459 <settickets>
        spin(80);
  ed:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
  f4:	e8 07 ff ff ff       	call   0 <spin>
        exit();
  f9:	e8 b3 02 00 00       	call   3b1 <exit>
    }
    else if ((pid2 = fork()) == 0) {
  fe:	e8 a6 02 00 00       	call   3a9 <fork>
 103:	89 44 24 14          	mov    %eax,0x14(%esp)
 107:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
 10c:	75 1d                	jne    12b <main+0x6d>
        settickets(20);
 10e:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 115:	e8 3f 03 00 00       	call   459 <settickets>
        spin(20);
 11a:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 121:	e8 da fe ff ff       	call   0 <spin>
        exit();
 126:	e8 86 02 00 00       	call   3b1 <exit>
    }
    // Go to sleep and wait for subprocesses to finish
    wait();
 12b:	e8 89 02 00 00       	call   3b9 <wait>
    wait();
 130:	e8 84 02 00 00       	call   3b9 <wait>
}

int main(){

  int i;
  for (i=0; i<1000; i++){
 135:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 13a:	81 7c 24 1c e7 03 00 	cmpl   $0x3e7,0x1c(%esp)
 141:	00 
 142:	7e 8d                	jle    d1 <main+0x13>
    }
    // Go to sleep and wait for subprocesses to finish
    wait();
    wait();
  }
exit();
 144:	e8 68 02 00 00       	call   3b1 <exit>

00000149 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 149:	55                   	push   %ebp
 14a:	89 e5                	mov    %esp,%ebp
 14c:	57                   	push   %edi
 14d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 14e:	8b 4d 08             	mov    0x8(%ebp),%ecx
 151:	8b 55 10             	mov    0x10(%ebp),%edx
 154:	8b 45 0c             	mov    0xc(%ebp),%eax
 157:	89 cb                	mov    %ecx,%ebx
 159:	89 df                	mov    %ebx,%edi
 15b:	89 d1                	mov    %edx,%ecx
 15d:	fc                   	cld    
 15e:	f3 aa                	rep stos %al,%es:(%edi)
 160:	89 ca                	mov    %ecx,%edx
 162:	89 fb                	mov    %edi,%ebx
 164:	89 5d 08             	mov    %ebx,0x8(%ebp)
 167:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 16a:	5b                   	pop    %ebx
 16b:	5f                   	pop    %edi
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    

0000016e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 17a:	90                   	nop
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	8d 50 01             	lea    0x1(%eax),%edx
 181:	89 55 08             	mov    %edx,0x8(%ebp)
 184:	8b 55 0c             	mov    0xc(%ebp),%edx
 187:	8d 4a 01             	lea    0x1(%edx),%ecx
 18a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 18d:	0f b6 12             	movzbl (%edx),%edx
 190:	88 10                	mov    %dl,(%eax)
 192:	0f b6 00             	movzbl (%eax),%eax
 195:	84 c0                	test   %al,%al
 197:	75 e2                	jne    17b <strcpy+0xd>
    ;
  return os;
 199:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 19c:	c9                   	leave  
 19d:	c3                   	ret    

0000019e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 19e:	55                   	push   %ebp
 19f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1a1:	eb 08                	jmp    1ab <strcmp+0xd>
    p++, q++;
 1a3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1ab:	8b 45 08             	mov    0x8(%ebp),%eax
 1ae:	0f b6 00             	movzbl (%eax),%eax
 1b1:	84 c0                	test   %al,%al
 1b3:	74 10                	je     1c5 <strcmp+0x27>
 1b5:	8b 45 08             	mov    0x8(%ebp),%eax
 1b8:	0f b6 10             	movzbl (%eax),%edx
 1bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1be:	0f b6 00             	movzbl (%eax),%eax
 1c1:	38 c2                	cmp    %al,%dl
 1c3:	74 de                	je     1a3 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1c5:	8b 45 08             	mov    0x8(%ebp),%eax
 1c8:	0f b6 00             	movzbl (%eax),%eax
 1cb:	0f b6 d0             	movzbl %al,%edx
 1ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d1:	0f b6 00             	movzbl (%eax),%eax
 1d4:	0f b6 c0             	movzbl %al,%eax
 1d7:	29 c2                	sub    %eax,%edx
 1d9:	89 d0                	mov    %edx,%eax
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    

000001dd <strlen>:

uint
strlen(char *s)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
 1e0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ea:	eb 04                	jmp    1f0 <strlen+0x13>
 1ec:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	01 d0                	add    %edx,%eax
 1f8:	0f b6 00             	movzbl (%eax),%eax
 1fb:	84 c0                	test   %al,%al
 1fd:	75 ed                	jne    1ec <strlen+0xf>
    ;
  return n;
 1ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 202:	c9                   	leave  
 203:	c3                   	ret    

00000204 <memset>:

void*
memset(void *dst, int c, uint n)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 20a:	8b 45 10             	mov    0x10(%ebp),%eax
 20d:	89 44 24 08          	mov    %eax,0x8(%esp)
 211:	8b 45 0c             	mov    0xc(%ebp),%eax
 214:	89 44 24 04          	mov    %eax,0x4(%esp)
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	e8 26 ff ff ff       	call   149 <stosb>
  return dst;
 223:	8b 45 08             	mov    0x8(%ebp),%eax
}
 226:	c9                   	leave  
 227:	c3                   	ret    

00000228 <strchr>:

char*
strchr(const char *s, char c)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 234:	eb 14                	jmp    24a <strchr+0x22>
    if(*s == c)
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 23f:	75 05                	jne    246 <strchr+0x1e>
      return (char*)s;
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	eb 13                	jmp    259 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 246:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	75 e2                	jne    236 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 254:	b8 00 00 00 00       	mov    $0x0,%eax
}
 259:	c9                   	leave  
 25a:	c3                   	ret    

0000025b <gets>:

char*
gets(char *buf, int max)
{
 25b:	55                   	push   %ebp
 25c:	89 e5                	mov    %esp,%ebp
 25e:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 261:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 268:	eb 4c                	jmp    2b6 <gets+0x5b>
    cc = read(0, &c, 1);
 26a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 271:	00 
 272:	8d 45 ef             	lea    -0x11(%ebp),%eax
 275:	89 44 24 04          	mov    %eax,0x4(%esp)
 279:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 280:	e8 44 01 00 00       	call   3c9 <read>
 285:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 288:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 28c:	7f 02                	jg     290 <gets+0x35>
      break;
 28e:	eb 31                	jmp    2c1 <gets+0x66>
    buf[i++] = c;
 290:	8b 45 f4             	mov    -0xc(%ebp),%eax
 293:	8d 50 01             	lea    0x1(%eax),%edx
 296:	89 55 f4             	mov    %edx,-0xc(%ebp)
 299:	89 c2                	mov    %eax,%edx
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	01 c2                	add    %eax,%edx
 2a0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2a6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2aa:	3c 0a                	cmp    $0xa,%al
 2ac:	74 13                	je     2c1 <gets+0x66>
 2ae:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b2:	3c 0d                	cmp    $0xd,%al
 2b4:	74 0b                	je     2c1 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2b9:	83 c0 01             	add    $0x1,%eax
 2bc:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2bf:	7c a9                	jl     26a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	01 d0                	add    %edx,%eax
 2c9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2cf:	c9                   	leave  
 2d0:	c3                   	ret    

000002d1 <stat>:

int
stat(char *n, struct stat *st)
{
 2d1:	55                   	push   %ebp
 2d2:	89 e5                	mov    %esp,%ebp
 2d4:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2de:	00 
 2df:	8b 45 08             	mov    0x8(%ebp),%eax
 2e2:	89 04 24             	mov    %eax,(%esp)
 2e5:	e8 07 01 00 00       	call   3f1 <open>
 2ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2f1:	79 07                	jns    2fa <stat+0x29>
    return -1;
 2f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2f8:	eb 23                	jmp    31d <stat+0x4c>
  r = fstat(fd, st);
 2fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fd:	89 44 24 04          	mov    %eax,0x4(%esp)
 301:	8b 45 f4             	mov    -0xc(%ebp),%eax
 304:	89 04 24             	mov    %eax,(%esp)
 307:	e8 fd 00 00 00       	call   409 <fstat>
 30c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 30f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 312:	89 04 24             	mov    %eax,(%esp)
 315:	e8 bf 00 00 00       	call   3d9 <close>
  return r;
 31a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 31d:	c9                   	leave  
 31e:	c3                   	ret    

0000031f <atoi>:

int
atoi(const char *s)
{
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 32c:	eb 25                	jmp    353 <atoi+0x34>
    n = n*10 + *s++ - '0';
 32e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 331:	89 d0                	mov    %edx,%eax
 333:	c1 e0 02             	shl    $0x2,%eax
 336:	01 d0                	add    %edx,%eax
 338:	01 c0                	add    %eax,%eax
 33a:	89 c1                	mov    %eax,%ecx
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
 33f:	8d 50 01             	lea    0x1(%eax),%edx
 342:	89 55 08             	mov    %edx,0x8(%ebp)
 345:	0f b6 00             	movzbl (%eax),%eax
 348:	0f be c0             	movsbl %al,%eax
 34b:	01 c8                	add    %ecx,%eax
 34d:	83 e8 30             	sub    $0x30,%eax
 350:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	0f b6 00             	movzbl (%eax),%eax
 359:	3c 2f                	cmp    $0x2f,%al
 35b:	7e 0a                	jle    367 <atoi+0x48>
 35d:	8b 45 08             	mov    0x8(%ebp),%eax
 360:	0f b6 00             	movzbl (%eax),%eax
 363:	3c 39                	cmp    $0x39,%al
 365:	7e c7                	jle    32e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 367:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 36a:	c9                   	leave  
 36b:	c3                   	ret    

0000036c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 378:	8b 45 0c             	mov    0xc(%ebp),%eax
 37b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 37e:	eb 17                	jmp    397 <memmove+0x2b>
    *dst++ = *src++;
 380:	8b 45 fc             	mov    -0x4(%ebp),%eax
 383:	8d 50 01             	lea    0x1(%eax),%edx
 386:	89 55 fc             	mov    %edx,-0x4(%ebp)
 389:	8b 55 f8             	mov    -0x8(%ebp),%edx
 38c:	8d 4a 01             	lea    0x1(%edx),%ecx
 38f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 392:	0f b6 12             	movzbl (%edx),%edx
 395:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 397:	8b 45 10             	mov    0x10(%ebp),%eax
 39a:	8d 50 ff             	lea    -0x1(%eax),%edx
 39d:	89 55 10             	mov    %edx,0x10(%ebp)
 3a0:	85 c0                	test   %eax,%eax
 3a2:	7f dc                	jg     380 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3a7:	c9                   	leave  
 3a8:	c3                   	ret    

000003a9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3a9:	b8 01 00 00 00       	mov    $0x1,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <exit>:
SYSCALL(exit)
 3b1:	b8 02 00 00 00       	mov    $0x2,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <wait>:
SYSCALL(wait)
 3b9:	b8 03 00 00 00       	mov    $0x3,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <pipe>:
SYSCALL(pipe)
 3c1:	b8 04 00 00 00       	mov    $0x4,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <read>:
SYSCALL(read)
 3c9:	b8 05 00 00 00       	mov    $0x5,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <write>:
SYSCALL(write)
 3d1:	b8 10 00 00 00       	mov    $0x10,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <close>:
SYSCALL(close)
 3d9:	b8 15 00 00 00       	mov    $0x15,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <kill>:
SYSCALL(kill)
 3e1:	b8 06 00 00 00       	mov    $0x6,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <exec>:
SYSCALL(exec)
 3e9:	b8 07 00 00 00       	mov    $0x7,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <open>:
SYSCALL(open)
 3f1:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <mknod>:
SYSCALL(mknod)
 3f9:	b8 11 00 00 00       	mov    $0x11,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <unlink>:
SYSCALL(unlink)
 401:	b8 12 00 00 00       	mov    $0x12,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <fstat>:
SYSCALL(fstat)
 409:	b8 08 00 00 00       	mov    $0x8,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <link>:
SYSCALL(link)
 411:	b8 13 00 00 00       	mov    $0x13,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <mkdir>:
SYSCALL(mkdir)
 419:	b8 14 00 00 00       	mov    $0x14,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <chdir>:
SYSCALL(chdir)
 421:	b8 09 00 00 00       	mov    $0x9,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <dup>:
SYSCALL(dup)
 429:	b8 0a 00 00 00       	mov    $0xa,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <getpid>:
SYSCALL(getpid)
 431:	b8 0b 00 00 00       	mov    $0xb,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <sbrk>:
SYSCALL(sbrk)
 439:	b8 0c 00 00 00       	mov    $0xc,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <sleep>:
SYSCALL(sleep)
 441:	b8 0d 00 00 00       	mov    $0xd,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <uptime>:
SYSCALL(uptime)
 449:	b8 0e 00 00 00       	mov    $0xe,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <gettime>:
SYSCALL(gettime)
 451:	b8 16 00 00 00       	mov    $0x16,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <settickets>:
SYSCALL(settickets)
 459:	b8 17 00 00 00       	mov    $0x17,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 461:	55                   	push   %ebp
 462:	89 e5                	mov    %esp,%ebp
 464:	83 ec 18             	sub    $0x18,%esp
 467:	8b 45 0c             	mov    0xc(%ebp),%eax
 46a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 46d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 474:	00 
 475:	8d 45 f4             	lea    -0xc(%ebp),%eax
 478:	89 44 24 04          	mov    %eax,0x4(%esp)
 47c:	8b 45 08             	mov    0x8(%ebp),%eax
 47f:	89 04 24             	mov    %eax,(%esp)
 482:	e8 4a ff ff ff       	call   3d1 <write>
}
 487:	c9                   	leave  
 488:	c3                   	ret    

00000489 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 489:	55                   	push   %ebp
 48a:	89 e5                	mov    %esp,%ebp
 48c:	56                   	push   %esi
 48d:	53                   	push   %ebx
 48e:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 491:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 498:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 49c:	74 17                	je     4b5 <printint+0x2c>
 49e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4a2:	79 11                	jns    4b5 <printint+0x2c>
    neg = 1;
 4a4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ae:	f7 d8                	neg    %eax
 4b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4b3:	eb 06                	jmp    4bb <printint+0x32>
  } else {
    x = xx;
 4b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4c2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4c5:	8d 41 01             	lea    0x1(%ecx),%eax
 4c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d1:	ba 00 00 00 00       	mov    $0x0,%edx
 4d6:	f7 f3                	div    %ebx
 4d8:	89 d0                	mov    %edx,%eax
 4da:	0f b6 80 54 0c 00 00 	movzbl 0xc54(%eax),%eax
 4e1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4e5:	8b 75 10             	mov    0x10(%ebp),%esi
 4e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4eb:	ba 00 00 00 00       	mov    $0x0,%edx
 4f0:	f7 f6                	div    %esi
 4f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f9:	75 c7                	jne    4c2 <printint+0x39>
  if(neg)
 4fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4ff:	74 10                	je     511 <printint+0x88>
    buf[i++] = '-';
 501:	8b 45 f4             	mov    -0xc(%ebp),%eax
 504:	8d 50 01             	lea    0x1(%eax),%edx
 507:	89 55 f4             	mov    %edx,-0xc(%ebp)
 50a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 50f:	eb 1f                	jmp    530 <printint+0xa7>
 511:	eb 1d                	jmp    530 <printint+0xa7>
    putc(fd, buf[i]);
 513:	8d 55 dc             	lea    -0x24(%ebp),%edx
 516:	8b 45 f4             	mov    -0xc(%ebp),%eax
 519:	01 d0                	add    %edx,%eax
 51b:	0f b6 00             	movzbl (%eax),%eax
 51e:	0f be c0             	movsbl %al,%eax
 521:	89 44 24 04          	mov    %eax,0x4(%esp)
 525:	8b 45 08             	mov    0x8(%ebp),%eax
 528:	89 04 24             	mov    %eax,(%esp)
 52b:	e8 31 ff ff ff       	call   461 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 530:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 534:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 538:	79 d9                	jns    513 <printint+0x8a>
    putc(fd, buf[i]);
}
 53a:	83 c4 30             	add    $0x30,%esp
 53d:	5b                   	pop    %ebx
 53e:	5e                   	pop    %esi
 53f:	5d                   	pop    %ebp
 540:	c3                   	ret    

00000541 <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 541:	55                   	push   %ebp
 542:	89 e5                	mov    %esp,%ebp
 544:	83 ec 38             	sub    $0x38,%esp
 547:	8b 45 0c             	mov    0xc(%ebp),%eax
 54a:	89 45 e0             	mov    %eax,-0x20(%ebp)
 54d:	8b 45 10             	mov    0x10(%ebp),%eax
 550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 553:	8b 45 e0             	mov    -0x20(%ebp),%eax
 556:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 559:	89 d0                	mov    %edx,%eax
 55b:	31 d2                	xor    %edx,%edx
 55d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 560:	8b 45 e0             	mov    -0x20(%ebp),%eax
 563:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 566:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 56a:	74 22                	je     58e <printlong+0x4d>
 56c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 576:	00 
 577:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 57e:	00 
 57f:	89 44 24 04          	mov    %eax,0x4(%esp)
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	89 04 24             	mov    %eax,(%esp)
 589:	e8 fb fe ff ff       	call   489 <printint>
    printint(fd, lower, 16, 0);
 58e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 591:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 598:	00 
 599:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5a0:	00 
 5a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	89 04 24             	mov    %eax,(%esp)
 5ab:	e8 d9 fe ff ff       	call   489 <printint>
}
 5b0:	c9                   	leave  
 5b1:	c3                   	ret    

000005b2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 5b2:	55                   	push   %ebp
 5b3:	89 e5                	mov    %esp,%ebp
 5b5:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5bf:	8d 45 0c             	lea    0xc(%ebp),%eax
 5c2:	83 c0 04             	add    $0x4,%eax
 5c5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5cf:	e9 ba 01 00 00       	jmp    78e <printf+0x1dc>
    c = fmt[i] & 0xff;
 5d4:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5da:	01 d0                	add    %edx,%eax
 5dc:	0f b6 00             	movzbl (%eax),%eax
 5df:	0f be c0             	movsbl %al,%eax
 5e2:	25 ff 00 00 00       	and    $0xff,%eax
 5e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5ea:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5ee:	75 2c                	jne    61c <printf+0x6a>
      if(c == '%'){
 5f0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f4:	75 0c                	jne    602 <printf+0x50>
        state = '%';
 5f6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5fd:	e9 88 01 00 00       	jmp    78a <printf+0x1d8>
      } else {
        putc(fd, c);
 602:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 605:	0f be c0             	movsbl %al,%eax
 608:	89 44 24 04          	mov    %eax,0x4(%esp)
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	89 04 24             	mov    %eax,(%esp)
 612:	e8 4a fe ff ff       	call   461 <putc>
 617:	e9 6e 01 00 00       	jmp    78a <printf+0x1d8>
      }
    } else if(state == '%'){
 61c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 620:	0f 85 64 01 00 00    	jne    78a <printf+0x1d8>
      if(c == 'd'){
 626:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 62a:	75 2d                	jne    659 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 62c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 638:	00 
 639:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 640:	00 
 641:	89 44 24 04          	mov    %eax,0x4(%esp)
 645:	8b 45 08             	mov    0x8(%ebp),%eax
 648:	89 04 24             	mov    %eax,(%esp)
 64b:	e8 39 fe ff ff       	call   489 <printint>
        ap++;
 650:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 654:	e9 2a 01 00 00       	jmp    783 <printf+0x1d1>
      } else if(c == 'l') {
 659:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 65d:	75 38                	jne    697 <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 65f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 662:	8b 50 04             	mov    0x4(%eax),%edx
 665:	8b 00                	mov    (%eax),%eax
 667:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 66e:	00 
 66f:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 676:	00 
 677:	89 44 24 04          	mov    %eax,0x4(%esp)
 67b:	89 54 24 08          	mov    %edx,0x8(%esp)
 67f:	8b 45 08             	mov    0x8(%ebp),%eax
 682:	89 04 24             	mov    %eax,(%esp)
 685:	e8 b7 fe ff ff       	call   541 <printlong>
        // long longs take up 2 argument slots
        ap++;
 68a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 68e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 692:	e9 ec 00 00 00       	jmp    783 <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 697:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 69b:	74 06                	je     6a3 <printf+0xf1>
 69d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6a1:	75 2d                	jne    6d0 <printf+0x11e>
        printint(fd, *ap, 16, 0);
 6a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a6:	8b 00                	mov    (%eax),%eax
 6a8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6af:	00 
 6b0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6b7:	00 
 6b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bc:	8b 45 08             	mov    0x8(%ebp),%eax
 6bf:	89 04 24             	mov    %eax,(%esp)
 6c2:	e8 c2 fd ff ff       	call   489 <printint>
        ap++;
 6c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6cb:	e9 b3 00 00 00       	jmp    783 <printf+0x1d1>
      } else if(c == 's'){
 6d0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d4:	75 45                	jne    71b <printf+0x169>
        s = (char*)*ap;
 6d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d9:	8b 00                	mov    (%eax),%eax
 6db:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6de:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e6:	75 09                	jne    6f1 <printf+0x13f>
          s = "(null)";
 6e8:	c7 45 f4 c4 09 00 00 	movl   $0x9c4,-0xc(%ebp)
        while(*s != 0){
 6ef:	eb 1e                	jmp    70f <printf+0x15d>
 6f1:	eb 1c                	jmp    70f <printf+0x15d>
          putc(fd, *s);
 6f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f6:	0f b6 00             	movzbl (%eax),%eax
 6f9:	0f be c0             	movsbl %al,%eax
 6fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 700:	8b 45 08             	mov    0x8(%ebp),%eax
 703:	89 04 24             	mov    %eax,(%esp)
 706:	e8 56 fd ff ff       	call   461 <putc>
          s++;
 70b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 70f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 712:	0f b6 00             	movzbl (%eax),%eax
 715:	84 c0                	test   %al,%al
 717:	75 da                	jne    6f3 <printf+0x141>
 719:	eb 68                	jmp    783 <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 71f:	75 1d                	jne    73e <printf+0x18c>
        putc(fd, *ap);
 721:	8b 45 e8             	mov    -0x18(%ebp),%eax
 724:	8b 00                	mov    (%eax),%eax
 726:	0f be c0             	movsbl %al,%eax
 729:	89 44 24 04          	mov    %eax,0x4(%esp)
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
 730:	89 04 24             	mov    %eax,(%esp)
 733:	e8 29 fd ff ff       	call   461 <putc>
        ap++;
 738:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73c:	eb 45                	jmp    783 <printf+0x1d1>
      } else if(c == '%'){
 73e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 742:	75 17                	jne    75b <printf+0x1a9>
        putc(fd, c);
 744:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 747:	0f be c0             	movsbl %al,%eax
 74a:	89 44 24 04          	mov    %eax,0x4(%esp)
 74e:	8b 45 08             	mov    0x8(%ebp),%eax
 751:	89 04 24             	mov    %eax,(%esp)
 754:	e8 08 fd ff ff       	call   461 <putc>
 759:	eb 28                	jmp    783 <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 75b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 762:	00 
 763:	8b 45 08             	mov    0x8(%ebp),%eax
 766:	89 04 24             	mov    %eax,(%esp)
 769:	e8 f3 fc ff ff       	call   461 <putc>
        putc(fd, c);
 76e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 771:	0f be c0             	movsbl %al,%eax
 774:	89 44 24 04          	mov    %eax,0x4(%esp)
 778:	8b 45 08             	mov    0x8(%ebp),%eax
 77b:	89 04 24             	mov    %eax,(%esp)
 77e:	e8 de fc ff ff       	call   461 <putc>
      }
      state = 0;
 783:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 78a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 78e:	8b 55 0c             	mov    0xc(%ebp),%edx
 791:	8b 45 f0             	mov    -0x10(%ebp),%eax
 794:	01 d0                	add    %edx,%eax
 796:	0f b6 00             	movzbl (%eax),%eax
 799:	84 c0                	test   %al,%al
 79b:	0f 85 33 fe ff ff    	jne    5d4 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a1:	c9                   	leave  
 7a2:	c3                   	ret    

000007a3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a3:	55                   	push   %ebp
 7a4:	89 e5                	mov    %esp,%ebp
 7a6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ac:	83 e8 08             	sub    $0x8,%eax
 7af:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b2:	a1 70 0c 00 00       	mov    0xc70,%eax
 7b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ba:	eb 24                	jmp    7e0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bf:	8b 00                	mov    (%eax),%eax
 7c1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c4:	77 12                	ja     7d8 <free+0x35>
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cc:	77 24                	ja     7f2 <free+0x4f>
 7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d6:	77 1a                	ja     7f2 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7db:	8b 00                	mov    (%eax),%eax
 7dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e6:	76 d4                	jbe    7bc <free+0x19>
 7e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7eb:	8b 00                	mov    (%eax),%eax
 7ed:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f0:	76 ca                	jbe    7bc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f5:	8b 40 04             	mov    0x4(%eax),%eax
 7f8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 802:	01 c2                	add    %eax,%edx
 804:	8b 45 fc             	mov    -0x4(%ebp),%eax
 807:	8b 00                	mov    (%eax),%eax
 809:	39 c2                	cmp    %eax,%edx
 80b:	75 24                	jne    831 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 80d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 810:	8b 50 04             	mov    0x4(%eax),%edx
 813:	8b 45 fc             	mov    -0x4(%ebp),%eax
 816:	8b 00                	mov    (%eax),%eax
 818:	8b 40 04             	mov    0x4(%eax),%eax
 81b:	01 c2                	add    %eax,%edx
 81d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 820:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 823:	8b 45 fc             	mov    -0x4(%ebp),%eax
 826:	8b 00                	mov    (%eax),%eax
 828:	8b 10                	mov    (%eax),%edx
 82a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82d:	89 10                	mov    %edx,(%eax)
 82f:	eb 0a                	jmp    83b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 831:	8b 45 fc             	mov    -0x4(%ebp),%eax
 834:	8b 10                	mov    (%eax),%edx
 836:	8b 45 f8             	mov    -0x8(%ebp),%eax
 839:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 83b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83e:	8b 40 04             	mov    0x4(%eax),%eax
 841:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 848:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84b:	01 d0                	add    %edx,%eax
 84d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 850:	75 20                	jne    872 <free+0xcf>
    p->s.size += bp->s.size;
 852:	8b 45 fc             	mov    -0x4(%ebp),%eax
 855:	8b 50 04             	mov    0x4(%eax),%edx
 858:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85b:	8b 40 04             	mov    0x4(%eax),%eax
 85e:	01 c2                	add    %eax,%edx
 860:	8b 45 fc             	mov    -0x4(%ebp),%eax
 863:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 866:	8b 45 f8             	mov    -0x8(%ebp),%eax
 869:	8b 10                	mov    (%eax),%edx
 86b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86e:	89 10                	mov    %edx,(%eax)
 870:	eb 08                	jmp    87a <free+0xd7>
  } else
    p->s.ptr = bp;
 872:	8b 45 fc             	mov    -0x4(%ebp),%eax
 875:	8b 55 f8             	mov    -0x8(%ebp),%edx
 878:	89 10                	mov    %edx,(%eax)
  freep = p;
 87a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87d:	a3 70 0c 00 00       	mov    %eax,0xc70
}
 882:	c9                   	leave  
 883:	c3                   	ret    

00000884 <morecore>:

static Header*
morecore(uint nu)
{
 884:	55                   	push   %ebp
 885:	89 e5                	mov    %esp,%ebp
 887:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 88a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 891:	77 07                	ja     89a <morecore+0x16>
    nu = 4096;
 893:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 89a:	8b 45 08             	mov    0x8(%ebp),%eax
 89d:	c1 e0 03             	shl    $0x3,%eax
 8a0:	89 04 24             	mov    %eax,(%esp)
 8a3:	e8 91 fb ff ff       	call   439 <sbrk>
 8a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8ab:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8af:	75 07                	jne    8b8 <morecore+0x34>
    return 0;
 8b1:	b8 00 00 00 00       	mov    $0x0,%eax
 8b6:	eb 22                	jmp    8da <morecore+0x56>
  hp = (Header*)p;
 8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c1:	8b 55 08             	mov    0x8(%ebp),%edx
 8c4:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ca:	83 c0 08             	add    $0x8,%eax
 8cd:	89 04 24             	mov    %eax,(%esp)
 8d0:	e8 ce fe ff ff       	call   7a3 <free>
  return freep;
 8d5:	a1 70 0c 00 00       	mov    0xc70,%eax
}
 8da:	c9                   	leave  
 8db:	c3                   	ret    

000008dc <malloc>:

void*
malloc(uint nbytes)
{
 8dc:	55                   	push   %ebp
 8dd:	89 e5                	mov    %esp,%ebp
 8df:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e2:	8b 45 08             	mov    0x8(%ebp),%eax
 8e5:	83 c0 07             	add    $0x7,%eax
 8e8:	c1 e8 03             	shr    $0x3,%eax
 8eb:	83 c0 01             	add    $0x1,%eax
 8ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8f1:	a1 70 0c 00 00       	mov    0xc70,%eax
 8f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8fd:	75 23                	jne    922 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8ff:	c7 45 f0 68 0c 00 00 	movl   $0xc68,-0x10(%ebp)
 906:	8b 45 f0             	mov    -0x10(%ebp),%eax
 909:	a3 70 0c 00 00       	mov    %eax,0xc70
 90e:	a1 70 0c 00 00       	mov    0xc70,%eax
 913:	a3 68 0c 00 00       	mov    %eax,0xc68
    base.s.size = 0;
 918:	c7 05 6c 0c 00 00 00 	movl   $0x0,0xc6c
 91f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	8b 45 f0             	mov    -0x10(%ebp),%eax
 925:	8b 00                	mov    (%eax),%eax
 927:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 92a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92d:	8b 40 04             	mov    0x4(%eax),%eax
 930:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 933:	72 4d                	jb     982 <malloc+0xa6>
      if(p->s.size == nunits)
 935:	8b 45 f4             	mov    -0xc(%ebp),%eax
 938:	8b 40 04             	mov    0x4(%eax),%eax
 93b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 93e:	75 0c                	jne    94c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 940:	8b 45 f4             	mov    -0xc(%ebp),%eax
 943:	8b 10                	mov    (%eax),%edx
 945:	8b 45 f0             	mov    -0x10(%ebp),%eax
 948:	89 10                	mov    %edx,(%eax)
 94a:	eb 26                	jmp    972 <malloc+0x96>
      else {
        p->s.size -= nunits;
 94c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94f:	8b 40 04             	mov    0x4(%eax),%eax
 952:	2b 45 ec             	sub    -0x14(%ebp),%eax
 955:	89 c2                	mov    %eax,%edx
 957:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 95d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 960:	8b 40 04             	mov    0x4(%eax),%eax
 963:	c1 e0 03             	shl    $0x3,%eax
 966:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 969:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 96f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 972:	8b 45 f0             	mov    -0x10(%ebp),%eax
 975:	a3 70 0c 00 00       	mov    %eax,0xc70
      return (void*)(p + 1);
 97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97d:	83 c0 08             	add    $0x8,%eax
 980:	eb 38                	jmp    9ba <malloc+0xde>
    }
    if(p == freep)
 982:	a1 70 0c 00 00       	mov    0xc70,%eax
 987:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 98a:	75 1b                	jne    9a7 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 98c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 98f:	89 04 24             	mov    %eax,(%esp)
 992:	e8 ed fe ff ff       	call   884 <morecore>
 997:	89 45 f4             	mov    %eax,-0xc(%ebp)
 99a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99e:	75 07                	jne    9a7 <malloc+0xcb>
        return 0;
 9a0:	b8 00 00 00 00       	mov    $0x0,%eax
 9a5:	eb 13                	jmp    9ba <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b0:	8b 00                	mov    (%eax),%eax
 9b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9b5:	e9 70 ff ff ff       	jmp    92a <malloc+0x4e>
}
 9ba:	c9                   	leave  
 9bb:	c3                   	ret    
