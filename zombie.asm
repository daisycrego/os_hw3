
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 75 02 00 00       	call   283 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 fd 02 00 00       	call   31b <sleep>
  exit();
  1e:	e8 68 02 00 00       	call   28b <exit>

00000023 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  23:	55                   	push   %ebp
  24:	89 e5                	mov    %esp,%ebp
  26:	57                   	push   %edi
  27:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  28:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2b:	8b 55 10             	mov    0x10(%ebp),%edx
  2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  31:	89 cb                	mov    %ecx,%ebx
  33:	89 df                	mov    %ebx,%edi
  35:	89 d1                	mov    %edx,%ecx
  37:	fc                   	cld    
  38:	f3 aa                	rep stos %al,%es:(%edi)
  3a:	89 ca                	mov    %ecx,%edx
  3c:	89 fb                	mov    %edi,%ebx
  3e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  41:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  44:	5b                   	pop    %ebx
  45:	5f                   	pop    %edi
  46:	5d                   	pop    %ebp
  47:	c3                   	ret    

00000048 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4e:	8b 45 08             	mov    0x8(%ebp),%eax
  51:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  54:	90                   	nop
  55:	8b 45 08             	mov    0x8(%ebp),%eax
  58:	8d 50 01             	lea    0x1(%eax),%edx
  5b:	89 55 08             	mov    %edx,0x8(%ebp)
  5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  61:	8d 4a 01             	lea    0x1(%edx),%ecx
  64:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  67:	0f b6 12             	movzbl (%edx),%edx
  6a:	88 10                	mov    %dl,(%eax)
  6c:	0f b6 00             	movzbl (%eax),%eax
  6f:	84 c0                	test   %al,%al
  71:	75 e2                	jne    55 <strcpy+0xd>
    ;
  return os;
  73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  76:	c9                   	leave  
  77:	c3                   	ret    

00000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  7b:	eb 08                	jmp    85 <strcmp+0xd>
    p++, q++;
  7d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  81:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  85:	8b 45 08             	mov    0x8(%ebp),%eax
  88:	0f b6 00             	movzbl (%eax),%eax
  8b:	84 c0                	test   %al,%al
  8d:	74 10                	je     9f <strcmp+0x27>
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	0f b6 10             	movzbl (%eax),%edx
  95:	8b 45 0c             	mov    0xc(%ebp),%eax
  98:	0f b6 00             	movzbl (%eax),%eax
  9b:	38 c2                	cmp    %al,%dl
  9d:	74 de                	je     7d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  9f:	8b 45 08             	mov    0x8(%ebp),%eax
  a2:	0f b6 00             	movzbl (%eax),%eax
  a5:	0f b6 d0             	movzbl %al,%edx
  a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  ab:	0f b6 00             	movzbl (%eax),%eax
  ae:	0f b6 c0             	movzbl %al,%eax
  b1:	29 c2                	sub    %eax,%edx
  b3:	89 d0                	mov    %edx,%eax
}
  b5:	5d                   	pop    %ebp
  b6:	c3                   	ret    

000000b7 <strlen>:

