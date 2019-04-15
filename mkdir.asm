
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
   f:	c7 44 24 04 02 09 00 	movl   $0x902,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 d5 04 00 00       	call   4f8 <printf>
    exit();
  23:	e8 cf 02 00 00       	call   2f7 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 4f                	jmp    81 <main+0x81>
    if(mkdir(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 13 03 00 00       	call   35f <mkdir>
  4c:	85 c0                	test   %eax,%eax
  4e:	79 2c                	jns    7c <main+0x7c>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  54:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  5e:	01 d0                	add    %edx,%eax
  60:	8b 00                	mov    (%eax),%eax
  62:	89 44 24 08          	mov    %eax,0x8(%esp)
  66:	c7 44 24 04 19 09 00 	movl   $0x919,0x4(%esp)
  6d:	00 
  6e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  75:	e8 7e 04 00 00       	call   4f8 <printf>
      break;
  7a:	eb 0e                	jmp    8a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  7c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  81:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  85:	3b 45 08             	cmp    0x8(%ebp),%eax
  88:	7c a8                	jl     32 <main+0x32>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  8a:	e8 68 02 00 00       	call   2f7 <exit>

0000008f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8f:	55                   	push   %ebp
  90:	89 e5                	mov    %esp,%ebp
  92:	57                   	push   %edi
  93:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	8b 55 10             	mov    0x10(%ebp),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	89 cb                	mov    %ecx,%ebx
  9f:	89 df                	mov    %ebx,%edi
  a1:	89 d1                	mov    %edx,%ecx
  a3:	fc                   	cld    
  a4:	f3 aa                	rep stos %al,%es:(%edi)
  a6:	89 ca                	mov    %ecx,%edx
  a8:	89 fb                	mov    %edi,%ebx
  aa:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ad:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b0:	5b                   	pop    %ebx
  b1:	5f                   	pop    %edi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  ba:	8b 45 08             	mov    0x8(%ebp),%eax
  bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c0:	90                   	nop
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	8d 50 01             	lea    0x1(%eax),%edx
  c7:	89 55 08             	mov    %edx,0x8(%ebp)
  ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  d0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d3:	0f b6 12             	movzbl (%edx),%edx
  d6:	88 10                	mov    %dl,(%eax)
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	75 e2                	jne    c1 <strcpy+0xd>
    ;
  return os;
  df:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e2:	c9                   	leave  
  e3:	c3                   	ret    

000000e4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e7:	eb 08                	jmp    f1 <strcmp+0xd>
    p++, q++;
  e9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ed:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	84 c0                	test   %al,%al
  f9:	74 10                	je     10b <strcmp+0x27>
  fb:	8b 45 08             	mov    0x8(%ebp),%eax
  fe:	0f b6 10             	movzbl (%eax),%edx
 101:	8b 45 0c             	mov    0xc(%ebp),%eax
 104:	0f b6 00             	movzbl (%eax),%eax
 107:	38 c2                	cmp    %al,%dl
 109:	74 de                	je     e9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	0f b6 00             	movzbl (%eax),%eax
 111:	0f b6 d0             	movzbl %al,%edx
 114:	8b 45 0c             	mov    0xc(%ebp),%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	0f b6 c0             	movzbl %al,%eax
 11d:	29 c2                	sub    %eax,%edx
 11f:	89 d0                	mov    %edx,%eax
}
 121:	5d                   	pop    %ebp
 122:	c3                   	ret    

00000123 <strlen>:

uint
strlen(char *s)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 129:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 130:	eb 04                	jmp    136 <strlen+0x13>
 132:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 136:	8b 55 fc             	mov    -0x4(%ebp),%edx
 139:	8b 45 08             	mov    0x8(%ebp),%eax
 13c:	01 d0                	add    %edx,%eax
 13e:	0f b6 00             	movzbl (%eax),%eax
 141:	84 c0                	test   %al,%al
 143:	75 ed                	jne    132 <strlen+0xf>
    ;
  return n;
 145:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 148:	c9                   	leave  
 149:	c3                   	ret    

0000014a <memset>:

void*
memset(void *dst, int c, uint n)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 150:	8b 45 10             	mov    0x10(%ebp),%eax
 153:	89 44 24 08          	mov    %eax,0x8(%esp)
 157:	8b 45 0c             	mov    0xc(%ebp),%eax
 15a:	89 44 24 04          	mov    %eax,0x4(%esp)
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	89 04 24             	mov    %eax,(%esp)
 164:	e8 26 ff ff ff       	call   8f <stosb>
  return dst;
 169:	8b 45 08             	mov    0x8(%ebp),%eax
}
 16c:	c9                   	leave  
 16d:	c3                   	ret    

