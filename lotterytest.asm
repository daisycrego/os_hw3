
_lotterytest:     file format elf32-i386


Disassembly of section .text:

00000000 <spin>:
#include "types.h"
#include "user.h"
#include "date.h"

// Do some useless computations
void spin(int tix) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 48             	sub    $0x48,%esp
    struct rtcdate end;
    unsigned x = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    unsigned y = 0;
   d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while (x < 100000) {
  14:	eb 1a                	jmp    30 <spin+0x30>
        y = 0;
  16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        while (y < 10000) {
  1d:	eb 04                	jmp    23 <spin+0x23>
            y++;
  1f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    struct rtcdate end;
    unsigned x = 0;
    unsigned y = 0;
    while (x < 100000) {
        y = 0;
        while (y < 10000) {
  23:	81 7d f0 0f 27 00 00 	cmpl   $0x270f,-0x10(%ebp)
  2a:	76 f3                	jbe    1f <spin+0x1f>
            y++;
        }
        x++;
  2c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
// Do some useless computations
void spin(int tix) {
    struct rtcdate end;
    unsigned x = 0;
    unsigned y = 0;
    while (x < 100000) {
  30:	81 7d f4 9f 86 01 00 	cmpl   $0x1869f,-0xc(%ebp)
  37:	76 dd                	jbe    16 <spin+0x16>
            y++;
        }
        x++;
    }

    gettime(&end);
  39:	8d 45 d8             	lea    -0x28(%ebp),%eax
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 e4 03 00 00       	call   428 <gettime>

    printf(0, "spin with %d tickets ended at %d hours %d minutes %d seconds\n", tix, end.hour, end.minute, end.second);
  44:	8b 4d d8             	mov    -0x28(%ebp),%ecx
  47:	8b 55 dc             	mov    -0x24(%ebp),%edx
  4a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  4d:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  51:	89 54 24 10          	mov    %edx,0x10(%esp)
  55:	89 44 24 0c          	mov    %eax,0xc(%esp)
  59:	8b 45 08             	mov    0x8(%ebp),%eax
  5c:	89 44 24 08          	mov    %eax,0x8(%esp)
  60:	c7 44 24 04 94 09 00 	movl   $0x994,0x4(%esp)
  67:	00 
  68:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  6f:	e8 15 05 00 00       	call   589 <printf>
}
  74:	c9                   	leave  
  75:	c3                   	ret    

00000076 <main>:

int main() {
  76:	55                   	push   %ebp
  77:	89 e5                	mov    %esp,%ebp
  79:	83 e4 f0             	and    $0xfffffff0,%esp
  7c:	83 ec 40             	sub    $0x40,%esp

    int pid1;
    int pid2;
    struct rtcdate start;
    gettime(&start);
  7f:	8d 44 24 20          	lea    0x20(%esp),%eax
  83:	89 04 24             	mov    %eax,(%esp)
  86:	e8 9d 03 00 00       	call   428 <gettime>
    printf(0, "starting test at %d hours %d minutes %d seconds\n", start.hour, start.minute, start.second);
  8b:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  8f:	8b 54 24 24          	mov    0x24(%esp),%edx
  93:	8b 44 24 28          	mov    0x28(%esp),%eax
  97:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  9b:	89 54 24 0c          	mov    %edx,0xc(%esp)
  9f:	89 44 24 08          	mov    %eax,0x8(%esp)
  a3:	c7 44 24 04 d4 09 00 	movl   $0x9d4,0x4(%esp)
  aa:	00 
  ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  b2:	e8 d2 04 00 00       	call   589 <printf>
    if ((pid1 = fork()) == 0) {
  b7:	e8 c4 02 00 00       	call   380 <fork>
  bc:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  c0:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
  c5:	75 1d                	jne    e4 <main+0x6e>
        settickets(80);
  c7:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
  ce:	e8 5d 03 00 00       	call   430 <settickets>
        spin(80);
  d3:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
  da:	e8 21 ff ff ff       	call   0 <spin>
        exit();
  df:	e8 a4 02 00 00       	call   388 <exit>
    }
    else if ((pid2 = fork()) == 0) {
  e4:	e8 97 02 00 00       	call   380 <fork>
  e9:	89 44 24 38          	mov    %eax,0x38(%esp)
  ed:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
  f2:	75 1d                	jne    111 <main+0x9b>
        settickets(20);
  f4:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
  fb:	e8 30 03 00 00       	call   430 <settickets>
        spin(20);
 100:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 107:	e8 f4 fe ff ff       	call   0 <spin>
        exit();
 10c:	e8 77 02 00 00       	call   388 <exit>
    }
    // Go to sleep and wait for subprocesses to finish
    wait();
 111:	e8 7a 02 00 00       	call   390 <wait>
    wait();
 116:	e8 75 02 00 00       	call   390 <wait>
    exit();
 11b:	e8 68 02 00 00       	call   388 <exit>

00000120 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 125:	8b 4d 08             	mov    0x8(%ebp),%ecx
 128:	8b 55 10             	mov    0x10(%ebp),%edx
 12b:	8b 45 0c             	mov    0xc(%ebp),%eax
 12e:	89 cb                	mov    %ecx,%ebx
 130:	89 df                	mov    %ebx,%edi
 132:	89 d1                	mov    %edx,%ecx
 134:	fc                   	cld    
 135:	f3 aa                	rep stos %al,%es:(%edi)
 137:	89 ca                	mov    %ecx,%edx
 139:	89 fb                	mov    %edi,%ebx
 13b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 141:	5b                   	pop    %ebx
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    

00000145 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
 148:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14b:	8b 45 08             	mov    0x8(%ebp),%eax
 14e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 151:	90                   	nop
 152:	8b 45 08             	mov    0x8(%ebp),%eax
 155:	8d 50 01             	lea    0x1(%eax),%edx
 158:	89 55 08             	mov    %edx,0x8(%ebp)
 15b:	8b 55 0c             	mov    0xc(%ebp),%edx
 15e:	8d 4a 01             	lea    0x1(%edx),%ecx
 161:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 164:	0f b6 12             	movzbl (%edx),%edx
 167:	88 10                	mov    %dl,(%eax)
 169:	0f b6 00             	movzbl (%eax),%eax
 16c:	84 c0                	test   %al,%al
 16e:	75 e2                	jne    152 <strcpy+0xd>
    ;
  return os;
 170:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 173:	c9                   	leave  
 174:	c3                   	ret    

00000175 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 175:	55                   	push   %ebp
 176:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 178:	eb 08                	jmp    182 <strcmp+0xd>
    p++, q++;
 17a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	84 c0                	test   %al,%al
 18a:	74 10                	je     19c <strcmp+0x27>
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 10             	movzbl (%eax),%edx
 192:	8b 45 0c             	mov    0xc(%ebp),%eax
 195:	0f b6 00             	movzbl (%eax),%eax
 198:	38 c2                	cmp    %al,%dl
 19a:	74 de                	je     17a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	0f b6 00             	movzbl (%eax),%eax
 1a2:	0f b6 d0             	movzbl %al,%edx
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	0f b6 00             	movzbl (%eax),%eax
 1ab:	0f b6 c0             	movzbl %al,%eax
 1ae:	29 c2                	sub    %eax,%edx
 1b0:	89 d0                	mov    %edx,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    

000001b4 <strlen>:

uint
strlen(char *s)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c1:	eb 04                	jmp    1c7 <strlen+0x13>
 1c3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	01 d0                	add    %edx,%eax
 1cf:	0f b6 00             	movzbl (%eax),%eax
 1d2:	84 c0                	test   %al,%al
 1d4:	75 ed                	jne    1c3 <strlen+0xf>
    ;
  return n;
 1d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d9:	c9                   	leave  
 1da:	c3                   	ret    

000001db <memset>:

void*
memset(void *dst, int c, uint n)
{
 1db:	55                   	push   %ebp
 1dc:	89 e5                	mov    %esp,%ebp
 1de:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1e1:	8b 45 10             	mov    0x10(%ebp),%eax
 1e4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	89 04 24             	mov    %eax,(%esp)
 1f5:	e8 26 ff ff ff       	call   120 <stosb>
  return dst;
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fd:	c9                   	leave  
 1fe:	c3                   	ret    

000001ff <strchr>:

char*
strchr(const char *s, char c)
{
 1ff:	55                   	push   %ebp
 200:	89 e5                	mov    %esp,%ebp
 202:	83 ec 04             	sub    $0x4,%esp
 205:	8b 45 0c             	mov    0xc(%ebp),%eax
 208:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20b:	eb 14                	jmp    221 <strchr+0x22>
    if(*s == c)
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	0f b6 00             	movzbl (%eax),%eax
 213:	3a 45 fc             	cmp    -0x4(%ebp),%al
 216:	75 05                	jne    21d <strchr+0x1e>
      return (char*)s;
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	eb 13                	jmp    230 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 21d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 221:	8b 45 08             	mov    0x8(%ebp),%eax
 224:	0f b6 00             	movzbl (%eax),%eax
 227:	84 c0                	test   %al,%al
 229:	75 e2                	jne    20d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 22b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 230:	c9                   	leave  
 231:	c3                   	ret    

00000232 <gets>:

char*
gets(char *buf, int max)
{
 232:	55                   	push   %ebp
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 23f:	eb 4c                	jmp    28d <gets+0x5b>
    cc = read(0, &c, 1);
 241:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 248:	00 
 249:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24c:	89 44 24 04          	mov    %eax,0x4(%esp)
 250:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 257:	e8 44 01 00 00       	call   3a0 <read>
 25c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 25f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 263:	7f 02                	jg     267 <gets+0x35>
      break;
 265:	eb 31                	jmp    298 <gets+0x66>
    buf[i++] = c;
 267:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26a:	8d 50 01             	lea    0x1(%eax),%edx
 26d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 270:	89 c2                	mov    %eax,%edx
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	01 c2                	add    %eax,%edx
 277:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 27d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 281:	3c 0a                	cmp    $0xa,%al
 283:	74 13                	je     298 <gets+0x66>
 285:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 289:	3c 0d                	cmp    $0xd,%al
 28b:	74 0b                	je     298 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 28d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 290:	83 c0 01             	add    $0x1,%eax
 293:	3b 45 0c             	cmp    0xc(%ebp),%eax
 296:	7c a9                	jl     241 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 298:	8b 55 f4             	mov    -0xc(%ebp),%edx
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	01 d0                	add    %edx,%eax
 2a0:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a6:	c9                   	leave  
 2a7:	c3                   	ret    

000002a8 <stat>:

int
stat(char *n, struct stat *st)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b5:	00 
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	89 04 24             	mov    %eax,(%esp)
 2bc:	e8 07 01 00 00       	call   3c8 <open>
 2c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c8:	79 07                	jns    2d1 <stat+0x29>
    return -1;
 2ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2cf:	eb 23                	jmp    2f4 <stat+0x4c>
  r = fstat(fd, st);
 2d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2db:	89 04 24             	mov    %eax,(%esp)
 2de:	e8 fd 00 00 00       	call   3e0 <fstat>
 2e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e9:	89 04 24             	mov    %eax,(%esp)
 2ec:	e8 bf 00 00 00       	call   3b0 <close>
  return r;
 2f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2f4:	c9                   	leave  
 2f5:	c3                   	ret    

000002f6 <atoi>:

int
atoi(const char *s)
{
 2f6:	55                   	push   %ebp
 2f7:	89 e5                	mov    %esp,%ebp
 2f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 303:	eb 25                	jmp    32a <atoi+0x34>
    n = n*10 + *s++ - '0';
 305:	8b 55 fc             	mov    -0x4(%ebp),%edx
 308:	89 d0                	mov    %edx,%eax
 30a:	c1 e0 02             	shl    $0x2,%eax
 30d:	01 d0                	add    %edx,%eax
 30f:	01 c0                	add    %eax,%eax
 311:	89 c1                	mov    %eax,%ecx
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	8d 50 01             	lea    0x1(%eax),%edx
 319:	89 55 08             	mov    %edx,0x8(%ebp)
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	0f be c0             	movsbl %al,%eax
 322:	01 c8                	add    %ecx,%eax
 324:	83 e8 30             	sub    $0x30,%eax
 327:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32a:	8b 45 08             	mov    0x8(%ebp),%eax
 32d:	0f b6 00             	movzbl (%eax),%eax
 330:	3c 2f                	cmp    $0x2f,%al
 332:	7e 0a                	jle    33e <atoi+0x48>
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	0f b6 00             	movzbl (%eax),%eax
 33a:	3c 39                	cmp    $0x39,%al
 33c:	7e c7                	jle    305 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 33e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 341:	c9                   	leave  
 342:	c3                   	ret    

00000343 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 343:	55                   	push   %ebp
 344:	89 e5                	mov    %esp,%ebp
 346:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 34f:	8b 45 0c             	mov    0xc(%ebp),%eax
 352:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 355:	eb 17                	jmp    36e <memmove+0x2b>
    *dst++ = *src++;
 357:	8b 45 fc             	mov    -0x4(%ebp),%eax
 35a:	8d 50 01             	lea    0x1(%eax),%edx
 35d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 360:	8b 55 f8             	mov    -0x8(%ebp),%edx
 363:	8d 4a 01             	lea    0x1(%edx),%ecx
 366:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 369:	0f b6 12             	movzbl (%edx),%edx
 36c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	8b 45 10             	mov    0x10(%ebp),%eax
 371:	8d 50 ff             	lea    -0x1(%eax),%edx
 374:	89 55 10             	mov    %edx,0x10(%ebp)
 377:	85 c0                	test   %eax,%eax
 379:	7f dc                	jg     357 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 37e:	c9                   	leave  
 37f:	c3                   	ret    

00000380 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 380:	b8 01 00 00 00       	mov    $0x1,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <exit>:
SYSCALL(exit)
 388:	b8 02 00 00 00       	mov    $0x2,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <wait>:
SYSCALL(wait)
 390:	b8 03 00 00 00       	mov    $0x3,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <pipe>:
SYSCALL(pipe)
 398:	b8 04 00 00 00       	mov    $0x4,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <read>:
SYSCALL(read)
 3a0:	b8 05 00 00 00       	mov    $0x5,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <write>:
SYSCALL(write)
 3a8:	b8 10 00 00 00       	mov    $0x10,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <close>:
SYSCALL(close)
 3b0:	b8 15 00 00 00       	mov    $0x15,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <kill>:
SYSCALL(kill)
 3b8:	b8 06 00 00 00       	mov    $0x6,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <exec>:
SYSCALL(exec)
 3c0:	b8 07 00 00 00       	mov    $0x7,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <open>:
SYSCALL(open)
 3c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mknod>:
SYSCALL(mknod)
 3d0:	b8 11 00 00 00       	mov    $0x11,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <unlink>:
SYSCALL(unlink)
 3d8:	b8 12 00 00 00       	mov    $0x12,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <fstat>:
SYSCALL(fstat)
 3e0:	b8 08 00 00 00       	mov    $0x8,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <link>:
SYSCALL(link)
 3e8:	b8 13 00 00 00       	mov    $0x13,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <mkdir>:
SYSCALL(mkdir)
 3f0:	b8 14 00 00 00       	mov    $0x14,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <chdir>:
SYSCALL(chdir)
 3f8:	b8 09 00 00 00       	mov    $0x9,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <dup>:
SYSCALL(dup)
 400:	b8 0a 00 00 00       	mov    $0xa,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <getpid>:
SYSCALL(getpid)
 408:	b8 0b 00 00 00       	mov    $0xb,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <sbrk>:
SYSCALL(sbrk)
 410:	b8 0c 00 00 00       	mov    $0xc,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <sleep>:
SYSCALL(sleep)
 418:	b8 0d 00 00 00       	mov    $0xd,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <uptime>:
SYSCALL(uptime)
 420:	b8 0e 00 00 00       	mov    $0xe,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <gettime>:
SYSCALL(gettime)
 428:	b8 16 00 00 00       	mov    $0x16,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <settickets>:
SYSCALL(settickets)
 430:	b8 17 00 00 00       	mov    $0x17,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 438:	55                   	push   %ebp
 439:	89 e5                	mov    %esp,%ebp
 43b:	83 ec 18             	sub    $0x18,%esp
 43e:	8b 45 0c             	mov    0xc(%ebp),%eax
 441:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 444:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 44b:	00 
 44c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 44f:	89 44 24 04          	mov    %eax,0x4(%esp)
 453:	8b 45 08             	mov    0x8(%ebp),%eax
 456:	89 04 24             	mov    %eax,(%esp)
 459:	e8 4a ff ff ff       	call   3a8 <write>
}
 45e:	c9                   	leave  
 45f:	c3                   	ret    

00000460 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	56                   	push   %esi
 464:	53                   	push   %ebx
 465:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 468:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 46f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 473:	74 17                	je     48c <printint+0x2c>
 475:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 479:	79 11                	jns    48c <printint+0x2c>
    neg = 1;
 47b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 482:	8b 45 0c             	mov    0xc(%ebp),%eax
 485:	f7 d8                	neg    %eax
 487:	89 45 ec             	mov    %eax,-0x14(%ebp)
 48a:	eb 06                	jmp    492 <printint+0x32>
  } else {
    x = xx;
 48c:	8b 45 0c             	mov    0xc(%ebp),%eax
 48f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 492:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 499:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 49c:	8d 41 01             	lea    0x1(%ecx),%eax
 49f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4a2:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a8:	ba 00 00 00 00       	mov    $0x0,%edx
 4ad:	f7 f3                	div    %ebx
 4af:	89 d0                	mov    %edx,%eax
 4b1:	0f b6 80 90 0c 00 00 	movzbl 0xc90(%eax),%eax
 4b8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4bc:	8b 75 10             	mov    0x10(%ebp),%esi
 4bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4c2:	ba 00 00 00 00       	mov    $0x0,%edx
 4c7:	f7 f6                	div    %esi
 4c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d0:	75 c7                	jne    499 <printint+0x39>
  if(neg)
 4d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4d6:	74 10                	je     4e8 <printint+0x88>
    buf[i++] = '-';
 4d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4db:	8d 50 01             	lea    0x1(%eax),%edx
 4de:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4e1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4e6:	eb 1f                	jmp    507 <printint+0xa7>
 4e8:	eb 1d                	jmp    507 <printint+0xa7>
    putc(fd, buf[i]);
 4ea:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f0:	01 d0                	add    %edx,%eax
 4f2:	0f b6 00             	movzbl (%eax),%eax
 4f5:	0f be c0             	movsbl %al,%eax
 4f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fc:	8b 45 08             	mov    0x8(%ebp),%eax
 4ff:	89 04 24             	mov    %eax,(%esp)
 502:	e8 31 ff ff ff       	call   438 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 507:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 50b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 50f:	79 d9                	jns    4ea <printint+0x8a>
    putc(fd, buf[i]);
}
 511:	83 c4 30             	add    $0x30,%esp
 514:	5b                   	pop    %ebx
 515:	5e                   	pop    %esi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    

00000518 <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 518:	55                   	push   %ebp
 519:	89 e5                	mov    %esp,%ebp
 51b:	83 ec 38             	sub    $0x38,%esp
 51e:	8b 45 0c             	mov    0xc(%ebp),%eax
 521:	89 45 e0             	mov    %eax,-0x20(%ebp)
 524:	8b 45 10             	mov    0x10(%ebp),%eax
 527:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 52a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 52d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 530:	89 d0                	mov    %edx,%eax
 532:	31 d2                	xor    %edx,%edx
 534:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 537:	8b 45 e0             	mov    -0x20(%ebp),%eax
 53a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 53d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 541:	74 22                	je     565 <printlong+0x4d>
 543:	8b 45 f4             	mov    -0xc(%ebp),%eax
 546:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 54d:	00 
 54e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 555:	00 
 556:	89 44 24 04          	mov    %eax,0x4(%esp)
 55a:	8b 45 08             	mov    0x8(%ebp),%eax
 55d:	89 04 24             	mov    %eax,(%esp)
 560:	e8 fb fe ff ff       	call   460 <printint>
    printint(fd, lower, 16, 0);
 565:	8b 45 f0             	mov    -0x10(%ebp),%eax
 568:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 56f:	00 
 570:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 577:	00 
 578:	89 44 24 04          	mov    %eax,0x4(%esp)
 57c:	8b 45 08             	mov    0x8(%ebp),%eax
 57f:	89 04 24             	mov    %eax,(%esp)
 582:	e8 d9 fe ff ff       	call   460 <printint>
}
 587:	c9                   	leave  
 588:	c3                   	ret    

00000589 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 589:	55                   	push   %ebp
 58a:	89 e5                	mov    %esp,%ebp
 58c:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 58f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 596:	8d 45 0c             	lea    0xc(%ebp),%eax
 599:	83 c0 04             	add    $0x4,%eax
 59c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 59f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5a6:	e9 ba 01 00 00       	jmp    765 <printf+0x1dc>
    c = fmt[i] & 0xff;
 5ab:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b1:	01 d0                	add    %edx,%eax
 5b3:	0f b6 00             	movzbl (%eax),%eax
 5b6:	0f be c0             	movsbl %al,%eax
 5b9:	25 ff 00 00 00       	and    $0xff,%eax
 5be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c5:	75 2c                	jne    5f3 <printf+0x6a>
      if(c == '%'){
 5c7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5cb:	75 0c                	jne    5d9 <printf+0x50>
        state = '%';
 5cd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5d4:	e9 88 01 00 00       	jmp    761 <printf+0x1d8>
      } else {
        putc(fd, c);
 5d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5dc:	0f be c0             	movsbl %al,%eax
 5df:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	89 04 24             	mov    %eax,(%esp)
 5e9:	e8 4a fe ff ff       	call   438 <putc>
 5ee:	e9 6e 01 00 00       	jmp    761 <printf+0x1d8>
      }
    } else if(state == '%'){
 5f3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5f7:	0f 85 64 01 00 00    	jne    761 <printf+0x1d8>
      if(c == 'd'){
 5fd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 601:	75 2d                	jne    630 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 603:	8b 45 e8             	mov    -0x18(%ebp),%eax
 606:	8b 00                	mov    (%eax),%eax
 608:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 60f:	00 
 610:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 617:	00 
 618:	89 44 24 04          	mov    %eax,0x4(%esp)
 61c:	8b 45 08             	mov    0x8(%ebp),%eax
 61f:	89 04 24             	mov    %eax,(%esp)
 622:	e8 39 fe ff ff       	call   460 <printint>
        ap++;
 627:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62b:	e9 2a 01 00 00       	jmp    75a <printf+0x1d1>
      } else if(c == 'l') {
 630:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 634:	75 38                	jne    66e <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 636:	8b 45 e8             	mov    -0x18(%ebp),%eax
 639:	8b 50 04             	mov    0x4(%eax),%edx
 63c:	8b 00                	mov    (%eax),%eax
 63e:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 645:	00 
 646:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 64d:	00 
 64e:	89 44 24 04          	mov    %eax,0x4(%esp)
 652:	89 54 24 08          	mov    %edx,0x8(%esp)
 656:	8b 45 08             	mov    0x8(%ebp),%eax
 659:	89 04 24             	mov    %eax,(%esp)
 65c:	e8 b7 fe ff ff       	call   518 <printlong>
        // long longs take up 2 argument slots
        ap++;
 661:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 665:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 669:	e9 ec 00 00 00       	jmp    75a <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 66e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 672:	74 06                	je     67a <printf+0xf1>
 674:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 678:	75 2d                	jne    6a7 <printf+0x11e>
        printint(fd, *ap, 16, 0);
 67a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67d:	8b 00                	mov    (%eax),%eax
 67f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 686:	00 
 687:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 68e:	00 
 68f:	89 44 24 04          	mov    %eax,0x4(%esp)
 693:	8b 45 08             	mov    0x8(%ebp),%eax
 696:	89 04 24             	mov    %eax,(%esp)
 699:	e8 c2 fd ff ff       	call   460 <printint>
        ap++;
 69e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6a2:	e9 b3 00 00 00       	jmp    75a <printf+0x1d1>
      } else if(c == 's'){
 6a7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6ab:	75 45                	jne    6f2 <printf+0x169>
        s = (char*)*ap;
 6ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6b5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6bd:	75 09                	jne    6c8 <printf+0x13f>
          s = "(null)";
 6bf:	c7 45 f4 05 0a 00 00 	movl   $0xa05,-0xc(%ebp)
        while(*s != 0){
 6c6:	eb 1e                	jmp    6e6 <printf+0x15d>
 6c8:	eb 1c                	jmp    6e6 <printf+0x15d>
          putc(fd, *s);
 6ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cd:	0f b6 00             	movzbl (%eax),%eax
 6d0:	0f be c0             	movsbl %al,%eax
 6d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d7:	8b 45 08             	mov    0x8(%ebp),%eax
 6da:	89 04 24             	mov    %eax,(%esp)
 6dd:	e8 56 fd ff ff       	call   438 <putc>
          s++;
 6e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e9:	0f b6 00             	movzbl (%eax),%eax
 6ec:	84 c0                	test   %al,%al
 6ee:	75 da                	jne    6ca <printf+0x141>
 6f0:	eb 68                	jmp    75a <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6f2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6f6:	75 1d                	jne    715 <printf+0x18c>
        putc(fd, *ap);
 6f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6fb:	8b 00                	mov    (%eax),%eax
 6fd:	0f be c0             	movsbl %al,%eax
 700:	89 44 24 04          	mov    %eax,0x4(%esp)
 704:	8b 45 08             	mov    0x8(%ebp),%eax
 707:	89 04 24             	mov    %eax,(%esp)
 70a:	e8 29 fd ff ff       	call   438 <putc>
        ap++;
 70f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 713:	eb 45                	jmp    75a <printf+0x1d1>
      } else if(c == '%'){
 715:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 719:	75 17                	jne    732 <printf+0x1a9>
        putc(fd, c);
 71b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71e:	0f be c0             	movsbl %al,%eax
 721:	89 44 24 04          	mov    %eax,0x4(%esp)
 725:	8b 45 08             	mov    0x8(%ebp),%eax
 728:	89 04 24             	mov    %eax,(%esp)
 72b:	e8 08 fd ff ff       	call   438 <putc>
 730:	eb 28                	jmp    75a <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 732:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 739:	00 
 73a:	8b 45 08             	mov    0x8(%ebp),%eax
 73d:	89 04 24             	mov    %eax,(%esp)
 740:	e8 f3 fc ff ff       	call   438 <putc>
        putc(fd, c);
 745:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 748:	0f be c0             	movsbl %al,%eax
 74b:	89 44 24 04          	mov    %eax,0x4(%esp)
 74f:	8b 45 08             	mov    0x8(%ebp),%eax
 752:	89 04 24             	mov    %eax,(%esp)
 755:	e8 de fc ff ff       	call   438 <putc>
      }
      state = 0;
 75a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 761:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 765:	8b 55 0c             	mov    0xc(%ebp),%edx
 768:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76b:	01 d0                	add    %edx,%eax
 76d:	0f b6 00             	movzbl (%eax),%eax
 770:	84 c0                	test   %al,%al
 772:	0f 85 33 fe ff ff    	jne    5ab <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 778:	c9                   	leave  
 779:	c3                   	ret    

0000077a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 77a:	55                   	push   %ebp
 77b:	89 e5                	mov    %esp,%ebp
 77d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 780:	8b 45 08             	mov    0x8(%ebp),%eax
 783:	83 e8 08             	sub    $0x8,%eax
 786:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 789:	a1 ac 0c 00 00       	mov    0xcac,%eax
 78e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 791:	eb 24                	jmp    7b7 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 793:	8b 45 fc             	mov    -0x4(%ebp),%eax
 796:	8b 00                	mov    (%eax),%eax
 798:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 79b:	77 12                	ja     7af <free+0x35>
 79d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a3:	77 24                	ja     7c9 <free+0x4f>
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ad:	77 1a                	ja     7c9 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b2:	8b 00                	mov    (%eax),%eax
 7b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7bd:	76 d4                	jbe    793 <free+0x19>
 7bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c2:	8b 00                	mov    (%eax),%eax
 7c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7c7:	76 ca                	jbe    793 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cc:	8b 40 04             	mov    0x4(%eax),%eax
 7cf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d9:	01 c2                	add    %eax,%edx
 7db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7de:	8b 00                	mov    (%eax),%eax
 7e0:	39 c2                	cmp    %eax,%edx
 7e2:	75 24                	jne    808 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e7:	8b 50 04             	mov    0x4(%eax),%edx
 7ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ed:	8b 00                	mov    (%eax),%eax
 7ef:	8b 40 04             	mov    0x4(%eax),%eax
 7f2:	01 c2                	add    %eax,%edx
 7f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fd:	8b 00                	mov    (%eax),%eax
 7ff:	8b 10                	mov    (%eax),%edx
 801:	8b 45 f8             	mov    -0x8(%ebp),%eax
 804:	89 10                	mov    %edx,(%eax)
 806:	eb 0a                	jmp    812 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 808:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80b:	8b 10                	mov    (%eax),%edx
 80d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 810:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 812:	8b 45 fc             	mov    -0x4(%ebp),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 81f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 822:	01 d0                	add    %edx,%eax
 824:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 827:	75 20                	jne    849 <free+0xcf>
    p->s.size += bp->s.size;
 829:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82c:	8b 50 04             	mov    0x4(%eax),%edx
 82f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 832:	8b 40 04             	mov    0x4(%eax),%eax
 835:	01 c2                	add    %eax,%edx
 837:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 83d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 840:	8b 10                	mov    (%eax),%edx
 842:	8b 45 fc             	mov    -0x4(%ebp),%eax
 845:	89 10                	mov    %edx,(%eax)
 847:	eb 08                	jmp    851 <free+0xd7>
  } else
    p->s.ptr = bp;
 849:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 84f:	89 10                	mov    %edx,(%eax)
  freep = p;
 851:	8b 45 fc             	mov    -0x4(%ebp),%eax
 854:	a3 ac 0c 00 00       	mov    %eax,0xcac
}
 859:	c9                   	leave  
 85a:	c3                   	ret    

0000085b <morecore>:

static Header*
morecore(uint nu)
{
 85b:	55                   	push   %ebp
 85c:	89 e5                	mov    %esp,%ebp
 85e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 861:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 868:	77 07                	ja     871 <morecore+0x16>
    nu = 4096;
 86a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 871:	8b 45 08             	mov    0x8(%ebp),%eax
 874:	c1 e0 03             	shl    $0x3,%eax
 877:	89 04 24             	mov    %eax,(%esp)
 87a:	e8 91 fb ff ff       	call   410 <sbrk>
 87f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 882:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 886:	75 07                	jne    88f <morecore+0x34>
    return 0;
 888:	b8 00 00 00 00       	mov    $0x0,%eax
 88d:	eb 22                	jmp    8b1 <morecore+0x56>
  hp = (Header*)p;
 88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 892:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 895:	8b 45 f0             	mov    -0x10(%ebp),%eax
 898:	8b 55 08             	mov    0x8(%ebp),%edx
 89b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 89e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a1:	83 c0 08             	add    $0x8,%eax
 8a4:	89 04 24             	mov    %eax,(%esp)
 8a7:	e8 ce fe ff ff       	call   77a <free>
  return freep;
 8ac:	a1 ac 0c 00 00       	mov    0xcac,%eax
}
 8b1:	c9                   	leave  
 8b2:	c3                   	ret    

000008b3 <malloc>:

void*
malloc(uint nbytes)
{
 8b3:	55                   	push   %ebp
 8b4:	89 e5                	mov    %esp,%ebp
 8b6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b9:	8b 45 08             	mov    0x8(%ebp),%eax
 8bc:	83 c0 07             	add    $0x7,%eax
 8bf:	c1 e8 03             	shr    $0x3,%eax
 8c2:	83 c0 01             	add    $0x1,%eax
 8c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8c8:	a1 ac 0c 00 00       	mov    0xcac,%eax
 8cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8d4:	75 23                	jne    8f9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8d6:	c7 45 f0 a4 0c 00 00 	movl   $0xca4,-0x10(%ebp)
 8dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e0:	a3 ac 0c 00 00       	mov    %eax,0xcac
 8e5:	a1 ac 0c 00 00       	mov    0xcac,%eax
 8ea:	a3 a4 0c 00 00       	mov    %eax,0xca4
    base.s.size = 0;
 8ef:	c7 05 a8 0c 00 00 00 	movl   $0x0,0xca8
 8f6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fc:	8b 00                	mov    (%eax),%eax
 8fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 901:	8b 45 f4             	mov    -0xc(%ebp),%eax
 904:	8b 40 04             	mov    0x4(%eax),%eax
 907:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 90a:	72 4d                	jb     959 <malloc+0xa6>
      if(p->s.size == nunits)
 90c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90f:	8b 40 04             	mov    0x4(%eax),%eax
 912:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 915:	75 0c                	jne    923 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 917:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91a:	8b 10                	mov    (%eax),%edx
 91c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91f:	89 10                	mov    %edx,(%eax)
 921:	eb 26                	jmp    949 <malloc+0x96>
      else {
        p->s.size -= nunits;
 923:	8b 45 f4             	mov    -0xc(%ebp),%eax
 926:	8b 40 04             	mov    0x4(%eax),%eax
 929:	2b 45 ec             	sub    -0x14(%ebp),%eax
 92c:	89 c2                	mov    %eax,%edx
 92e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 931:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 934:	8b 45 f4             	mov    -0xc(%ebp),%eax
 937:	8b 40 04             	mov    0x4(%eax),%eax
 93a:	c1 e0 03             	shl    $0x3,%eax
 93d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 940:	8b 45 f4             	mov    -0xc(%ebp),%eax
 943:	8b 55 ec             	mov    -0x14(%ebp),%edx
 946:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 949:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94c:	a3 ac 0c 00 00       	mov    %eax,0xcac
      return (void*)(p + 1);
 951:	8b 45 f4             	mov    -0xc(%ebp),%eax
 954:	83 c0 08             	add    $0x8,%eax
 957:	eb 38                	jmp    991 <malloc+0xde>
    }
    if(p == freep)
 959:	a1 ac 0c 00 00       	mov    0xcac,%eax
 95e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 961:	75 1b                	jne    97e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 963:	8b 45 ec             	mov    -0x14(%ebp),%eax
 966:	89 04 24             	mov    %eax,(%esp)
 969:	e8 ed fe ff ff       	call   85b <morecore>
 96e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 971:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 975:	75 07                	jne    97e <malloc+0xcb>
        return 0;
 977:	b8 00 00 00 00       	mov    $0x0,%eax
 97c:	eb 13                	jmp    991 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 981:	89 45 f0             	mov    %eax,-0x10(%ebp)
 984:	8b 45 f4             	mov    -0xc(%ebp),%eax
 987:	8b 00                	mov    (%eax),%eax
 989:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 98c:	e9 70 ff ff ff       	jmp    901 <malloc+0x4e>
}
 991:	c9                   	leave  
 992:	c3                   	ret    