uint
strlen(char *s)
{
  b7:	55                   	push   %ebp
  b8:	89 e5                	mov    %esp,%ebp
  ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c4:	eb 04                	jmp    ca <strlen+0x13>
  c6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  cd:	8b 45 08             	mov    0x8(%ebp),%eax
  d0:	01 d0                	add    %edx,%eax
  d2:	0f b6 00             	movzbl (%eax),%eax
  d5:	84 c0                	test   %al,%al
  d7:	75 ed                	jne    c6 <strlen+0xf>
    ;
  return n;
  d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  dc:	c9                   	leave  
  dd:	c3                   	ret    

000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	55                   	push   %ebp
  df:	89 e5                	mov    %esp,%ebp
  e1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  e4:	8b 45 10             	mov    0x10(%ebp),%eax
  e7:	89 44 24 08          	mov    %eax,0x8(%esp)
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
  f5:	89 04 24             	mov    %eax,(%esp)
  f8:	e8 26 ff ff ff       	call   23 <stosb>
  return dst;
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 100:	c9                   	leave  
 101:	c3                   	ret    

00000102 <strchr>:

char*
strchr(const char *s, char c)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 04             	sub    $0x4,%esp
 108:	8b 45 0c             	mov    0xc(%ebp),%eax
 10b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10e:	eb 14                	jmp    124 <strchr+0x22>
    if(*s == c)
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	0f b6 00             	movzbl (%eax),%eax
 116:	3a 45 fc             	cmp    -0x4(%ebp),%al
 119:	75 05                	jne    120 <strchr+0x1e>
      return (char*)s;
 11b:	8b 45 08             	mov    0x8(%ebp),%eax
 11e:	eb 13                	jmp    133 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 120:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	0f b6 00             	movzbl (%eax),%eax
 12a:	84 c0                	test   %al,%al
 12c:	75 e2                	jne    110 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 12e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 133:	c9                   	leave  
 134:	c3                   	ret    

00000135 <gets>:

char*
gets(char *buf, int max)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 142:	eb 4c                	jmp    190 <gets+0x5b>
    cc = read(0, &c, 1);
 144:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 14b:	00 
 14c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14f:	89 44 24 04          	mov    %eax,0x4(%esp)
 153:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15a:	e8 44 01 00 00       	call   2a3 <read>
 15f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 162:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 166:	7f 02                	jg     16a <gets+0x35>
      break;
 168:	eb 31                	jmp    19b <gets+0x66>
    buf[i++] = c;
 16a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16d:	8d 50 01             	lea    0x1(%eax),%edx
 170:	89 55 f4             	mov    %edx,-0xc(%ebp)
 173:	89 c2                	mov    %eax,%edx
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	01 c2                	add    %eax,%edx
 17a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 180:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 184:	3c 0a                	cmp    $0xa,%al
 186:	74 13                	je     19b <gets+0x66>
 188:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18c:	3c 0d                	cmp    $0xd,%al
 18e:	74 0b                	je     19b <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	8b 45 f4             	mov    -0xc(%ebp),%eax
 193:	83 c0 01             	add    $0x1,%eax
 196:	3b 45 0c             	cmp    0xc(%ebp),%eax
 199:	7c a9                	jl     144 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 19e:	8b 45 08             	mov    0x8(%ebp),%eax
 1a1:	01 d0                	add    %edx,%eax
 1a3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a9:	c9                   	leave  
 1aa:	c3                   	ret    

000001ab <stat>:

int
stat(char *n, struct stat *st)
{
 1ab:	55                   	push   %ebp
 1ac:	89 e5                	mov    %esp,%ebp
 1ae:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b8:	00 
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	89 04 24             	mov    %eax,(%esp)
 1bf:	e8 07 01 00 00       	call   2cb <open>
 1c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1cb:	79 07                	jns    1d4 <stat+0x29>
    return -1;
 1cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d2:	eb 23                	jmp    1f7 <stat+0x4c>
  r = fstat(fd, st);
 1d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	89 04 24             	mov    %eax,(%esp)
 1e1:	e8 fd 00 00 00       	call   2e3 <fstat>
 1e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ec:	89 04 24             	mov    %eax,(%esp)
 1ef:	e8 bf 00 00 00       	call   2b3 <close>
  return r;
 1f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    

000001f9 <atoi>:

int
atoi(const char *s)
{
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 206:	eb 25                	jmp    22d <atoi+0x34>
    n = n*10 + *s++ - '0';
 208:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20b:	89 d0                	mov    %edx,%eax
 20d:	c1 e0 02             	shl    $0x2,%eax
 210:	01 d0                	add    %edx,%eax
 212:	01 c0                	add    %eax,%eax
 214:	89 c1                	mov    %eax,%ecx
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	8d 50 01             	lea    0x1(%eax),%edx
 21c:	89 55 08             	mov    %edx,0x8(%ebp)
 21f:	0f b6 00             	movzbl (%eax),%eax
 222:	0f be c0             	movsbl %al,%eax
 225:	01 c8                	add    %ecx,%eax
 227:	83 e8 30             	sub    $0x30,%eax
 22a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22d:	8b 45 08             	mov    0x8(%ebp),%eax
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	3c 2f                	cmp    $0x2f,%al
 235:	7e 0a                	jle    241 <atoi+0x48>
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	0f b6 00             	movzbl (%eax),%eax
 23d:	3c 39                	cmp    $0x39,%al
 23f:	7e c7                	jle    208 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 241:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 244:	c9                   	leave  
 245:	c3                   	ret    

00000246 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 246:	55                   	push   %ebp
 247:	89 e5                	mov    %esp,%ebp
 249:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 252:	8b 45 0c             	mov    0xc(%ebp),%eax
 255:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 258:	eb 17                	jmp    271 <memmove+0x2b>
    *dst++ = *src++;
 25a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25d:	8d 50 01             	lea    0x1(%eax),%edx
 260:	89 55 fc             	mov    %edx,-0x4(%ebp)
 263:	8b 55 f8             	mov    -0x8(%ebp),%edx
 266:	8d 4a 01             	lea    0x1(%edx),%ecx
 269:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 26c:	0f b6 12             	movzbl (%edx),%edx
 26f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 271:	8b 45 10             	mov    0x10(%ebp),%eax
 274:	8d 50 ff             	lea    -0x1(%eax),%edx
 277:	89 55 10             	mov    %edx,0x10(%ebp)
 27a:	85 c0                	test   %eax,%eax
 27c:	7f dc                	jg     25a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 283:	b8 01 00 00 00       	mov    $0x1,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <exit>:
SYSCALL(exit)
 28b:	b8 02 00 00 00       	mov    $0x2,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <wait>:
SYSCALL(wait)
 293:	b8 03 00 00 00       	mov    $0x3,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <pipe>:
SYSCALL(pipe)
 29b:	b8 04 00 00 00       	mov    $0x4,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <read>:
SYSCALL(read)
 2a3:	b8 05 00 00 00       	mov    $0x5,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <write>:
SYSCALL(write)
 2ab:	b8 10 00 00 00       	mov    $0x10,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <close>:
SYSCALL(close)
 2b3:	b8 15 00 00 00       	mov    $0x15,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <kill>:
SYSCALL(kill)
 2bb:	b8 06 00 00 00       	mov    $0x6,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <exec>:
SYSCALL(exec)
 2c3:	b8 07 00 00 00       	mov    $0x7,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <open>:
SYSCALL(open)
 2cb:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <mknod>:
SYSCALL(mknod)
 2d3:	b8 11 00 00 00       	mov    $0x11,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <unlink>:
SYSCALL(unlink)
 2db:	b8 12 00 00 00       	mov    $0x12,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <fstat>:
SYSCALL(fstat)
 2e3:	b8 08 00 00 00       	mov    $0x8,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <link>:
SYSCALL(link)
 2eb:	b8 13 00 00 00       	mov    $0x13,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <mkdir>:
SYSCALL(mkdir)
 2f3:	b8 14 00 00 00       	mov    $0x14,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <chdir>:
SYSCALL(chdir)
 2fb:	b8 09 00 00 00       	mov    $0x9,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <dup>:
SYSCALL(dup)
 303:	b8 0a 00 00 00       	mov    $0xa,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <getpid>:
SYSCALL(getpid)
 30b:	b8 0b 00 00 00       	mov    $0xb,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <sbrk>:
SYSCALL(sbrk)
 313:	b8 0c 00 00 00       	mov    $0xc,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <sleep>:
SYSCALL(sleep)
 31b:	b8 0d 00 00 00       	mov    $0xd,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <uptime>:
SYSCALL(uptime)
 323:	b8 0e 00 00 00       	mov    $0xe,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <gettime>:
SYSCALL(gettime)
 32b:	b8 16 00 00 00       	mov    $0x16,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <settickets>:
SYSCALL(settickets)
 333:	b8 17 00 00 00       	mov    $0x17,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 33b:	55                   	push   %ebp
 33c:	89 e5                	mov    %esp,%ebp
 33e:	83 ec 18             	sub    $0x18,%esp
 341:	8b 45 0c             	mov    0xc(%ebp),%eax
 344:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 347:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 34e:	00 
 34f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 352:	89 44 24 04          	mov    %eax,0x4(%esp)
 356:	8b 45 08             	mov    0x8(%ebp),%eax
 359:	89 04 24             	mov    %eax,(%esp)
 35c:	e8 4a ff ff ff       	call   2ab <write>
}
 361:	c9                   	leave  
 362:	c3                   	ret    

00000363 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 363:	55                   	push   %ebp
 364:	89 e5                	mov    %esp,%ebp
 366:	56                   	push   %esi
 367:	53                   	push   %ebx
 368:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 36b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 372:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 376:	74 17                	je     38f <printint+0x2c>
 378:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 37c:	79 11                	jns    38f <printint+0x2c>
    neg = 1;
 37e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 385:	8b 45 0c             	mov    0xc(%ebp),%eax
 388:	f7 d8                	neg    %eax
 38a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 38d:	eb 06                	jmp    395 <printint+0x32>
  } else {
    x = xx;
 38f:	8b 45 0c             	mov    0xc(%ebp),%eax
 392:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 395:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 39c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 39f:	8d 41 01             	lea    0x1(%ecx),%eax
 3a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ab:	ba 00 00 00 00       	mov    $0x0,%edx
 3b0:	f7 f3                	div    %ebx
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	0f b6 80 04 0b 00 00 	movzbl 0xb04(%eax),%eax
 3bb:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3bf:	8b 75 10             	mov    0x10(%ebp),%esi
 3c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c5:	ba 00 00 00 00       	mov    $0x0,%edx
 3ca:	f7 f6                	div    %esi
 3cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3d3:	75 c7                	jne    39c <printint+0x39>
  if(neg)
 3d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3d9:	74 10                	je     3eb <printint+0x88>
    buf[i++] = '-';
 3db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3de:	8d 50 01             	lea    0x1(%eax),%edx
 3e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3e9:	eb 1f                	jmp    40a <printint+0xa7>
 3eb:	eb 1d                	jmp    40a <printint+0xa7>
    putc(fd, buf[i]);
 3ed:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f3:	01 d0                	add    %edx,%eax
 3f5:	0f b6 00             	movzbl (%eax),%eax
 3f8:	0f be c0             	movsbl %al,%eax
 3fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ff:	8b 45 08             	mov    0x8(%ebp),%eax
 402:	89 04 24             	mov    %eax,(%esp)
 405:	e8 31 ff ff ff       	call   33b <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 40a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 40e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 412:	79 d9                	jns    3ed <printint+0x8a>
    putc(fd, buf[i]);
}
 414:	83 c4 30             	add    $0x30,%esp
 417:	5b                   	pop    %ebx
 418:	5e                   	pop    %esi
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret    

0000041b <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 41b:	55                   	push   %ebp
 41c:	89 e5                	mov    %esp,%ebp
 41e:	83 ec 38             	sub    $0x38,%esp
 421:	8b 45 0c             	mov    0xc(%ebp),%eax
 424:	89 45 e0             	mov    %eax,-0x20(%ebp)
 427:	8b 45 10             	mov    0x10(%ebp),%eax
 42a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 42d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 430:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 433:	89 d0                	mov    %edx,%eax
 435:	31 d2                	xor    %edx,%edx
 437:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 43a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 43d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 440:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 444:	74 22                	je     468 <printlong+0x4d>
 446:	8b 45 f4             	mov    -0xc(%ebp),%eax
 449:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 450:	00 
 451:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 458:	00 
 459:	89 44 24 04          	mov    %eax,0x4(%esp)
 45d:	8b 45 08             	mov    0x8(%ebp),%eax
 460:	89 04 24             	mov    %eax,(%esp)
 463:	e8 fb fe ff ff       	call   363 <printint>
    printint(fd, lower, 16, 0);
 468:	8b 45 f0             	mov    -0x10(%ebp),%eax
 46b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 472:	00 
 473:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 47a:	00 
 47b:	89 44 24 04          	mov    %eax,0x4(%esp)
 47f:	8b 45 08             	mov    0x8(%ebp),%eax
 482:	89 04 24             	mov    %eax,(%esp)
 485:	e8 d9 fe ff ff       	call   363 <printint>
}
 48a:	c9                   	leave  
 48b:	c3                   	ret    

