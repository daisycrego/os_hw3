
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	81 ec 30 02 00 00    	sub    $0x230,%esp
  int fd, i;
  char path[] = "stressfs0";
   c:	c7 84 24 1e 02 00 00 	movl   $0x65727473,0x21e(%esp)
  13:	73 74 72 65 
  17:	c7 84 24 22 02 00 00 	movl   $0x73667373,0x222(%esp)
  1e:	73 73 66 73 
  22:	66 c7 84 24 26 02 00 	movw   $0x30,0x226(%esp)
  29:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	c7 44 24 04 26 0a 00 	movl   $0xa26,0x4(%esp)
  33:	00 
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	e8 dc 05 00 00       	call   61c <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  54:	89 04 24             	mov    %eax,(%esp)
  57:	e8 12 02 00 00       	call   26e <memset>

  for(i = 0; i < 4; i++)
  5c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  63:	00 00 00 00 
  67:	eb 13                	jmp    7c <main+0x7c>
    if(fork() > 0)
  69:	e8 a5 03 00 00       	call   413 <fork>
  6e:	85 c0                	test   %eax,%eax
  70:	7e 02                	jle    74 <main+0x74>
      break;
  72:	eb 12                	jmp    86 <main+0x86>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  74:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
  7b:	01 
  7c:	83 bc 24 2c 02 00 00 	cmpl   $0x3,0x22c(%esp)
  83:	03 
  84:	7e e3                	jle    69 <main+0x69>
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  86:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  8d:	89 44 24 08          	mov    %eax,0x8(%esp)
  91:	c7 44 24 04 39 0a 00 	movl   $0xa39,0x4(%esp)
  98:	00 
  99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a0:	e8 77 05 00 00       	call   61c <printf>

  path[8] += i;
  a5:	0f b6 84 24 26 02 00 	movzbl 0x226(%esp),%eax
  ac:	00 
  ad:	89 c2                	mov    %eax,%edx
  af:	8b 84 24 2c 02 00 00 	mov    0x22c(%esp),%eax
  b6:	01 d0                	add    %edx,%eax
  b8:	88 84 24 26 02 00 00 	mov    %al,0x226(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  bf:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c6:	00 
  c7:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
  ce:	89 04 24             	mov    %eax,(%esp)
  d1:	e8 85 03 00 00       	call   45b <open>
  d6:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for(i = 0; i < 20; i++)
  dd:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
  e4:	00 00 00 00 
  e8:	eb 27                	jmp    111 <main+0x111>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  ea:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  f1:	00 
  f2:	8d 44 24 1e          	lea    0x1e(%esp),%eax
  f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  fa:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 101:	89 04 24             	mov    %eax,(%esp)
 104:	e8 32 03 00 00       	call   43b <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
 109:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 110:	01 
 111:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 118:	13 
 119:	7e cf                	jle    ea <main+0xea>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
 11b:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 122:	89 04 24             	mov    %eax,(%esp)
 125:	e8 19 03 00 00       	call   443 <close>

  printf(1, "read\n");
 12a:	c7 44 24 04 43 0a 00 	movl   $0xa43,0x4(%esp)
 131:	00 
 132:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 139:	e8 de 04 00 00       	call   61c <printf>

  fd = open(path, O_RDONLY);
 13e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 145:	00 
 146:	8d 84 24 1e 02 00 00 	lea    0x21e(%esp),%eax
 14d:	89 04 24             	mov    %eax,(%esp)
 150:	e8 06 03 00 00       	call   45b <open>
 155:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
  for (i = 0; i < 20; i++)
 15c:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
 163:	00 00 00 00 
 167:	eb 27                	jmp    190 <main+0x190>
    read(fd, data, sizeof(data));
 169:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 170:	00 
 171:	8d 44 24 1e          	lea    0x1e(%esp),%eax
 175:	89 44 24 04          	mov    %eax,0x4(%esp)
 179:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 180:	89 04 24             	mov    %eax,(%esp)
 183:	e8 ab 02 00 00       	call   433 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 188:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
 18f:	01 
 190:	83 bc 24 2c 02 00 00 	cmpl   $0x13,0x22c(%esp)
 197:	13 
 198:	7e cf                	jle    169 <main+0x169>
    read(fd, data, sizeof(data));
  close(fd);
 19a:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
 1a1:	89 04 24             	mov    %eax,(%esp)
 1a4:	e8 9a 02 00 00       	call   443 <close>

  wait();
 1a9:	e8 75 02 00 00       	call   423 <wait>
  
  exit();
 1ae:	e8 68 02 00 00       	call   41b <exit>

000001b3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	57                   	push   %edi
 1b7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bb:	8b 55 10             	mov    0x10(%ebp),%edx
 1be:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c1:	89 cb                	mov    %ecx,%ebx
 1c3:	89 df                	mov    %ebx,%edi
 1c5:	89 d1                	mov    %edx,%ecx
 1c7:	fc                   	cld    
 1c8:	f3 aa                	rep stos %al,%es:(%edi)
 1ca:	89 ca                	mov    %ecx,%edx
 1cc:	89 fb                	mov    %edi,%ebx
 1ce:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d4:	5b                   	pop    %ebx
 1d5:	5f                   	pop    %edi
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    

000001d8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
 1e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e4:	90                   	nop
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	8d 50 01             	lea    0x1(%eax),%edx
 1eb:	89 55 08             	mov    %edx,0x8(%ebp)
 1ee:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f1:	8d 4a 01             	lea    0x1(%edx),%ecx
 1f4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1f7:	0f b6 12             	movzbl (%edx),%edx
 1fa:	88 10                	mov    %dl,(%eax)
 1fc:	0f b6 00             	movzbl (%eax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	75 e2                	jne    1e5 <strcpy+0xd>
    ;
  return os;
 203:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 20b:	eb 08                	jmp    215 <strcmp+0xd>
    p++, q++;
 20d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 211:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	84 c0                	test   %al,%al
 21d:	74 10                	je     22f <strcmp+0x27>
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
 222:	0f b6 10             	movzbl (%eax),%edx
 225:	8b 45 0c             	mov    0xc(%ebp),%eax
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	38 c2                	cmp    %al,%dl
 22d:	74 de                	je     20d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	0f b6 d0             	movzbl %al,%edx
 238:	8b 45 0c             	mov    0xc(%ebp),%eax
 23b:	0f b6 00             	movzbl (%eax),%eax
 23e:	0f b6 c0             	movzbl %al,%eax
 241:	29 c2                	sub    %eax,%edx
 243:	89 d0                	mov    %edx,%eax
}
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    

00000247 <strlen>:

uint
strlen(char *s)
{
 247:	55                   	push   %ebp
 248:	89 e5                	mov    %esp,%ebp
 24a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 24d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 254:	eb 04                	jmp    25a <strlen+0x13>
 256:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 25a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	01 d0                	add    %edx,%eax
 262:	0f b6 00             	movzbl (%eax),%eax
 265:	84 c0                	test   %al,%al
 267:	75 ed                	jne    256 <strlen+0xf>
    ;
  return n;
 269:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26c:	c9                   	leave  
 26d:	c3                   	ret    

0000026e <memset>:

void*
memset(void *dst, int c, uint n)
{
 26e:	55                   	push   %ebp
 26f:	89 e5                	mov    %esp,%ebp
 271:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 274:	8b 45 10             	mov    0x10(%ebp),%eax
 277:	89 44 24 08          	mov    %eax,0x8(%esp)
 27b:	8b 45 0c             	mov    0xc(%ebp),%eax
 27e:	89 44 24 04          	mov    %eax,0x4(%esp)
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	89 04 24             	mov    %eax,(%esp)
 288:	e8 26 ff ff ff       	call   1b3 <stosb>
  return dst;
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 290:	c9                   	leave  
 291:	c3                   	ret    

00000292 <strchr>:

char*
strchr(const char *s, char c)
{
 292:	55                   	push   %ebp
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 04             	sub    $0x4,%esp
 298:	8b 45 0c             	mov    0xc(%ebp),%eax
 29b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 29e:	eb 14                	jmp    2b4 <strchr+0x22>
    if(*s == c)
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	0f b6 00             	movzbl (%eax),%eax
 2a6:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2a9:	75 05                	jne    2b0 <strchr+0x1e>
      return (char*)s;
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	eb 13                	jmp    2c3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	0f b6 00             	movzbl (%eax),%eax
 2ba:	84 c0                	test   %al,%al
 2bc:	75 e2                	jne    2a0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2be:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c3:	c9                   	leave  
 2c4:	c3                   	ret    

000002c5 <gets>:

char*
gets(char *buf, int max)
{
 2c5:	55                   	push   %ebp
 2c6:	89 e5                	mov    %esp,%ebp
 2c8:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d2:	eb 4c                	jmp    320 <gets+0x5b>
    cc = read(0, &c, 1);
 2d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2db:	00 
 2dc:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2df:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2ea:	e8 44 01 00 00       	call   433 <read>
 2ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2f6:	7f 02                	jg     2fa <gets+0x35>
      break;
 2f8:	eb 31                	jmp    32b <gets+0x66>
    buf[i++] = c;
 2fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2fd:	8d 50 01             	lea    0x1(%eax),%edx
 300:	89 55 f4             	mov    %edx,-0xc(%ebp)
 303:	89 c2                	mov    %eax,%edx
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	01 c2                	add    %eax,%edx
 30a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 310:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 314:	3c 0a                	cmp    $0xa,%al
 316:	74 13                	je     32b <gets+0x66>
 318:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31c:	3c 0d                	cmp    $0xd,%al
 31e:	74 0b                	je     32b <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 320:	8b 45 f4             	mov    -0xc(%ebp),%eax
 323:	83 c0 01             	add    $0x1,%eax
 326:	3b 45 0c             	cmp    0xc(%ebp),%eax
 329:	7c a9                	jl     2d4 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	01 d0                	add    %edx,%eax
 333:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 336:	8b 45 08             	mov    0x8(%ebp),%eax
}
 339:	c9                   	leave  
 33a:	c3                   	ret    

0000033b <stat>:

int
stat(char *n, struct stat *st)
{
 33b:	55                   	push   %ebp
 33c:	89 e5                	mov    %esp,%ebp
 33e:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 341:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 348:	00 
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	89 04 24             	mov    %eax,(%esp)
 34f:	e8 07 01 00 00       	call   45b <open>
 354:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 357:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 35b:	79 07                	jns    364 <stat+0x29>
    return -1;
 35d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 362:	eb 23                	jmp    387 <stat+0x4c>
  r = fstat(fd, st);
 364:	8b 45 0c             	mov    0xc(%ebp),%eax
 367:	89 44 24 04          	mov    %eax,0x4(%esp)
 36b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 36e:	89 04 24             	mov    %eax,(%esp)
 371:	e8 fd 00 00 00       	call   473 <fstat>
 376:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 379:	8b 45 f4             	mov    -0xc(%ebp),%eax
 37c:	89 04 24             	mov    %eax,(%esp)
 37f:	e8 bf 00 00 00       	call   443 <close>
  return r;
 384:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 387:	c9                   	leave  
 388:	c3                   	ret    

00000389 <atoi>:

int
atoi(const char *s)
{
 389:	55                   	push   %ebp
 38a:	89 e5                	mov    %esp,%ebp
 38c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 38f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 396:	eb 25                	jmp    3bd <atoi+0x34>
    n = n*10 + *s++ - '0';
 398:	8b 55 fc             	mov    -0x4(%ebp),%edx
 39b:	89 d0                	mov    %edx,%eax
 39d:	c1 e0 02             	shl    $0x2,%eax
 3a0:	01 d0                	add    %edx,%eax
 3a2:	01 c0                	add    %eax,%eax
 3a4:	89 c1                	mov    %eax,%ecx
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
 3a9:	8d 50 01             	lea    0x1(%eax),%edx
 3ac:	89 55 08             	mov    %edx,0x8(%ebp)
 3af:	0f b6 00             	movzbl (%eax),%eax
 3b2:	0f be c0             	movsbl %al,%eax
 3b5:	01 c8                	add    %ecx,%eax
 3b7:	83 e8 30             	sub    $0x30,%eax
 3ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3bd:	8b 45 08             	mov    0x8(%ebp),%eax
 3c0:	0f b6 00             	movzbl (%eax),%eax
 3c3:	3c 2f                	cmp    $0x2f,%al
 3c5:	7e 0a                	jle    3d1 <atoi+0x48>
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	3c 39                	cmp    $0x39,%al
 3cf:	7e c7                	jle    398 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d4:	c9                   	leave  
 3d5:	c3                   	ret    

000003d6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3d6:	55                   	push   %ebp
 3d7:	89 e5                	mov    %esp,%ebp
 3d9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3dc:	8b 45 08             	mov    0x8(%ebp),%eax
 3df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e8:	eb 17                	jmp    401 <memmove+0x2b>
    *dst++ = *src++;
 3ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ed:	8d 50 01             	lea    0x1(%eax),%edx
 3f0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3f3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3f6:	8d 4a 01             	lea    0x1(%edx),%ecx
 3f9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3fc:	0f b6 12             	movzbl (%edx),%edx
 3ff:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 401:	8b 45 10             	mov    0x10(%ebp),%eax
 404:	8d 50 ff             	lea    -0x1(%eax),%edx
 407:	89 55 10             	mov    %edx,0x10(%ebp)
 40a:	85 c0                	test   %eax,%eax
 40c:	7f dc                	jg     3ea <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 40e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 413:	b8 01 00 00 00       	mov    $0x1,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <exit>:
SYSCALL(exit)
 41b:	b8 02 00 00 00       	mov    $0x2,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <wait>:
SYSCALL(wait)
 423:	b8 03 00 00 00       	mov    $0x3,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <pipe>:
SYSCALL(pipe)
 42b:	b8 04 00 00 00       	mov    $0x4,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <read>:
SYSCALL(read)
 433:	b8 05 00 00 00       	mov    $0x5,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <write>:
SYSCALL(write)
 43b:	b8 10 00 00 00       	mov    $0x10,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <close>:
SYSCALL(close)
 443:	b8 15 00 00 00       	mov    $0x15,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <kill>:
SYSCALL(kill)
 44b:	b8 06 00 00 00       	mov    $0x6,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <exec>:
SYSCALL(exec)
 453:	b8 07 00 00 00       	mov    $0x7,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <open>:
SYSCALL(open)
 45b:	b8 0f 00 00 00       	mov    $0xf,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <mknod>:
SYSCALL(mknod)
 463:	b8 11 00 00 00       	mov    $0x11,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <unlink>:
SYSCALL(unlink)
 46b:	b8 12 00 00 00       	mov    $0x12,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <fstat>:
SYSCALL(fstat)
 473:	b8 08 00 00 00       	mov    $0x8,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <link>:
SYSCALL(link)
 47b:	b8 13 00 00 00       	mov    $0x13,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <mkdir>:
SYSCALL(mkdir)
 483:	b8 14 00 00 00       	mov    $0x14,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <chdir>:
SYSCALL(chdir)
 48b:	b8 09 00 00 00       	mov    $0x9,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <dup>:
SYSCALL(dup)
 493:	b8 0a 00 00 00       	mov    $0xa,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <getpid>:
SYSCALL(getpid)
 49b:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <sbrk>:
SYSCALL(sbrk)
 4a3:	b8 0c 00 00 00       	mov    $0xc,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <sleep>:
SYSCALL(sleep)
 4ab:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <uptime>:
SYSCALL(uptime)
 4b3:	b8 0e 00 00 00       	mov    $0xe,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <gettime>:
SYSCALL(gettime)
 4bb:	b8 16 00 00 00       	mov    $0x16,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <settickets>:
SYSCALL(settickets)
 4c3:	b8 17 00 00 00       	mov    $0x17,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4cb:	55                   	push   %ebp
 4cc:	89 e5                	mov    %esp,%ebp
 4ce:	83 ec 18             	sub    $0x18,%esp
 4d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4de:	00 
 4df:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e6:	8b 45 08             	mov    0x8(%ebp),%eax
 4e9:	89 04 24             	mov    %eax,(%esp)
 4ec:	e8 4a ff ff ff       	call   43b <write>
}
 4f1:	c9                   	leave  
 4f2:	c3                   	ret    

000004f3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f3:	55                   	push   %ebp
 4f4:	89 e5                	mov    %esp,%ebp
 4f6:	56                   	push   %esi
 4f7:	53                   	push   %ebx
 4f8:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 502:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 506:	74 17                	je     51f <printint+0x2c>
 508:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 50c:	79 11                	jns    51f <printint+0x2c>
    neg = 1;
 50e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 515:	8b 45 0c             	mov    0xc(%ebp),%eax
 518:	f7 d8                	neg    %eax
 51a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 51d:	eb 06                	jmp    525 <printint+0x32>
  } else {
    x = xx;
 51f:	8b 45 0c             	mov    0xc(%ebp),%eax
 522:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 525:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 52c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 52f:	8d 41 01             	lea    0x1(%ecx),%eax
 532:	89 45 f4             	mov    %eax,-0xc(%ebp)
 535:	8b 5d 10             	mov    0x10(%ebp),%ebx
 538:	8b 45 ec             	mov    -0x14(%ebp),%eax
 53b:	ba 00 00 00 00       	mov    $0x0,%edx
 540:	f7 f3                	div    %ebx
 542:	89 d0                	mov    %edx,%eax
 544:	0f b6 80 b4 0c 00 00 	movzbl 0xcb4(%eax),%eax
 54b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 54f:	8b 75 10             	mov    0x10(%ebp),%esi
 552:	8b 45 ec             	mov    -0x14(%ebp),%eax
 555:	ba 00 00 00 00       	mov    $0x0,%edx
 55a:	f7 f6                	div    %esi
 55c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 55f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 563:	75 c7                	jne    52c <printint+0x39>
  if(neg)
 565:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 569:	74 10                	je     57b <printint+0x88>
    buf[i++] = '-';
 56b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56e:	8d 50 01             	lea    0x1(%eax),%edx
 571:	89 55 f4             	mov    %edx,-0xc(%ebp)
 574:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 579:	eb 1f                	jmp    59a <printint+0xa7>
 57b:	eb 1d                	jmp    59a <printint+0xa7>
    putc(fd, buf[i]);
 57d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 580:	8b 45 f4             	mov    -0xc(%ebp),%eax
 583:	01 d0                	add    %edx,%eax
 585:	0f b6 00             	movzbl (%eax),%eax
 588:	0f be c0             	movsbl %al,%eax
 58b:	89 44 24 04          	mov    %eax,0x4(%esp)
 58f:	8b 45 08             	mov    0x8(%ebp),%eax
 592:	89 04 24             	mov    %eax,(%esp)
 595:	e8 31 ff ff ff       	call   4cb <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 59a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 59e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a2:	79 d9                	jns    57d <printint+0x8a>
    putc(fd, buf[i]);
}
 5a4:	83 c4 30             	add    $0x30,%esp
 5a7:	5b                   	pop    %ebx
 5a8:	5e                   	pop    %esi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret    

000005ab <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 5ab:	55                   	push   %ebp
 5ac:	89 e5                	mov    %esp,%ebp
 5ae:	83 ec 38             	sub    $0x38,%esp
 5b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 5b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
 5b7:	8b 45 10             	mov    0x10(%ebp),%eax
 5ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 5bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5c0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 5c3:	89 d0                	mov    %edx,%eax
 5c5:	31 d2                	xor    %edx,%edx
 5c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 5ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
 5cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 5d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5d4:	74 22                	je     5f8 <printlong+0x4d>
 5d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5e0:	00 
 5e1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5e8:	00 
 5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ed:	8b 45 08             	mov    0x8(%ebp),%eax
 5f0:	89 04 24             	mov    %eax,(%esp)
 5f3:	e8 fb fe ff ff       	call   4f3 <printint>
    printint(fd, lower, 16, 0);
 5f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5fb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 602:	00 
 603:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 60a:	00 
 60b:	89 44 24 04          	mov    %eax,0x4(%esp)
 60f:	8b 45 08             	mov    0x8(%ebp),%eax
 612:	89 04 24             	mov    %eax,(%esp)
 615:	e8 d9 fe ff ff       	call   4f3 <printint>
}
 61a:	c9                   	leave  
 61b:	c3                   	ret    

0000061c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 61c:	55                   	push   %ebp
 61d:	89 e5                	mov    %esp,%ebp
 61f:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 622:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 629:	8d 45 0c             	lea    0xc(%ebp),%eax
 62c:	83 c0 04             	add    $0x4,%eax
 62f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 632:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 639:	e9 ba 01 00 00       	jmp    7f8 <printf+0x1dc>
    c = fmt[i] & 0xff;
 63e:	8b 55 0c             	mov    0xc(%ebp),%edx
 641:	8b 45 f0             	mov    -0x10(%ebp),%eax
 644:	01 d0                	add    %edx,%eax
 646:	0f b6 00             	movzbl (%eax),%eax
 649:	0f be c0             	movsbl %al,%eax
 64c:	25 ff 00 00 00       	and    $0xff,%eax
 651:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 654:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 658:	75 2c                	jne    686 <printf+0x6a>
      if(c == '%'){
 65a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 65e:	75 0c                	jne    66c <printf+0x50>
        state = '%';
 660:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 667:	e9 88 01 00 00       	jmp    7f4 <printf+0x1d8>
      } else {
        putc(fd, c);
 66c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 66f:	0f be c0             	movsbl %al,%eax
 672:	89 44 24 04          	mov    %eax,0x4(%esp)
 676:	8b 45 08             	mov    0x8(%ebp),%eax
 679:	89 04 24             	mov    %eax,(%esp)
 67c:	e8 4a fe ff ff       	call   4cb <putc>
 681:	e9 6e 01 00 00       	jmp    7f4 <printf+0x1d8>
      }
    } else if(state == '%'){
 686:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 68a:	0f 85 64 01 00 00    	jne    7f4 <printf+0x1d8>
      if(c == 'd'){
 690:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 694:	75 2d                	jne    6c3 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 696:	8b 45 e8             	mov    -0x18(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 6a2:	00 
 6a3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 6aa:	00 
 6ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 6af:	8b 45 08             	mov    0x8(%ebp),%eax
 6b2:	89 04 24             	mov    %eax,(%esp)
 6b5:	e8 39 fe ff ff       	call   4f3 <printint>
        ap++;
 6ba:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6be:	e9 2a 01 00 00       	jmp    7ed <printf+0x1d1>
      } else if(c == 'l') {
 6c3:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 6c7:	75 38                	jne    701 <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 6c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6cc:	8b 50 04             	mov    0x4(%eax),%edx
 6cf:	8b 00                	mov    (%eax),%eax
 6d1:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 6d8:	00 
 6d9:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 6e0:	00 
 6e1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e5:	89 54 24 08          	mov    %edx,0x8(%esp)
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	89 04 24             	mov    %eax,(%esp)
 6ef:	e8 b7 fe ff ff       	call   5ab <printlong>
        // long longs take up 2 argument slots
        ap++;
 6f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 6f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6fc:	e9 ec 00 00 00       	jmp    7ed <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 701:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 705:	74 06                	je     70d <printf+0xf1>
 707:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 70b:	75 2d                	jne    73a <printf+0x11e>
        printint(fd, *ap, 16, 0);
 70d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 710:	8b 00                	mov    (%eax),%eax
 712:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 719:	00 
 71a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 721:	00 
 722:	89 44 24 04          	mov    %eax,0x4(%esp)
 726:	8b 45 08             	mov    0x8(%ebp),%eax
 729:	89 04 24             	mov    %eax,(%esp)
 72c:	e8 c2 fd ff ff       	call   4f3 <printint>
        ap++;
 731:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 735:	e9 b3 00 00 00       	jmp    7ed <printf+0x1d1>
      } else if(c == 's'){
 73a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 73e:	75 45                	jne    785 <printf+0x169>
        s = (char*)*ap;
 740:	8b 45 e8             	mov    -0x18(%ebp),%eax
 743:	8b 00                	mov    (%eax),%eax
 745:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 748:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 74c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 750:	75 09                	jne    75b <printf+0x13f>
          s = "(null)";
 752:	c7 45 f4 49 0a 00 00 	movl   $0xa49,-0xc(%ebp)
        while(*s != 0){
 759:	eb 1e                	jmp    779 <printf+0x15d>
 75b:	eb 1c                	jmp    779 <printf+0x15d>
          putc(fd, *s);
 75d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 760:	0f b6 00             	movzbl (%eax),%eax
 763:	0f be c0             	movsbl %al,%eax
 766:	89 44 24 04          	mov    %eax,0x4(%esp)
 76a:	8b 45 08             	mov    0x8(%ebp),%eax
 76d:	89 04 24             	mov    %eax,(%esp)
 770:	e8 56 fd ff ff       	call   4cb <putc>
          s++;
 775:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 779:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77c:	0f b6 00             	movzbl (%eax),%eax
 77f:	84 c0                	test   %al,%al
 781:	75 da                	jne    75d <printf+0x141>
 783:	eb 68                	jmp    7ed <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 785:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 789:	75 1d                	jne    7a8 <printf+0x18c>
        putc(fd, *ap);
 78b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 78e:	8b 00                	mov    (%eax),%eax
 790:	0f be c0             	movsbl %al,%eax
 793:	89 44 24 04          	mov    %eax,0x4(%esp)
 797:	8b 45 08             	mov    0x8(%ebp),%eax
 79a:	89 04 24             	mov    %eax,(%esp)
 79d:	e8 29 fd ff ff       	call   4cb <putc>
        ap++;
 7a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7a6:	eb 45                	jmp    7ed <printf+0x1d1>
      } else if(c == '%'){
 7a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ac:	75 17                	jne    7c5 <printf+0x1a9>
        putc(fd, c);
 7ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b1:	0f be c0             	movsbl %al,%eax
 7b4:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b8:	8b 45 08             	mov    0x8(%ebp),%eax
 7bb:	89 04 24             	mov    %eax,(%esp)
 7be:	e8 08 fd ff ff       	call   4cb <putc>
 7c3:	eb 28                	jmp    7ed <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c5:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 7cc:	00 
 7cd:	8b 45 08             	mov    0x8(%ebp),%eax
 7d0:	89 04 24             	mov    %eax,(%esp)
 7d3:	e8 f3 fc ff ff       	call   4cb <putc>
        putc(fd, c);
 7d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7db:	0f be c0             	movsbl %al,%eax
 7de:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e2:	8b 45 08             	mov    0x8(%ebp),%eax
 7e5:	89 04 24             	mov    %eax,(%esp)
 7e8:	e8 de fc ff ff       	call   4cb <putc>
      }
      state = 0;
 7ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7f4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7f8:	8b 55 0c             	mov    0xc(%ebp),%edx
 7fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fe:	01 d0                	add    %edx,%eax
 800:	0f b6 00             	movzbl (%eax),%eax
 803:	84 c0                	test   %al,%al
 805:	0f 85 33 fe ff ff    	jne    63e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 80b:	c9                   	leave  
 80c:	c3                   	ret    

0000080d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 80d:	55                   	push   %ebp
 80e:	89 e5                	mov    %esp,%ebp
 810:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 813:	8b 45 08             	mov    0x8(%ebp),%eax
 816:	83 e8 08             	sub    $0x8,%eax
 819:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81c:	a1 d0 0c 00 00       	mov    0xcd0,%eax
 821:	89 45 fc             	mov    %eax,-0x4(%ebp)
 824:	eb 24                	jmp    84a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 826:	8b 45 fc             	mov    -0x4(%ebp),%eax
 829:	8b 00                	mov    (%eax),%eax
 82b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 82e:	77 12                	ja     842 <free+0x35>
 830:	8b 45 f8             	mov    -0x8(%ebp),%eax
 833:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 836:	77 24                	ja     85c <free+0x4f>
 838:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83b:	8b 00                	mov    (%eax),%eax
 83d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 840:	77 1a                	ja     85c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 842:	8b 45 fc             	mov    -0x4(%ebp),%eax
 845:	8b 00                	mov    (%eax),%eax
 847:	89 45 fc             	mov    %eax,-0x4(%ebp)
 84a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 850:	76 d4                	jbe    826 <free+0x19>
 852:	8b 45 fc             	mov    -0x4(%ebp),%eax
 855:	8b 00                	mov    (%eax),%eax
 857:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 85a:	76 ca                	jbe    826 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 85c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85f:	8b 40 04             	mov    0x4(%eax),%eax
 862:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 869:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86c:	01 c2                	add    %eax,%edx
 86e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 871:	8b 00                	mov    (%eax),%eax
 873:	39 c2                	cmp    %eax,%edx
 875:	75 24                	jne    89b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 877:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87a:	8b 50 04             	mov    0x4(%eax),%edx
 87d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 880:	8b 00                	mov    (%eax),%eax
 882:	8b 40 04             	mov    0x4(%eax),%eax
 885:	01 c2                	add    %eax,%edx
 887:	8b 45 f8             	mov    -0x8(%ebp),%eax
 88a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 88d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 890:	8b 00                	mov    (%eax),%eax
 892:	8b 10                	mov    (%eax),%edx
 894:	8b 45 f8             	mov    -0x8(%ebp),%eax
 897:	89 10                	mov    %edx,(%eax)
 899:	eb 0a                	jmp    8a5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 89b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89e:	8b 10                	mov    (%eax),%edx
 8a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a8:	8b 40 04             	mov    0x4(%eax),%eax
 8ab:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b5:	01 d0                	add    %edx,%eax
 8b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ba:	75 20                	jne    8dc <free+0xcf>
    p->s.size += bp->s.size;
 8bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8bf:	8b 50 04             	mov    0x4(%eax),%edx
 8c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c5:	8b 40 04             	mov    0x4(%eax),%eax
 8c8:	01 c2                	add    %eax,%edx
 8ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d3:	8b 10                	mov    (%eax),%edx
 8d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d8:	89 10                	mov    %edx,(%eax)
 8da:	eb 08                	jmp    8e4 <free+0xd7>
  } else
    p->s.ptr = bp;
 8dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8df:	8b 55 f8             	mov    -0x8(%ebp),%edx
 8e2:	89 10                	mov    %edx,(%eax)
  freep = p;
 8e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e7:	a3 d0 0c 00 00       	mov    %eax,0xcd0
}
 8ec:	c9                   	leave  
 8ed:	c3                   	ret    

000008ee <morecore>:

static Header*
morecore(uint nu)
{
 8ee:	55                   	push   %ebp
 8ef:	89 e5                	mov    %esp,%ebp
 8f1:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8f4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8fb:	77 07                	ja     904 <morecore+0x16>
    nu = 4096;
 8fd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 904:	8b 45 08             	mov    0x8(%ebp),%eax
 907:	c1 e0 03             	shl    $0x3,%eax
 90a:	89 04 24             	mov    %eax,(%esp)
 90d:	e8 91 fb ff ff       	call   4a3 <sbrk>
 912:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 915:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 919:	75 07                	jne    922 <morecore+0x34>
    return 0;
 91b:	b8 00 00 00 00       	mov    $0x0,%eax
 920:	eb 22                	jmp    944 <morecore+0x56>
  hp = (Header*)p;
 922:	8b 45 f4             	mov    -0xc(%ebp),%eax
 925:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 928:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92b:	8b 55 08             	mov    0x8(%ebp),%edx
 92e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 931:	8b 45 f0             	mov    -0x10(%ebp),%eax
 934:	83 c0 08             	add    $0x8,%eax
 937:	89 04 24             	mov    %eax,(%esp)
 93a:	e8 ce fe ff ff       	call   80d <free>
  return freep;
 93f:	a1 d0 0c 00 00       	mov    0xcd0,%eax
}
 944:	c9                   	leave  
 945:	c3                   	ret    

00000946 <malloc>:

void*
malloc(uint nbytes)
{
 946:	55                   	push   %ebp
 947:	89 e5                	mov    %esp,%ebp
 949:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 94c:	8b 45 08             	mov    0x8(%ebp),%eax
 94f:	83 c0 07             	add    $0x7,%eax
 952:	c1 e8 03             	shr    $0x3,%eax
 955:	83 c0 01             	add    $0x1,%eax
 958:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 95b:	a1 d0 0c 00 00       	mov    0xcd0,%eax
 960:	89 45 f0             	mov    %eax,-0x10(%ebp)
 963:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 967:	75 23                	jne    98c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 969:	c7 45 f0 c8 0c 00 00 	movl   $0xcc8,-0x10(%ebp)
 970:	8b 45 f0             	mov    -0x10(%ebp),%eax
 973:	a3 d0 0c 00 00       	mov    %eax,0xcd0
 978:	a1 d0 0c 00 00       	mov    0xcd0,%eax
 97d:	a3 c8 0c 00 00       	mov    %eax,0xcc8
    base.s.size = 0;
 982:	c7 05 cc 0c 00 00 00 	movl   $0x0,0xccc
 989:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 98f:	8b 00                	mov    (%eax),%eax
 991:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 994:	8b 45 f4             	mov    -0xc(%ebp),%eax
 997:	8b 40 04             	mov    0x4(%eax),%eax
 99a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 99d:	72 4d                	jb     9ec <malloc+0xa6>
      if(p->s.size == nunits)
 99f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a2:	8b 40 04             	mov    0x4(%eax),%eax
 9a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9a8:	75 0c                	jne    9b6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 9aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ad:	8b 10                	mov    (%eax),%edx
 9af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9b2:	89 10                	mov    %edx,(%eax)
 9b4:	eb 26                	jmp    9dc <malloc+0x96>
      else {
        p->s.size -= nunits;
 9b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b9:	8b 40 04             	mov    0x4(%eax),%eax
 9bc:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9bf:	89 c2                	mov    %eax,%edx
 9c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ca:	8b 40 04             	mov    0x4(%eax),%eax
 9cd:	c1 e0 03             	shl    $0x3,%eax
 9d0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 9d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9d9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9df:	a3 d0 0c 00 00       	mov    %eax,0xcd0
      return (void*)(p + 1);
 9e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e7:	83 c0 08             	add    $0x8,%eax
 9ea:	eb 38                	jmp    a24 <malloc+0xde>
    }
    if(p == freep)
 9ec:	a1 d0 0c 00 00       	mov    0xcd0,%eax
 9f1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9f4:	75 1b                	jne    a11 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 9f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9f9:	89 04 24             	mov    %eax,(%esp)
 9fc:	e8 ed fe ff ff       	call   8ee <morecore>
 a01:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a08:	75 07                	jne    a11 <malloc+0xcb>
        return 0;
 a0a:	b8 00 00 00 00       	mov    $0x0,%eax
 a0f:	eb 13                	jmp    a24 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a14:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1a:	8b 00                	mov    (%eax),%eax
 a1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a1f:	e9 70 ff ff ff       	jmp    994 <malloc+0x4e>
}
 a24:	c9                   	leave  
 a25:	c3                   	ret    
