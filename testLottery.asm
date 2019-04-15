
_testLottery:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp

  if (fork() == 0){
   9:	e8 8e 02 00 00       	call   29c <fork>
   e:	85 c0                	test   %eax,%eax
  10:	75 19                	jne    2b <main+0x2b>
    printf(1,"hello, i am the child.\n");
  12:	c7 44 24 04 af 08 00 	movl   $0x8af,0x4(%esp)
  19:	00 
  1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  21:	e8 7f 04 00 00       	call   4a5 <printf>
    exit();
  26:	e8 79 02 00 00       	call   2a4 <exit>
  }
  else{
    sleep(5);
  2b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  32:	e8 fd 02 00 00       	call   334 <sleep>
  }

  exit();
  37:	e8 68 02 00 00       	call   2a4 <exit>

0000003c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  3c:	55                   	push   %ebp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	57                   	push   %edi
  40:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  41:	8b 4d 08             	mov    0x8(%ebp),%ecx
  44:	8b 55 10             	mov    0x10(%ebp),%edx
  47:	8b 45 0c             	mov    0xc(%ebp),%eax
  4a:	89 cb                	mov    %ecx,%ebx
  4c:	89 df                	mov    %ebx,%edi
  4e:	89 d1                	mov    %edx,%ecx
  50:	fc                   	cld    
  51:	f3 aa                	rep stos %al,%es:(%edi)
  53:	89 ca                	mov    %ecx,%edx
  55:	89 fb                	mov    %edi,%ebx
  57:	89 5d 08             	mov    %ebx,0x8(%ebp)
  5a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  5d:	5b                   	pop    %ebx
  5e:	5f                   	pop    %edi
  5f:	5d                   	pop    %ebp
  60:	c3                   	ret    

00000061 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  61:	55                   	push   %ebp
  62:	89 e5                	mov    %esp,%ebp
  64:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  67:	8b 45 08             	mov    0x8(%ebp),%eax
  6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  6d:	90                   	nop
  6e:	8b 45 08             	mov    0x8(%ebp),%eax
  71:	8d 50 01             	lea    0x1(%eax),%edx
  74:	89 55 08             	mov    %edx,0x8(%ebp)
  77:	8b 55 0c             	mov    0xc(%ebp),%edx
  7a:	8d 4a 01             	lea    0x1(%edx),%ecx
  7d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80:	0f b6 12             	movzbl (%edx),%edx
  83:	88 10                	mov    %dl,(%eax)
  85:	0f b6 00             	movzbl (%eax),%eax
  88:	84 c0                	test   %al,%al
  8a:	75 e2                	jne    6e <strcpy+0xd>
    ;
  return os;
  8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8f:	c9                   	leave  
  90:	c3                   	ret    

00000091 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  91:	55                   	push   %ebp
  92:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  94:	eb 08                	jmp    9e <strcmp+0xd>
    p++, q++;
  96:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  9a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	0f b6 00             	movzbl (%eax),%eax
  a4:	84 c0                	test   %al,%al
  a6:	74 10                	je     b8 <strcmp+0x27>
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	0f b6 10             	movzbl (%eax),%edx
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	0f b6 00             	movzbl (%eax),%eax
  b4:	38 c2                	cmp    %al,%dl
  b6:	74 de                	je     96 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b8:	8b 45 08             	mov    0x8(%ebp),%eax
  bb:	0f b6 00             	movzbl (%eax),%eax
  be:	0f b6 d0             	movzbl %al,%edx
  c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	0f b6 c0             	movzbl %al,%eax
  ca:	29 c2                	sub    %eax,%edx
  cc:	89 d0                	mov    %edx,%eax
}
  ce:	5d                   	pop    %ebp
  cf:	c3                   	ret    

000000d0 <strlen>:

uint
strlen(char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  dd:	eb 04                	jmp    e3 <strlen+0x13>
  df:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	01 d0                	add    %edx,%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	84 c0                	test   %al,%al
  f0:	75 ed                	jne    df <strlen+0xf>
    ;
  return n;
  f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f5:	c9                   	leave  
  f6:	c3                   	ret    

000000f7 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f7:	55                   	push   %ebp
  f8:	89 e5                	mov    %esp,%ebp
  fa:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  fd:	8b 45 10             	mov    0x10(%ebp),%eax
 100:	89 44 24 08          	mov    %eax,0x8(%esp)
 104:	8b 45 0c             	mov    0xc(%ebp),%eax
 107:	89 44 24 04          	mov    %eax,0x4(%esp)
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	89 04 24             	mov    %eax,(%esp)
 111:	e8 26 ff ff ff       	call   3c <stosb>
  return dst;
 116:	8b 45 08             	mov    0x8(%ebp),%eax
}
 119:	c9                   	leave  
 11a:	c3                   	ret    

0000011b <strchr>:

char*
strchr(const char *s, char c)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	83 ec 04             	sub    $0x4,%esp
 121:	8b 45 0c             	mov    0xc(%ebp),%eax
 124:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 127:	eb 14                	jmp    13d <strchr+0x22>
    if(*s == c)
 129:	8b 45 08             	mov    0x8(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 132:	75 05                	jne    139 <strchr+0x1e>
      return (char*)s;
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	eb 13                	jmp    14c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 139:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	75 e2                	jne    129 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 147:	b8 00 00 00 00       	mov    $0x0,%eax
}
 14c:	c9                   	leave  
 14d:	c3                   	ret    

0000014e <gets>:

char*
gets(char *buf, int max)
{
 14e:	55                   	push   %ebp
 14f:	89 e5                	mov    %esp,%ebp
 151:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 154:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 15b:	eb 4c                	jmp    1a9 <gets+0x5b>
    cc = read(0, &c, 1);
 15d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 164:	00 
 165:	8d 45 ef             	lea    -0x11(%ebp),%eax
 168:	89 44 24 04          	mov    %eax,0x4(%esp)
 16c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 173:	e8 44 01 00 00       	call   2bc <read>
 178:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 17b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 17f:	7f 02                	jg     183 <gets+0x35>
      break;
 181:	eb 31                	jmp    1b4 <gets+0x66>
    buf[i++] = c;
 183:	8b 45 f4             	mov    -0xc(%ebp),%eax
 186:	8d 50 01             	lea    0x1(%eax),%edx
 189:	89 55 f4             	mov    %edx,-0xc(%ebp)
 18c:	89 c2                	mov    %eax,%edx
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	01 c2                	add    %eax,%edx
 193:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 197:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 199:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 19d:	3c 0a                	cmp    $0xa,%al
 19f:	74 13                	je     1b4 <gets+0x66>
 1a1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a5:	3c 0d                	cmp    $0xd,%al
 1a7:	74 0b                	je     1b4 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ac:	83 c0 01             	add    $0x1,%eax
 1af:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1b2:	7c a9                	jl     15d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	01 d0                	add    %edx,%eax
 1bc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1c2:	c9                   	leave  
 1c3:	c3                   	ret    

000001c4 <stat>:

int
stat(char *n, struct stat *st)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1d1:	00 
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 07 01 00 00       	call   2e4 <open>
 1dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1e4:	79 07                	jns    1ed <stat+0x29>
    return -1;
 1e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1eb:	eb 23                	jmp    210 <stat+0x4c>
  r = fstat(fd, st);
 1ed:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f7:	89 04 24             	mov    %eax,(%esp)
 1fa:	e8 fd 00 00 00       	call   2fc <fstat>
 1ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 202:	8b 45 f4             	mov    -0xc(%ebp),%eax
 205:	89 04 24             	mov    %eax,(%esp)
 208:	e8 bf 00 00 00       	call   2cc <close>
  return r;
 20d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 210:	c9                   	leave  
 211:	c3                   	ret    

00000212 <atoi>:

int
atoi(const char *s)
{
 212:	55                   	push   %ebp
 213:	89 e5                	mov    %esp,%ebp
 215:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 21f:	eb 25                	jmp    246 <atoi+0x34>
    n = n*10 + *s++ - '0';
 221:	8b 55 fc             	mov    -0x4(%ebp),%edx
 224:	89 d0                	mov    %edx,%eax
 226:	c1 e0 02             	shl    $0x2,%eax
 229:	01 d0                	add    %edx,%eax
 22b:	01 c0                	add    %eax,%eax
 22d:	89 c1                	mov    %eax,%ecx
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	8d 50 01             	lea    0x1(%eax),%edx
 235:	89 55 08             	mov    %edx,0x8(%ebp)
 238:	0f b6 00             	movzbl (%eax),%eax
 23b:	0f be c0             	movsbl %al,%eax
 23e:	01 c8                	add    %ecx,%eax
 240:	83 e8 30             	sub    $0x30,%eax
 243:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 246:	8b 45 08             	mov    0x8(%ebp),%eax
 249:	0f b6 00             	movzbl (%eax),%eax
 24c:	3c 2f                	cmp    $0x2f,%al
 24e:	7e 0a                	jle    25a <atoi+0x48>
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	0f b6 00             	movzbl (%eax),%eax
 256:	3c 39                	cmp    $0x39,%al
 258:	7e c7                	jle    221 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 25a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 25d:	c9                   	leave  
 25e:	c3                   	ret    

0000025f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 25f:	55                   	push   %ebp
 260:	89 e5                	mov    %esp,%ebp
 262:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 265:	8b 45 08             	mov    0x8(%ebp),%eax
 268:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 26b:	8b 45 0c             	mov    0xc(%ebp),%eax
 26e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 271:	eb 17                	jmp    28a <memmove+0x2b>
    *dst++ = *src++;
 273:	8b 45 fc             	mov    -0x4(%ebp),%eax
 276:	8d 50 01             	lea    0x1(%eax),%edx
 279:	89 55 fc             	mov    %edx,-0x4(%ebp)
 27c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 27f:	8d 4a 01             	lea    0x1(%edx),%ecx
 282:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 285:	0f b6 12             	movzbl (%edx),%edx
 288:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28a:	8b 45 10             	mov    0x10(%ebp),%eax
 28d:	8d 50 ff             	lea    -0x1(%eax),%edx
 290:	89 55 10             	mov    %edx,0x10(%ebp)
 293:	85 c0                	test   %eax,%eax
 295:	7f dc                	jg     273 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 297:	8b 45 08             	mov    0x8(%ebp),%eax
}
 29a:	c9                   	leave  
 29b:	c3                   	ret    

0000029c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29c:	b8 01 00 00 00       	mov    $0x1,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <exit>:
SYSCALL(exit)
 2a4:	b8 02 00 00 00       	mov    $0x2,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <wait>:
SYSCALL(wait)
 2ac:	b8 03 00 00 00       	mov    $0x3,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <pipe>:
SYSCALL(pipe)
 2b4:	b8 04 00 00 00       	mov    $0x4,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <read>:
SYSCALL(read)
 2bc:	b8 05 00 00 00       	mov    $0x5,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <write>:
SYSCALL(write)
 2c4:	b8 10 00 00 00       	mov    $0x10,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <close>:
SYSCALL(close)
 2cc:	b8 15 00 00 00       	mov    $0x15,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <kill>:
SYSCALL(kill)
 2d4:	b8 06 00 00 00       	mov    $0x6,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <exec>:
SYSCALL(exec)
 2dc:	b8 07 00 00 00       	mov    $0x7,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <open>:
SYSCALL(open)
 2e4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <mknod>:
SYSCALL(mknod)
 2ec:	b8 11 00 00 00       	mov    $0x11,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <unlink>:
SYSCALL(unlink)
 2f4:	b8 12 00 00 00       	mov    $0x12,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <fstat>:
SYSCALL(fstat)
 2fc:	b8 08 00 00 00       	mov    $0x8,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <link>:
SYSCALL(link)
 304:	b8 13 00 00 00       	mov    $0x13,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <mkdir>:
SYSCALL(mkdir)
 30c:	b8 14 00 00 00       	mov    $0x14,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <chdir>:
SYSCALL(chdir)
 314:	b8 09 00 00 00       	mov    $0x9,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <dup>:
SYSCALL(dup)
 31c:	b8 0a 00 00 00       	mov    $0xa,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <getpid>:
SYSCALL(getpid)
 324:	b8 0b 00 00 00       	mov    $0xb,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <sbrk>:
SYSCALL(sbrk)
 32c:	b8 0c 00 00 00       	mov    $0xc,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <sleep>:
SYSCALL(sleep)
 334:	b8 0d 00 00 00       	mov    $0xd,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <uptime>:
SYSCALL(uptime)
 33c:	b8 0e 00 00 00       	mov    $0xe,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <gettime>:
SYSCALL(gettime)
 344:	b8 16 00 00 00       	mov    $0x16,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <settickets>:
SYSCALL(settickets)
 34c:	b8 17 00 00 00       	mov    $0x17,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	83 ec 18             	sub    $0x18,%esp
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 360:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 367:	00 
 368:	8d 45 f4             	lea    -0xc(%ebp),%eax
 36b:	89 44 24 04          	mov    %eax,0x4(%esp)
 36f:	8b 45 08             	mov    0x8(%ebp),%eax
 372:	89 04 24             	mov    %eax,(%esp)
 375:	e8 4a ff ff ff       	call   2c4 <write>
}
 37a:	c9                   	leave  
 37b:	c3                   	ret    