0000016e <strchr>:

char*
strchr(const char *s, char c)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 04             	sub    $0x4,%esp
 174:	8b 45 0c             	mov    0xc(%ebp),%eax
 177:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 17a:	eb 14                	jmp    190 <strchr+0x22>
    if(*s == c)
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	0f b6 00             	movzbl (%eax),%eax
 182:	3a 45 fc             	cmp    -0x4(%ebp),%al
 185:	75 05                	jne    18c <strchr+0x1e>
      return (char*)s;
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	eb 13                	jmp    19f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 18c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	84 c0                	test   %al,%al
 198:	75 e2                	jne    17c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 19a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 19f:	c9                   	leave  
 1a0:	c3                   	ret    

000001a1 <gets>:

char*
gets(char *buf, int max)
{
 1a1:	55                   	push   %ebp
 1a2:	89 e5                	mov    %esp,%ebp
 1a4:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1ae:	eb 4c                	jmp    1fc <gets+0x5b>
    cc = read(0, &c, 1);
 1b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1b7:	00 
 1b8:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1c6:	e8 44 01 00 00       	call   30f <read>
 1cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1d2:	7f 02                	jg     1d6 <gets+0x35>
      break;
 1d4:	eb 31                	jmp    207 <gets+0x66>
    buf[i++] = c;
 1d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d9:	8d 50 01             	lea    0x1(%eax),%edx
 1dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1df:	89 c2                	mov    %eax,%edx
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	01 c2                	add    %eax,%edx
 1e6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ea:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ec:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f0:	3c 0a                	cmp    $0xa,%al
 1f2:	74 13                	je     207 <gets+0x66>
 1f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f8:	3c 0d                	cmp    $0xd,%al
 1fa:	74 0b                	je     207 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ff:	83 c0 01             	add    $0x1,%eax
 202:	3b 45 0c             	cmp    0xc(%ebp),%eax
 205:	7c a9                	jl     1b0 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 207:	8b 55 f4             	mov    -0xc(%ebp),%edx
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	01 d0                	add    %edx,%eax
 20f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 212:	8b 45 08             	mov    0x8(%ebp),%eax
}
 215:	c9                   	leave  
 216:	c3                   	ret    

00000217 <stat>:

int
stat(char *n, struct stat *st)
{
 217:	55                   	push   %ebp
 218:	89 e5                	mov    %esp,%ebp
 21a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 224:	00 
 225:	8b 45 08             	mov    0x8(%ebp),%eax
 228:	89 04 24             	mov    %eax,(%esp)
 22b:	e8 07 01 00 00       	call   337 <open>
 230:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 233:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 237:	79 07                	jns    240 <stat+0x29>
    return -1;
 239:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23e:	eb 23                	jmp    263 <stat+0x4c>
  r = fstat(fd, st);
 240:	8b 45 0c             	mov    0xc(%ebp),%eax
 243:	89 44 24 04          	mov    %eax,0x4(%esp)
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	89 04 24             	mov    %eax,(%esp)
 24d:	e8 fd 00 00 00       	call   34f <fstat>
 252:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 255:	8b 45 f4             	mov    -0xc(%ebp),%eax
 258:	89 04 24             	mov    %eax,(%esp)
 25b:	e8 bf 00 00 00       	call   31f <close>
  return r;
 260:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 263:	c9                   	leave  
 264:	c3                   	ret    

00000265 <atoi>:

int
atoi(const char *s)
{
 265:	55                   	push   %ebp
 266:	89 e5                	mov    %esp,%ebp
 268:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 26b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 272:	eb 25                	jmp    299 <atoi+0x34>
    n = n*10 + *s++ - '0';
 274:	8b 55 fc             	mov    -0x4(%ebp),%edx
 277:	89 d0                	mov    %edx,%eax
 279:	c1 e0 02             	shl    $0x2,%eax
 27c:	01 d0                	add    %edx,%eax
 27e:	01 c0                	add    %eax,%eax
 280:	89 c1                	mov    %eax,%ecx
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	8d 50 01             	lea    0x1(%eax),%edx
 288:	89 55 08             	mov    %edx,0x8(%ebp)
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	0f be c0             	movsbl %al,%eax
 291:	01 c8                	add    %ecx,%eax
 293:	83 e8 30             	sub    $0x30,%eax
 296:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	0f b6 00             	movzbl (%eax),%eax
 29f:	3c 2f                	cmp    $0x2f,%al
 2a1:	7e 0a                	jle    2ad <atoi+0x48>
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 00             	movzbl (%eax),%eax
 2a9:	3c 39                	cmp    $0x39,%al
 2ab:	7e c7                	jle    274 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b0:	c9                   	leave  
 2b1:	c3                   	ret    

000002b2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b2:	55                   	push   %ebp
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
 2bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2be:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2c4:	eb 17                	jmp    2dd <memmove+0x2b>
    *dst++ = *src++;
 2c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c9:	8d 50 01             	lea    0x1(%eax),%edx
 2cc:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2cf:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2d2:	8d 4a 01             	lea    0x1(%edx),%ecx
 2d5:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2d8:	0f b6 12             	movzbl (%edx),%edx
 2db:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2dd:	8b 45 10             	mov    0x10(%ebp),%eax
 2e0:	8d 50 ff             	lea    -0x1(%eax),%edx
 2e3:	89 55 10             	mov    %edx,0x10(%ebp)
 2e6:	85 c0                	test   %eax,%eax
 2e8:	7f dc                	jg     2c6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ed:	c9                   	leave  
 2ee:	c3                   	ret    

000002ef <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ef:	b8 01 00 00 00       	mov    $0x1,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <exit>:
SYSCALL(exit)
 2f7:	b8 02 00 00 00       	mov    $0x2,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <wait>:
SYSCALL(wait)
 2ff:	b8 03 00 00 00       	mov    $0x3,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <pipe>:
SYSCALL(pipe)
 307:	b8 04 00 00 00       	mov    $0x4,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <read>:
SYSCALL(read)
 30f:	b8 05 00 00 00       	mov    $0x5,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <write>:
SYSCALL(write)
 317:	b8 10 00 00 00       	mov    $0x10,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <close>:
SYSCALL(close)
 31f:	b8 15 00 00 00       	mov    $0x15,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <kill>:
SYSCALL(kill)
 327:	b8 06 00 00 00       	mov    $0x6,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <exec>:
SYSCALL(exec)
 32f:	b8 07 00 00 00       	mov    $0x7,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <open>:
SYSCALL(open)
 337:	b8 0f 00 00 00       	mov    $0xf,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <mknod>:
SYSCALL(mknod)
 33f:	b8 11 00 00 00       	mov    $0x11,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <unlink>:
SYSCALL(unlink)
 347:	b8 12 00 00 00       	mov    $0x12,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <fstat>:
SYSCALL(fstat)
 34f:	b8 08 00 00 00       	mov    $0x8,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <link>:
SYSCALL(link)
 357:	b8 13 00 00 00       	mov    $0x13,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <mkdir>:
SYSCALL(mkdir)
 35f:	b8 14 00 00 00       	mov    $0x14,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <chdir>:
SYSCALL(chdir)
 367:	b8 09 00 00 00       	mov    $0x9,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <dup>:
SYSCALL(dup)
 36f:	b8 0a 00 00 00       	mov    $0xa,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <getpid>:
SYSCALL(getpid)
 377:	b8 0b 00 00 00       	mov    $0xb,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <sbrk>:
SYSCALL(sbrk)
 37f:	b8 0c 00 00 00       	mov    $0xc,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <sleep>:
SYSCALL(sleep)
 387:	b8 0d 00 00 00       	mov    $0xd,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <uptime>:
SYSCALL(uptime)
 38f:	b8 0e 00 00 00       	mov    $0xe,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <gettime>:
SYSCALL(gettime)
 397:	b8 16 00 00 00       	mov    $0x16,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <settickets>:
SYSCALL(settickets)
 39f:	b8 17 00 00 00       	mov    $0x17,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3a7:	55                   	push   %ebp
 3a8:	89 e5                	mov    %esp,%ebp
 3aa:	83 ec 18             	sub    $0x18,%esp
 3ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3b3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3ba:	00 
 3bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3be:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c2:	8b 45 08             	mov    0x8(%ebp),%eax
 3c5:	89 04 24             	mov    %eax,(%esp)
 3c8:	e8 4a ff ff ff       	call   317 <write>
}
 3cd:	c9                   	leave  
 3ce:	c3                   	ret    

000003cf <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	56                   	push   %esi
 3d3:	53                   	push   %ebx
 3d4:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3de:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3e2:	74 17                	je     3fb <printint+0x2c>
 3e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3e8:	79 11                	jns    3fb <printint+0x2c>
    neg = 1;
 3ea:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f4:	f7 d8                	neg    %eax
 3f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f9:	eb 06                	jmp    401 <printint+0x32>
  } else {
    x = xx;
 3fb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 401:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 408:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 40b:	8d 41 01             	lea    0x1(%ecx),%eax
 40e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 411:	8b 5d 10             	mov    0x10(%ebp),%ebx
 414:	8b 45 ec             	mov    -0x14(%ebp),%eax
 417:	ba 00 00 00 00       	mov    $0x0,%edx
 41c:	f7 f3                	div    %ebx
 41e:	89 d0                	mov    %edx,%eax
 420:	0f b6 80 a0 0b 00 00 	movzbl 0xba0(%eax),%eax
 427:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 42b:	8b 75 10             	mov    0x10(%ebp),%esi
 42e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 431:	ba 00 00 00 00       	mov    $0x0,%edx
 436:	f7 f6                	div    %esi
 438:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43f:	75 c7                	jne    408 <printint+0x39>
  if(neg)
 441:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 445:	74 10                	je     457 <printint+0x88>
    buf[i++] = '-';
 447:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44a:	8d 50 01             	lea    0x1(%eax),%edx
 44d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 450:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 455:	eb 1f                	jmp    476 <printint+0xa7>
 457:	eb 1d                	jmp    476 <printint+0xa7>
    putc(fd, buf[i]);
 459:	8d 55 dc             	lea    -0x24(%ebp),%edx
 45c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 45f:	01 d0                	add    %edx,%eax
 461:	0f b6 00             	movzbl (%eax),%eax
 464:	0f be c0             	movsbl %al,%eax
 467:	89 44 24 04          	mov    %eax,0x4(%esp)
 46b:	8b 45 08             	mov    0x8(%ebp),%eax
 46e:	89 04 24             	mov    %eax,(%esp)
 471:	e8 31 ff ff ff       	call   3a7 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 476:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 47a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 47e:	79 d9                	jns    459 <printint+0x8a>
    putc(fd, buf[i]);
}
 480:	83 c4 30             	add    $0x30,%esp
 483:	5b                   	pop    %ebx
 484:	5e                   	pop    %esi
 485:	5d                   	pop    %ebp
 486:	c3                   	ret    