0000048c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 492:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 499:	8d 45 0c             	lea    0xc(%ebp),%eax
 49c:	83 c0 04             	add    $0x4,%eax
 49f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4a9:	e9 ba 01 00 00       	jmp    668 <printf+0x1dc>
    c = fmt[i] & 0xff;
 4ae:	8b 55 0c             	mov    0xc(%ebp),%edx
 4b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4b4:	01 d0                	add    %edx,%eax
 4b6:	0f b6 00             	movzbl (%eax),%eax
 4b9:	0f be c0             	movsbl %al,%eax
 4bc:	25 ff 00 00 00       	and    $0xff,%eax
 4c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4c8:	75 2c                	jne    4f6 <printf+0x6a>
      if(c == '%'){
 4ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ce:	75 0c                	jne    4dc <printf+0x50>
        state = '%';
 4d0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4d7:	e9 88 01 00 00       	jmp    664 <printf+0x1d8>
      } else {
        putc(fd, c);
 4dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4df:	0f be c0             	movsbl %al,%eax
 4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e6:	8b 45 08             	mov    0x8(%ebp),%eax
 4e9:	89 04 24             	mov    %eax,(%esp)
 4ec:	e8 4a fe ff ff       	call   33b <putc>
 4f1:	e9 6e 01 00 00       	jmp    664 <printf+0x1d8>
      }
    } else if(state == '%'){
 4f6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4fa:	0f 85 64 01 00 00    	jne    664 <printf+0x1d8>
      if(c == 'd'){
 500:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 504:	75 2d                	jne    533 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 506:	8b 45 e8             	mov    -0x18(%ebp),%eax
 509:	8b 00                	mov    (%eax),%eax
 50b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 512:	00 
 513:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 51a:	00 
 51b:	89 44 24 04          	mov    %eax,0x4(%esp)
 51f:	8b 45 08             	mov    0x8(%ebp),%eax
 522:	89 04 24             	mov    %eax,(%esp)
 525:	e8 39 fe ff ff       	call   363 <printint>
        ap++;
 52a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52e:	e9 2a 01 00 00       	jmp    65d <printf+0x1d1>
      } else if(c == 'l') {
 533:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 537:	75 38                	jne    571 <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 539:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53c:	8b 50 04             	mov    0x4(%eax),%edx
 53f:	8b 00                	mov    (%eax),%eax
 541:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 548:	00 
 549:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 550:	00 
 551:	89 44 24 04          	mov    %eax,0x4(%esp)
 555:	89 54 24 08          	mov    %edx,0x8(%esp)
 559:	8b 45 08             	mov    0x8(%ebp),%eax
 55c:	89 04 24             	mov    %eax,(%esp)
 55f:	e8 b7 fe ff ff       	call   41b <printlong>
        // long longs take up 2 argument slots
        ap++;
 564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 568:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56c:	e9 ec 00 00 00       	jmp    65d <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 571:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 575:	74 06                	je     57d <printf+0xf1>
 577:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 57b:	75 2d                	jne    5aa <printf+0x11e>
        printint(fd, *ap, 16, 0);
 57d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 580:	8b 00                	mov    (%eax),%eax
 582:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 589:	00 
 58a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 591:	00 
 592:	89 44 24 04          	mov    %eax,0x4(%esp)
 596:	8b 45 08             	mov    0x8(%ebp),%eax
 599:	89 04 24             	mov    %eax,(%esp)
 59c:	e8 c2 fd ff ff       	call   363 <printint>
        ap++;
 5a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a5:	e9 b3 00 00 00       	jmp    65d <printf+0x1d1>
      } else if(c == 's'){
 5aa:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5ae:	75 45                	jne    5f5 <printf+0x169>
        s = (char*)*ap;
 5b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b3:	8b 00                	mov    (%eax),%eax
 5b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c0:	75 09                	jne    5cb <printf+0x13f>
          s = "(null)";
 5c2:	c7 45 f4 96 08 00 00 	movl   $0x896,-0xc(%ebp)
        while(*s != 0){
 5c9:	eb 1e                	jmp    5e9 <printf+0x15d>
 5cb:	eb 1c                	jmp    5e9 <printf+0x15d>
          putc(fd, *s);
 5cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d0:	0f b6 00             	movzbl (%eax),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5da:	8b 45 08             	mov    0x8(%ebp),%eax
 5dd:	89 04 24             	mov    %eax,(%esp)
 5e0:	e8 56 fd ff ff       	call   33b <putc>
          s++;
 5e5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ec:	0f b6 00             	movzbl (%eax),%eax
 5ef:	84 c0                	test   %al,%al
 5f1:	75 da                	jne    5cd <printf+0x141>
 5f3:	eb 68                	jmp    65d <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5f9:	75 1d                	jne    618 <printf+0x18c>
        putc(fd, *ap);
 5fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5fe:	8b 00                	mov    (%eax),%eax
 600:	0f be c0             	movsbl %al,%eax
 603:	89 44 24 04          	mov    %eax,0x4(%esp)
 607:	8b 45 08             	mov    0x8(%ebp),%eax
 60a:	89 04 24             	mov    %eax,(%esp)
 60d:	e8 29 fd ff ff       	call   33b <putc>
        ap++;
 612:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 616:	eb 45                	jmp    65d <printf+0x1d1>
      } else if(c == '%'){
 618:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 61c:	75 17                	jne    635 <printf+0x1a9>
        putc(fd, c);
 61e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	89 44 24 04          	mov    %eax,0x4(%esp)
 628:	8b 45 08             	mov    0x8(%ebp),%eax
 62b:	89 04 24             	mov    %eax,(%esp)
 62e:	e8 08 fd ff ff       	call   33b <putc>
 633:	eb 28                	jmp    65d <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 635:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 63c:	00 
 63d:	8b 45 08             	mov    0x8(%ebp),%eax
 640:	89 04 24             	mov    %eax,(%esp)
 643:	e8 f3 fc ff ff       	call   33b <putc>
        putc(fd, c);
 648:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64b:	0f be c0             	movsbl %al,%eax
 64e:	89 44 24 04          	mov    %eax,0x4(%esp)
 652:	8b 45 08             	mov    0x8(%ebp),%eax
 655:	89 04 24             	mov    %eax,(%esp)
 658:	e8 de fc ff ff       	call   33b <putc>
      }
      state = 0;
 65d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 664:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 668:	8b 55 0c             	mov    0xc(%ebp),%edx
 66b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 66e:	01 d0                	add    %edx,%eax
 670:	0f b6 00             	movzbl (%eax),%eax
 673:	84 c0                	test   %al,%al
 675:	0f 85 33 fe ff ff    	jne    4ae <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 67b:	c9                   	leave  
 67c:	c3                   	ret    

0000067d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 67d:	55                   	push   %ebp
 67e:	89 e5                	mov    %esp,%ebp
 680:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 683:	8b 45 08             	mov    0x8(%ebp),%eax
 686:	83 e8 08             	sub    $0x8,%eax
 689:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68c:	a1 20 0b 00 00       	mov    0xb20,%eax
 691:	89 45 fc             	mov    %eax,-0x4(%ebp)
 694:	eb 24                	jmp    6ba <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69e:	77 12                	ja     6b2 <free+0x35>
 6a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a6:	77 24                	ja     6cc <free+0x4f>
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	8b 00                	mov    (%eax),%eax
 6ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b0:	77 1a                	ja     6cc <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b5:	8b 00                	mov    (%eax),%eax
 6b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c0:	76 d4                	jbe    696 <free+0x19>
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	8b 00                	mov    (%eax),%eax
 6c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ca:	76 ca                	jbe    696 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cf:	8b 40 04             	mov    0x4(%eax),%eax
 6d2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dc:	01 c2                	add    %eax,%edx
 6de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e1:	8b 00                	mov    (%eax),%eax
 6e3:	39 c2                	cmp    %eax,%edx
 6e5:	75 24                	jne    70b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	8b 50 04             	mov    0x4(%eax),%edx
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	8b 00                	mov    (%eax),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	01 c2                	add    %eax,%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 00                	mov    (%eax),%eax
 702:	8b 10                	mov    (%eax),%edx
 704:	8b 45 f8             	mov    -0x8(%ebp),%eax
 707:	89 10                	mov    %edx,(%eax)
 709:	eb 0a                	jmp    715 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	8b 10                	mov    (%eax),%edx
 710:	8b 45 f8             	mov    -0x8(%ebp),%eax
 713:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	8b 40 04             	mov    0x4(%eax),%eax
 71b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 722:	8b 45 fc             	mov    -0x4(%ebp),%eax
 725:	01 d0                	add    %edx,%eax
 727:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72a:	75 20                	jne    74c <free+0xcf>
    p->s.size += bp->s.size;
 72c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72f:	8b 50 04             	mov    0x4(%eax),%edx
 732:	8b 45 f8             	mov    -0x8(%ebp),%eax
 735:	8b 40 04             	mov    0x4(%eax),%eax
 738:	01 c2                	add    %eax,%edx
 73a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 740:	8b 45 f8             	mov    -0x8(%ebp),%eax
 743:	8b 10                	mov    (%eax),%edx
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	89 10                	mov    %edx,(%eax)
 74a:	eb 08                	jmp    754 <free+0xd7>
  } else
    p->s.ptr = bp;
 74c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 752:	89 10                	mov    %edx,(%eax)
  freep = p;
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	a3 20 0b 00 00       	mov    %eax,0xb20
}
 75c:	c9                   	leave  
 75d:	c3                   	ret    