0000037c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 37c:	55                   	push   %ebp
 37d:	89 e5                	mov    %esp,%ebp
 37f:	56                   	push   %esi
 380:	53                   	push   %ebx
 381:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 384:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 38b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 38f:	74 17                	je     3a8 <printint+0x2c>
 391:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 395:	79 11                	jns    3a8 <printint+0x2c>
    neg = 1;
 397:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	f7 d8                	neg    %eax
 3a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3a6:	eb 06                	jmp    3ae <printint+0x32>
  } else {
    x = xx;
 3a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3b8:	8d 41 01             	lea    0x1(%ecx),%eax
 3bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3be:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c4:	ba 00 00 00 00       	mov    $0x0,%edx
 3c9:	f7 f3                	div    %ebx
 3cb:	89 d0                	mov    %edx,%eax
 3cd:	0f b6 80 34 0b 00 00 	movzbl 0xb34(%eax),%eax
 3d4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3d8:	8b 75 10             	mov    0x10(%ebp),%esi
 3db:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3de:	ba 00 00 00 00       	mov    $0x0,%edx
 3e3:	f7 f6                	div    %esi
 3e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ec:	75 c7                	jne    3b5 <printint+0x39>
  if(neg)
 3ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f2:	74 10                	je     404 <printint+0x88>
    buf[i++] = '-';
 3f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f7:	8d 50 01             	lea    0x1(%eax),%edx
 3fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 402:	eb 1f                	jmp    423 <printint+0xa7>
 404:	eb 1d                	jmp    423 <printint+0xa7>
    putc(fd, buf[i]);
 406:	8d 55 dc             	lea    -0x24(%ebp),%edx
 409:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40c:	01 d0                	add    %edx,%eax
 40e:	0f b6 00             	movzbl (%eax),%eax
 411:	0f be c0             	movsbl %al,%eax
 414:	89 44 24 04          	mov    %eax,0x4(%esp)
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	89 04 24             	mov    %eax,(%esp)
 41e:	e8 31 ff ff ff       	call   354 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 423:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 427:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 42b:	79 d9                	jns    406 <printint+0x8a>
    putc(fd, buf[i]);
}
 42d:	83 c4 30             	add    $0x30,%esp
 430:	5b                   	pop    %ebx
 431:	5e                   	pop    %esi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    