00000487 <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 487:	55                   	push   %ebp
 488:	89 e5                	mov    %esp,%ebp
 48a:	83 ec 38             	sub    $0x38,%esp
 48d:	8b 45 0c             	mov    0xc(%ebp),%eax
 490:	89 45 e0             	mov    %eax,-0x20(%ebp)
 493:	8b 45 10             	mov    0x10(%ebp),%eax
 496:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 499:	8b 45 e0             	mov    -0x20(%ebp),%eax
 49c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 49f:	89 d0                	mov    %edx,%eax
 4a1:	31 d2                	xor    %edx,%edx
 4a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 4a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
 4a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 4ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b0:	74 22                	je     4d4 <printlong+0x4d>
 4b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b5:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4bc:	00 
 4bd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4c4:	00 
 4c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c9:	8b 45 08             	mov    0x8(%ebp),%eax
 4cc:	89 04 24             	mov    %eax,(%esp)
 4cf:	e8 fb fe ff ff       	call   3cf <printint>
    printint(fd, lower, 16, 0);
 4d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4de:	00 
 4df:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4e6:	00 
 4e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4eb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ee:	89 04 24             	mov    %eax,(%esp)
 4f1:	e8 d9 fe ff ff       	call   3cf <printint>
}
 4f6:	c9                   	leave  
 4f7:	c3                   	ret    