0000075e <morecore>:

static Header*
morecore(uint nu)
{
 75e:	55                   	push   %ebp
 75f:	89 e5                	mov    %esp,%ebp
 761:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 764:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 76b:	77 07                	ja     774 <morecore+0x16>
    nu = 4096;
 76d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 774:	8b 45 08             	mov    0x8(%ebp),%eax
 777:	c1 e0 03             	shl    $0x3,%eax
 77a:	89 04 24             	mov    %eax,(%esp)
 77d:	e8 91 fb ff ff       	call   313 <sbrk>
 782:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 785:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 789:	75 07                	jne    792 <morecore+0x34>
    return 0;
 78b:	b8 00 00 00 00       	mov    $0x0,%eax
 790:	eb 22                	jmp    7b4 <morecore+0x56>
  hp = (Header*)p;
 792:	8b 45 f4             	mov    -0xc(%ebp),%eax
 795:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 798:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79b:	8b 55 08             	mov    0x8(%ebp),%edx
 79e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a4:	83 c0 08             	add    $0x8,%eax
 7a7:	89 04 24             	mov    %eax,(%esp)
 7aa:	e8 ce fe ff ff       	call   67d <free>
  return freep;
 7af:	a1 20 0b 00 00       	mov    0xb20,%eax
}
 7b4:	c9                   	leave  
 7b5:	c3                   	ret    