00000434 <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 38             	sub    $0x38,%esp
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	89 45 e0             	mov    %eax,-0x20(%ebp)
 440:	8b 45 10             	mov    0x10(%ebp),%eax
 443:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 446:	8b 45 e0             	mov    -0x20(%ebp),%eax
 449:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 44c:	89 d0                	mov    %edx,%eax
 44e:	31 d2                	xor    %edx,%edx
 450:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 453:	8b 45 e0             	mov    -0x20(%ebp),%eax
 456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 459:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 45d:	74 22                	je     481 <printlong+0x4d>
 45f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 462:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 469:	00 
 46a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 471:	00 
 472:	89 44 24 04          	mov    %eax,0x4(%esp)
 476:	8b 45 08             	mov    0x8(%ebp),%eax
 479:	89 04 24             	mov    %eax,(%esp)
 47c:	e8 fb fe ff ff       	call   37c <printint>
    printint(fd, lower, 16, 0);
 481:	8b 45 f0             	mov    -0x10(%ebp),%eax
 484:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 48b:	00 
 48c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 493:	00 
 494:	89 44 24 04          	mov    %eax,0x4(%esp)
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	89 04 24             	mov    %eax,(%esp)
 49e:	e8 d9 fe ff ff       	call   37c <printint>
}
 4a3:	c9                   	leave  
 4a4:	c3                   	ret    