000004f8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 4f8:	55                   	push   %ebp
 4f9:	89 e5                	mov    %esp,%ebp
 4fb:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 505:	8d 45 0c             	lea    0xc(%ebp),%eax
 508:	83 c0 04             	add    $0x4,%eax
 50b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 50e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 515:	e9 ba 01 00 00       	jmp    6d4 <printf+0x1dc>
    c = fmt[i] & 0xff;
 51a:	8b 55 0c             	mov    0xc(%ebp),%edx
 51d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 520:	01 d0                	add    %edx,%eax
 522:	0f b6 00             	movzbl (%eax),%eax
 525:	0f be c0             	movsbl %al,%eax
 528:	25 ff 00 00 00       	and    $0xff,%eax
 52d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 530:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 534:	75 2c                	jne    562 <printf+0x6a>
      if(c == '%'){
 536:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 53a:	75 0c                	jne    548 <printf+0x50>
        state = '%';
 53c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 543:	e9 88 01 00 00       	jmp    6d0 <printf+0x1d8>
      } else {
        putc(fd, c);
 548:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 54b:	0f be c0             	movsbl %al,%eax
 54e:	89 44 24 04          	mov    %eax,0x4(%esp)
 552:	8b 45 08             	mov    0x8(%ebp),%eax
 555:	89 04 24             	mov    %eax,(%esp)
 558:	e8 4a fe ff ff       	call   3a7 <putc>
 55d:	e9 6e 01 00 00       	jmp    6d0 <printf+0x1d8>
      }
    } else if(state == '%'){
 562:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 566:	0f 85 64 01 00 00    	jne    6d0 <printf+0x1d8>
      if(c == 'd'){
 56c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 570:	75 2d                	jne    59f <printf+0xa7>
        printint(fd, *ap, 10, 1);
 572:	8b 45 e8             	mov    -0x18(%ebp),%eax
 575:	8b 00                	mov    (%eax),%eax
 577:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 57e:	00 
 57f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 586:	00 
 587:	89 44 24 04          	mov    %eax,0x4(%esp)
 58b:	8b 45 08             	mov    0x8(%ebp),%eax
 58e:	89 04 24             	mov    %eax,(%esp)
 591:	e8 39 fe ff ff       	call   3cf <printint>
        ap++;
 596:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59a:	e9 2a 01 00 00       	jmp    6c9 <printf+0x1d1>
      } else if(c == 'l') {
 59f:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 5a3:	75 38                	jne    5dd <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 5a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a8:	8b 50 04             	mov    0x4(%eax),%edx
 5ab:	8b 00                	mov    (%eax),%eax
 5ad:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 5b4:	00 
 5b5:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 5bc:	00 
 5bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c1:	89 54 24 08          	mov    %edx,0x8(%esp)
 5c5:	8b 45 08             	mov    0x8(%ebp),%eax
 5c8:	89 04 24             	mov    %eax,(%esp)
 5cb:	e8 b7 fe ff ff       	call   487 <printlong>
        // long longs take up 2 argument slots
        ap++;
 5d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 5d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d8:	e9 ec 00 00 00       	jmp    6c9 <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 5dd:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5e1:	74 06                	je     5e9 <printf+0xf1>
 5e3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5e7:	75 2d                	jne    616 <printf+0x11e>
        printint(fd, *ap, 16, 0);
 5e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5f5:	00 
 5f6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5fd:	00 
 5fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 602:	8b 45 08             	mov    0x8(%ebp),%eax
 605:	89 04 24             	mov    %eax,(%esp)
 608:	e8 c2 fd ff ff       	call   3cf <printint>
        ap++;
 60d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 611:	e9 b3 00 00 00       	jmp    6c9 <printf+0x1d1>
      } else if(c == 's'){
 616:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 61a:	75 45                	jne    661 <printf+0x169>
        s = (char*)*ap;
 61c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 624:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 628:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 62c:	75 09                	jne    637 <printf+0x13f>
          s = "(null)";
 62e:	c7 45 f4 35 09 00 00 	movl   $0x935,-0xc(%ebp)
        while(*s != 0){
 635:	eb 1e                	jmp    655 <printf+0x15d>
 637:	eb 1c                	jmp    655 <printf+0x15d>
          putc(fd, *s);
 639:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63c:	0f b6 00             	movzbl (%eax),%eax
 63f:	0f be c0             	movsbl %al,%eax
 642:	89 44 24 04          	mov    %eax,0x4(%esp)
 646:	8b 45 08             	mov    0x8(%ebp),%eax
 649:	89 04 24             	mov    %eax,(%esp)
 64c:	e8 56 fd ff ff       	call   3a7 <putc>
          s++;
 651:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 655:	8b 45 f4             	mov    -0xc(%ebp),%eax
 658:	0f b6 00             	movzbl (%eax),%eax
 65b:	84 c0                	test   %al,%al
 65d:	75 da                	jne    639 <printf+0x141>
 65f:	eb 68                	jmp    6c9 <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 661:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 665:	75 1d                	jne    684 <printf+0x18c>
        putc(fd, *ap);
 667:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66a:	8b 00                	mov    (%eax),%eax
 66c:	0f be c0             	movsbl %al,%eax
 66f:	89 44 24 04          	mov    %eax,0x4(%esp)
 673:	8b 45 08             	mov    0x8(%ebp),%eax
 676:	89 04 24             	mov    %eax,(%esp)
 679:	e8 29 fd ff ff       	call   3a7 <putc>
        ap++;
 67e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 682:	eb 45                	jmp    6c9 <printf+0x1d1>
      } else if(c == '%'){
 684:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 688:	75 17                	jne    6a1 <printf+0x1a9>
        putc(fd, c);
 68a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 68d:	0f be c0             	movsbl %al,%eax
 690:	89 44 24 04          	mov    %eax,0x4(%esp)
 694:	8b 45 08             	mov    0x8(%ebp),%eax
 697:	89 04 24             	mov    %eax,(%esp)
 69a:	e8 08 fd ff ff       	call   3a7 <putc>
 69f:	eb 28                	jmp    6c9 <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6a1:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6a8:	00 
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ac:	89 04 24             	mov    %eax,(%esp)
 6af:	e8 f3 fc ff ff       	call   3a7 <putc>
        putc(fd, c);
 6b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b7:	0f be c0             	movsbl %al,%eax
 6ba:	89 44 24 04          	mov    %eax,0x4(%esp)
 6be:	8b 45 08             	mov    0x8(%ebp),%eax
 6c1:	89 04 24             	mov    %eax,(%esp)
 6c4:	e8 de fc ff ff       	call   3a7 <putc>
      }
      state = 0;
 6c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6d0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6d4:	8b 55 0c             	mov    0xc(%ebp),%edx
 6d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6da:	01 d0                	add    %edx,%eax
 6dc:	0f b6 00             	movzbl (%eax),%eax
 6df:	84 c0                	test   %al,%al
 6e1:	0f 85 33 fe ff ff    	jne    51a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6e7:	c9                   	leave  
 6e8:	c3                   	ret    

000006e9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e9:	55                   	push   %ebp
 6ea:	89 e5                	mov    %esp,%ebp
 6ec:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ef:	8b 45 08             	mov    0x8(%ebp),%eax
 6f2:	83 e8 08             	sub    $0x8,%eax
 6f5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f8:	a1 bc 0b 00 00       	mov    0xbbc,%eax
 6fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 700:	eb 24                	jmp    726 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 70a:	77 12                	ja     71e <free+0x35>
 70c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 712:	77 24                	ja     738 <free+0x4f>
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	8b 00                	mov    (%eax),%eax
 719:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 71c:	77 1a                	ja     738 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	8b 00                	mov    (%eax),%eax
 723:	89 45 fc             	mov    %eax,-0x4(%ebp)
 726:	8b 45 f8             	mov    -0x8(%ebp),%eax
 729:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72c:	76 d4                	jbe    702 <free+0x19>
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 00                	mov    (%eax),%eax
 733:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 736:	76 ca                	jbe    702 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 738:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 745:	8b 45 f8             	mov    -0x8(%ebp),%eax
 748:	01 c2                	add    %eax,%edx
 74a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74d:	8b 00                	mov    (%eax),%eax
 74f:	39 c2                	cmp    %eax,%edx
 751:	75 24                	jne    777 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 753:	8b 45 f8             	mov    -0x8(%ebp),%eax
 756:	8b 50 04             	mov    0x4(%eax),%edx
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 00                	mov    (%eax),%eax
 75e:	8b 40 04             	mov    0x4(%eax),%eax
 761:	01 c2                	add    %eax,%edx
 763:	8b 45 f8             	mov    -0x8(%ebp),%eax
 766:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 769:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76c:	8b 00                	mov    (%eax),%eax
 76e:	8b 10                	mov    (%eax),%edx
 770:	8b 45 f8             	mov    -0x8(%ebp),%eax
 773:	89 10                	mov    %edx,(%eax)
 775:	eb 0a                	jmp    781 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 10                	mov    (%eax),%edx
 77c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	8b 40 04             	mov    0x4(%eax),%eax
 787:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	01 d0                	add    %edx,%eax
 793:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 796:	75 20                	jne    7b8 <free+0xcf>
    p->s.size += bp->s.size;
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 50 04             	mov    0x4(%eax),%edx
 79e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a1:	8b 40 04             	mov    0x4(%eax),%eax
 7a4:	01 c2                	add    %eax,%edx
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	8b 10                	mov    (%eax),%edx
 7b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b4:	89 10                	mov    %edx,(%eax)
 7b6:	eb 08                	jmp    7c0 <free+0xd7>
  } else
    p->s.ptr = bp;
 7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7be:	89 10                	mov    %edx,(%eax)
  freep = p;
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	a3 bc 0b 00 00       	mov    %eax,0xbbc
}
 7c8:	c9                   	leave  
 7c9:	c3                   	ret    