000007b6 <malloc>:

void*
malloc(uint nbytes)
{
 7b6:	55                   	push   %ebp
 7b7:	89 e5                	mov    %esp,%ebp
 7b9:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7bc:	8b 45 08             	mov    0x8(%ebp),%eax
 7bf:	83 c0 07             	add    $0x7,%eax
 7c2:	c1 e8 03             	shr    $0x3,%eax
 7c5:	83 c0 01             	add    $0x1,%eax
 7c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7cb:	a1 20 0b 00 00       	mov    0xb20,%eax
 7d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7d7:	75 23                	jne    7fc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7d9:	c7 45 f0 18 0b 00 00 	movl   $0xb18,-0x10(%ebp)
 7e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e3:	a3 20 0b 00 00       	mov    %eax,0xb20
 7e8:	a1 20 0b 00 00       	mov    0xb20,%eax
 7ed:	a3 18 0b 00 00       	mov    %eax,0xb18
    base.s.size = 0;
 7f2:	c7 05 1c 0b 00 00 00 	movl   $0x0,0xb1c
 7f9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ff:	8b 00                	mov    (%eax),%eax
 801:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	8b 40 04             	mov    0x4(%eax),%eax
 80a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 80d:	72 4d                	jb     85c <malloc+0xa6>
      if(p->s.size == nunits)
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 40 04             	mov    0x4(%eax),%eax
 815:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 818:	75 0c                	jne    826 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	8b 10                	mov    (%eax),%edx
 81f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 822:	89 10                	mov    %edx,(%eax)
 824:	eb 26                	jmp    84c <malloc+0x96>
      else {
        p->s.size -= nunits;
 826:	8b 45 f4             	mov    -0xc(%ebp),%eax
 829:	8b 40 04             	mov    0x4(%eax),%eax
 82c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 82f:	89 c2                	mov    %eax,%edx
 831:	8b 45 f4             	mov    -0xc(%ebp),%eax
 834:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 837:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83a:	8b 40 04             	mov    0x4(%eax),%eax
 83d:	c1 e0 03             	shl    $0x3,%eax
 840:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 843:	8b 45 f4             	mov    -0xc(%ebp),%eax
 846:	8b 55 ec             	mov    -0x14(%ebp),%edx
 849:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 84c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84f:	a3 20 0b 00 00       	mov    %eax,0xb20
      return (void*)(p + 1);
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	83 c0 08             	add    $0x8,%eax
 85a:	eb 38                	jmp    894 <malloc+0xde>
    }
    if(p == freep)
 85c:	a1 20 0b 00 00       	mov    0xb20,%eax
 861:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 864:	75 1b                	jne    881 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 866:	8b 45 ec             	mov    -0x14(%ebp),%eax
 869:	89 04 24             	mov    %eax,(%esp)
 86c:	e8 ed fe ff ff       	call   75e <morecore>
 871:	89 45 f4             	mov    %eax,-0xc(%ebp)
 874:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 878:	75 07                	jne    881 <malloc+0xcb>
        return 0;
 87a:	b8 00 00 00 00       	mov    $0x0,%eax
 87f:	eb 13                	jmp    894 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 881:	8b 45 f4             	mov    -0xc(%ebp),%eax
 884:	89 45 f0             	mov    %eax,-0x10(%ebp)
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	8b 00                	mov    (%eax),%eax
 88c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 88f:	e9 70 ff ff ff       	jmp    804 <malloc+0x4e>
}
 894:	c9                   	leave  
 895:	c3                   	ret    