000004a5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 4a5:	55                   	push   %ebp
 4a6:	89 e5                	mov    %esp,%ebp
 4a8:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b2:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b5:	83 c0 04             	add    $0x4,%eax
 4b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c2:	e9 ba 01 00 00       	jmp    681 <printf+0x1dc>
    c = fmt[i] & 0xff;
 4c7:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4cd:	01 d0                	add    %edx,%eax
 4cf:	0f b6 00             	movzbl (%eax),%eax
 4d2:	0f be c0             	movsbl %al,%eax
 4d5:	25 ff 00 00 00       	and    $0xff,%eax
 4da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e1:	75 2c                	jne    50f <printf+0x6a>
      if(c == '%'){
 4e3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e7:	75 0c                	jne    4f5 <printf+0x50>
        state = '%';
 4e9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f0:	e9 88 01 00 00       	jmp    67d <printf+0x1d8>
      } else {
        putc(fd, c);
 4f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f8:	0f be c0             	movsbl %al,%eax
 4fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ff:	8b 45 08             	mov    0x8(%ebp),%eax
 502:	89 04 24             	mov    %eax,(%esp)
 505:	e8 4a fe ff ff       	call   354 <putc>
 50a:	e9 6e 01 00 00       	jmp    67d <printf+0x1d8>
      }
    } else if(state == '%'){
 50f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 513:	0f 85 64 01 00 00    	jne    67d <printf+0x1d8>
      if(c == 'd'){
 519:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 51d:	75 2d                	jne    54c <printf+0xa7>
        printint(fd, *ap, 10, 1);
 51f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 522:	8b 00                	mov    (%eax),%eax
 524:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 52b:	00 
 52c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 533:	00 
 534:	89 44 24 04          	mov    %eax,0x4(%esp)
 538:	8b 45 08             	mov    0x8(%ebp),%eax
 53b:	89 04 24             	mov    %eax,(%esp)
 53e:	e8 39 fe ff ff       	call   37c <printint>
        ap++;
 543:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 547:	e9 2a 01 00 00       	jmp    676 <printf+0x1d1>
      } else if(c == 'l') {
 54c:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 550:	75 38                	jne    58a <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 552:	8b 45 e8             	mov    -0x18(%ebp),%eax
 555:	8b 50 04             	mov    0x4(%eax),%edx
 558:	8b 00                	mov    (%eax),%eax
 55a:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 561:	00 
 562:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 569:	00 
 56a:	89 44 24 04          	mov    %eax,0x4(%esp)
 56e:	89 54 24 08          	mov    %edx,0x8(%esp)
 572:	8b 45 08             	mov    0x8(%ebp),%eax
 575:	89 04 24             	mov    %eax,(%esp)
 578:	e8 b7 fe ff ff       	call   434 <printlong>
        // long longs take up 2 argument slots
        ap++;
 57d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 581:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 585:	e9 ec 00 00 00       	jmp    676 <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 58a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 58e:	74 06                	je     596 <printf+0xf1>
 590:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 594:	75 2d                	jne    5c3 <printf+0x11e>
        printint(fd, *ap, 16, 0);
 596:	8b 45 e8             	mov    -0x18(%ebp),%eax
 599:	8b 00                	mov    (%eax),%eax
 59b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5a2:	00 
 5a3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5aa:	00 
 5ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 5af:	8b 45 08             	mov    0x8(%ebp),%eax
 5b2:	89 04 24             	mov    %eax,(%esp)
 5b5:	e8 c2 fd ff ff       	call   37c <printint>
        ap++;
 5ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5be:	e9 b3 00 00 00       	jmp    676 <printf+0x1d1>
      } else if(c == 's'){
 5c3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5c7:	75 45                	jne    60e <printf+0x169>
        s = (char*)*ap;
 5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d9:	75 09                	jne    5e4 <printf+0x13f>
          s = "(null)";
 5db:	c7 45 f4 c7 08 00 00 	movl   $0x8c7,-0xc(%ebp)
        while(*s != 0){
 5e2:	eb 1e                	jmp    602 <printf+0x15d>
 5e4:	eb 1c                	jmp    602 <printf+0x15d>
          putc(fd, *s);
 5e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e9:	0f b6 00             	movzbl (%eax),%eax
 5ec:	0f be c0             	movsbl %al,%eax
 5ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	89 04 24             	mov    %eax,(%esp)
 5f9:	e8 56 fd ff ff       	call   354 <putc>
          s++;
 5fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 602:	8b 45 f4             	mov    -0xc(%ebp),%eax
 605:	0f b6 00             	movzbl (%eax),%eax
 608:	84 c0                	test   %al,%al
 60a:	75 da                	jne    5e6 <printf+0x141>
 60c:	eb 68                	jmp    676 <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 612:	75 1d                	jne    631 <printf+0x18c>
        putc(fd, *ap);
 614:	8b 45 e8             	mov    -0x18(%ebp),%eax
 617:	8b 00                	mov    (%eax),%eax
 619:	0f be c0             	movsbl %al,%eax
 61c:	89 44 24 04          	mov    %eax,0x4(%esp)
 620:	8b 45 08             	mov    0x8(%ebp),%eax
 623:	89 04 24             	mov    %eax,(%esp)
 626:	e8 29 fd ff ff       	call   354 <putc>
        ap++;
 62b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62f:	eb 45                	jmp    676 <printf+0x1d1>
      } else if(c == '%'){
 631:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 635:	75 17                	jne    64e <printf+0x1a9>
        putc(fd, c);
 637:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 63a:	0f be c0             	movsbl %al,%eax
 63d:	89 44 24 04          	mov    %eax,0x4(%esp)
 641:	8b 45 08             	mov    0x8(%ebp),%eax
 644:	89 04 24             	mov    %eax,(%esp)
 647:	e8 08 fd ff ff       	call   354 <putc>
 64c:	eb 28                	jmp    676 <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 64e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 655:	00 
 656:	8b 45 08             	mov    0x8(%ebp),%eax
 659:	89 04 24             	mov    %eax,(%esp)
 65c:	e8 f3 fc ff ff       	call   354 <putc>
        putc(fd, c);
 661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 664:	0f be c0             	movsbl %al,%eax
 667:	89 44 24 04          	mov    %eax,0x4(%esp)
 66b:	8b 45 08             	mov    0x8(%ebp),%eax
 66e:	89 04 24             	mov    %eax,(%esp)
 671:	e8 de fc ff ff       	call   354 <putc>
      }
      state = 0;
 676:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 67d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 681:	8b 55 0c             	mov    0xc(%ebp),%edx
 684:	8b 45 f0             	mov    -0x10(%ebp),%eax
 687:	01 d0                	add    %edx,%eax
 689:	0f b6 00             	movzbl (%eax),%eax
 68c:	84 c0                	test   %al,%al
 68e:	0f 85 33 fe ff ff    	jne    4c7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 694:	c9                   	leave  
 695:	c3                   	ret    

00000696 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 696:	55                   	push   %ebp
 697:	89 e5                	mov    %esp,%ebp
 699:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 69c:	8b 45 08             	mov    0x8(%ebp),%eax
 69f:	83 e8 08             	sub    $0x8,%eax
 6a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a5:	a1 50 0b 00 00       	mov    0xb50,%eax
 6aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6ad:	eb 24                	jmp    6d3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	8b 00                	mov    (%eax),%eax
 6b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b7:	77 12                	ja     6cb <free+0x35>
 6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6bf:	77 24                	ja     6e5 <free+0x4f>
 6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c4:	8b 00                	mov    (%eax),%eax
 6c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6c9:	77 1a                	ja     6e5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	8b 00                	mov    (%eax),%eax
 6d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6d9:	76 d4                	jbe    6af <free+0x19>
 6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6de:	8b 00                	mov    (%eax),%eax
 6e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e3:	76 ca                	jbe    6af <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e8:	8b 40 04             	mov    0x4(%eax),%eax
 6eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f5:	01 c2                	add    %eax,%edx
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	8b 00                	mov    (%eax),%eax
 6fc:	39 c2                	cmp    %eax,%edx
 6fe:	75 24                	jne    724 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 700:	8b 45 f8             	mov    -0x8(%ebp),%eax
 703:	8b 50 04             	mov    0x4(%eax),%edx
 706:	8b 45 fc             	mov    -0x4(%ebp),%eax
 709:	8b 00                	mov    (%eax),%eax
 70b:	8b 40 04             	mov    0x4(%eax),%eax
 70e:	01 c2                	add    %eax,%edx
 710:	8b 45 f8             	mov    -0x8(%ebp),%eax
 713:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 00                	mov    (%eax),%eax
 71b:	8b 10                	mov    (%eax),%edx
 71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 720:	89 10                	mov    %edx,(%eax)
 722:	eb 0a                	jmp    72e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 724:	8b 45 fc             	mov    -0x4(%ebp),%eax
 727:	8b 10                	mov    (%eax),%edx
 729:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 40 04             	mov    0x4(%eax),%eax
 734:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73e:	01 d0                	add    %edx,%eax
 740:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 743:	75 20                	jne    765 <free+0xcf>
    p->s.size += bp->s.size;
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	8b 50 04             	mov    0x4(%eax),%edx
 74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74e:	8b 40 04             	mov    0x4(%eax),%eax
 751:	01 c2                	add    %eax,%edx
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 759:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75c:	8b 10                	mov    (%eax),%edx
 75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 761:	89 10                	mov    %edx,(%eax)
 763:	eb 08                	jmp    76d <free+0xd7>
  } else
    p->s.ptr = bp;
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	8b 55 f8             	mov    -0x8(%ebp),%edx
 76b:	89 10                	mov    %edx,(%eax)
  freep = p;
 76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 770:	a3 50 0b 00 00       	mov    %eax,0xb50
}
 775:	c9                   	leave  
 776:	c3                   	ret    