000007ca <morecore>:

static Header*
morecore(uint nu)
{
 7ca:	55                   	push   %ebp
 7cb:	89 e5                	mov    %esp,%ebp
 7cd:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7d0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7d7:	77 07                	ja     7e0 <morecore+0x16>
    nu = 4096;
 7d9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7e0:	8b 45 08             	mov    0x8(%ebp),%eax
 7e3:	c1 e0 03             	shl    $0x3,%eax
 7e6:	89 04 24             	mov    %eax,(%esp)
 7e9:	e8 91 fb ff ff       	call   37f <sbrk>
 7ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7f1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7f5:	75 07                	jne    7fe <morecore+0x34>
    return 0;
 7f7:	b8 00 00 00 00       	mov    $0x0,%eax
 7fc:	eb 22                	jmp    820 <morecore+0x56>
  hp = (Header*)p;
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 804:	8b 45 f0             	mov    -0x10(%ebp),%eax
 807:	8b 55 08             	mov    0x8(%ebp),%edx
 80a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 80d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 810:	83 c0 08             	add    $0x8,%eax
 813:	89 04 24             	mov    %eax,(%esp)
 816:	e8 ce fe ff ff       	call   6e9 <free>
  return freep;
 81b:	a1 bc 0b 00 00       	mov    0xbbc,%eax
}
 820:	c9                   	leave  
 821:	c3                   	ret    