00000777 <morecore>:

static Header*
morecore(uint nu)
{
 777:	55                   	push   %ebp
 778:	89 e5                	mov    %esp,%ebp
 77a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 77d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 784:	77 07                	ja     78d <morecore+0x16>
    nu = 4096;
 786:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 78d:	8b 45 08             	mov    0x8(%ebp),%eax
 790:	c1 e0 03             	shl    $0x3,%eax
 793:	89 04 24             	mov    %eax,(%esp)
 796:	e8 91 fb ff ff       	call   32c <sbrk>
 79b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 79e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7a2:	75 07                	jne    7ab <morecore+0x34>
    return 0;
 7a4:	b8 00 00 00 00       	mov    $0x0,%eax
 7a9:	eb 22                	jmp    7cd <morecore+0x56>
  hp = (Header*)p;
 7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	8b 55 08             	mov    0x8(%ebp),%edx
 7b7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bd:	83 c0 08             	add    $0x8,%eax
 7c0:	89 04 24             	mov    %eax,(%esp)
 7c3:	e8 ce fe ff ff       	call   696 <free>
  return freep;
 7c8:	a1 50 0b 00 00       	mov    0xb50,%eax
}
 7cd:	c9                   	leave  
 7ce:	c3                   	ret    

000007cf <malloc>:

void*
malloc(uint nbytes)
{
 7cf:	55                   	push   %ebp
 7d0:	89 e5                	mov    %esp,%ebp
 7d2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d5:	8b 45 08             	mov    0x8(%ebp),%eax
 7d8:	83 c0 07             	add    $0x7,%eax
 7db:	c1 e8 03             	shr    $0x3,%eax
 7de:	83 c0 01             	add    $0x1,%eax
 7e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7e4:	a1 50 0b 00 00       	mov    0xb50,%eax
 7e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7f0:	75 23                	jne    815 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7f2:	c7 45 f0 48 0b 00 00 	movl   $0xb48,-0x10(%ebp)
 7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fc:	a3 50 0b 00 00       	mov    %eax,0xb50
 801:	a1 50 0b 00 00       	mov    0xb50,%eax
 806:	a3 48 0b 00 00       	mov    %eax,0xb48
    base.s.size = 0;
 80b:	c7 05 4c 0b 00 00 00 	movl   $0x0,0xb4c
 812:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	8b 00                	mov    (%eax),%eax
 81a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 826:	72 4d                	jb     875 <malloc+0xa6>
      if(p->s.size == nunits)
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 40 04             	mov    0x4(%eax),%eax
 82e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 831:	75 0c                	jne    83f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 10                	mov    (%eax),%edx
 838:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83b:	89 10                	mov    %edx,(%eax)
 83d:	eb 26                	jmp    865 <malloc+0x96>
      else {
        p->s.size -= nunits;
 83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 842:	8b 40 04             	mov    0x4(%eax),%eax
 845:	2b 45 ec             	sub    -0x14(%ebp),%eax
 848:	89 c2                	mov    %eax,%edx
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 40 04             	mov    0x4(%eax),%eax
 856:	c1 e0 03             	shl    $0x3,%eax
 859:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 862:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 865:	8b 45 f0             	mov    -0x10(%ebp),%eax
 868:	a3 50 0b 00 00       	mov    %eax,0xb50
      return (void*)(p + 1);
 86d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 870:	83 c0 08             	add    $0x8,%eax
 873:	eb 38                	jmp    8ad <malloc+0xde>
    }
    if(p == freep)
 875:	a1 50 0b 00 00       	mov    0xb50,%eax
 87a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 87d:	75 1b                	jne    89a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 87f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 882:	89 04 24             	mov    %eax,(%esp)
 885:	e8 ed fe ff ff       	call   777 <morecore>
 88a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 88d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 891:	75 07                	jne    89a <malloc+0xcb>
        return 0;
 893:	b8 00 00 00 00       	mov    $0x0,%eax
 898:	eb 13                	jmp    8ad <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a3:	8b 00                	mov    (%eax),%eax
 8a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a8:	e9 70 ff ff ff       	jmp    81d <malloc+0x4e>
}
 8ad:	c9                   	leave  
 8ae:	c3                   	ret    