00000822 <malloc>:

void*
malloc(uint nbytes)
{
 822:	55                   	push   %ebp
 823:	89 e5                	mov    %esp,%ebp
 825:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 828:	8b 45 08             	mov    0x8(%ebp),%eax
 82b:	83 c0 07             	add    $0x7,%eax
 82e:	c1 e8 03             	shr    $0x3,%eax
 831:	83 c0 01             	add    $0x1,%eax
 834:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 837:	a1 bc 0b 00 00       	mov    0xbbc,%eax
 83c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 83f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 843:	75 23                	jne    868 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 845:	c7 45 f0 b4 0b 00 00 	movl   $0xbb4,-0x10(%ebp)
 84c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84f:	a3 bc 0b 00 00       	mov    %eax,0xbbc
 854:	a1 bc 0b 00 00       	mov    0xbbc,%eax
 859:	a3 b4 0b 00 00       	mov    %eax,0xbb4
    base.s.size = 0;
 85e:	c7 05 b8 0b 00 00 00 	movl   $0x0,0xbb8
 865:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 868:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86b:	8b 00                	mov    (%eax),%eax
 86d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 870:	8b 45 f4             	mov    -0xc(%ebp),%eax
 873:	8b 40 04             	mov    0x4(%eax),%eax
 876:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 879:	72 4d                	jb     8c8 <malloc+0xa6>
      if(p->s.size == nunits)
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	8b 40 04             	mov    0x4(%eax),%eax
 881:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 884:	75 0c                	jne    892 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 886:	8b 45 f4             	mov    -0xc(%ebp),%eax
 889:	8b 10                	mov    (%eax),%edx
 88b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88e:	89 10                	mov    %edx,(%eax)
 890:	eb 26                	jmp    8b8 <malloc+0x96>
      else {
        p->s.size -= nunits;
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	8b 40 04             	mov    0x4(%eax),%eax
 898:	2b 45 ec             	sub    -0x14(%ebp),%eax
 89b:	89 c2                	mov    %eax,%edx
 89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a6:	8b 40 04             	mov    0x4(%eax),%eax
 8a9:	c1 e0 03             	shl    $0x3,%eax
 8ac:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b2:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8b5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bb:	a3 bc 0b 00 00       	mov    %eax,0xbbc
      return (void*)(p + 1);
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	83 c0 08             	add    $0x8,%eax
 8c6:	eb 38                	jmp    900 <malloc+0xde>
    }
    if(p == freep)
 8c8:	a1 bc 0b 00 00       	mov    0xbbc,%eax
 8cd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8d0:	75 1b                	jne    8ed <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8d5:	89 04 24             	mov    %eax,(%esp)
 8d8:	e8 ed fe ff ff       	call   7ca <morecore>
 8dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8e4:	75 07                	jne    8ed <malloc+0xcb>
        return 0;
 8e6:	b8 00 00 00 00       	mov    $0x0,%eax
 8eb:	eb 13                	jmp    900 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f6:	8b 00                	mov    (%eax),%eax
 8f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8fb:	e9 70 ff ff ff       	jmp    870 <malloc+0x4e>
}
 900:	c9                   	leave  
 901:	c3                   	ret    
