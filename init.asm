
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  settickets(20); 
   9:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
  10:	e8 16 04 00 00       	call   42b <settickets>

  if(open("console", O_RDWR) < 0){
  15:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1c:	00 
  1d:	c7 04 24 91 09 00 00 	movl   $0x991,(%esp)
  24:	e8 9a 03 00 00       	call   3c3 <open>
  29:	85 c0                	test   %eax,%eax
  2b:	79 30                	jns    5d <main+0x5d>
    mknod("console", 1, 1);
  2d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  34:	00 
  35:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  3c:	00 
  3d:	c7 04 24 91 09 00 00 	movl   $0x991,(%esp)
  44:	e8 82 03 00 00       	call   3cb <mknod>
    open("console", O_RDWR);
  49:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  50:	00 
  51:	c7 04 24 91 09 00 00 	movl   $0x991,(%esp)
  58:	e8 66 03 00 00       	call   3c3 <open>
  }
  dup(0);  // stdout
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 92 03 00 00       	call   3fb <dup>
  dup(0);  // stderr
  69:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  70:	e8 86 03 00 00       	call   3fb <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  75:	c7 44 24 04 99 09 00 	movl   $0x999,0x4(%esp)
  7c:	00 
  7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  84:	e8 fb 04 00 00       	call   584 <printf>
    pid = fork();
  89:	e8 ed 02 00 00       	call   37b <fork>
  8e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  92:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  97:	79 19                	jns    b2 <main+0xb2>
      printf(1, "init: fork failed\n");
  99:	c7 44 24 04 ac 09 00 	movl   $0x9ac,0x4(%esp)
  a0:	00 
  a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a8:	e8 d7 04 00 00       	call   584 <printf>
      exit();
  ad:	e8 d1 02 00 00       	call   383 <exit>
    }
    if(pid == 0){
  b2:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  b7:	75 2d                	jne    e6 <main+0xe6>
      exec("sh", argv);
  b9:	c7 44 24 04 4c 0c 00 	movl   $0xc4c,0x4(%esp)
  c0:	00 
  c1:	c7 04 24 8e 09 00 00 	movl   $0x98e,(%esp)
  c8:	e8 ee 02 00 00       	call   3bb <exec>
      printf(1, "init: exec sh failed\n");
  cd:	c7 44 24 04 bf 09 00 	movl   $0x9bf,0x4(%esp)
  d4:	00 
  d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  dc:	e8 a3 04 00 00       	call   584 <printf>
      exit();
  e1:	e8 9d 02 00 00       	call   383 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  e6:	eb 14                	jmp    fc <main+0xfc>
      printf(1, "zombie!\n");
  e8:	c7 44 24 04 d5 09 00 	movl   $0x9d5,0x4(%esp)
  ef:	00 
  f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f7:	e8 88 04 00 00       	call   584 <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  fc:	e8 8a 02 00 00       	call   38b <wait>
 101:	89 44 24 18          	mov    %eax,0x18(%esp)
 105:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
 10a:	78 0a                	js     116 <main+0x116>
 10c:	8b 44 24 18          	mov    0x18(%esp),%eax
 110:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 114:	75 d2                	jne    e8 <main+0xe8>
      printf(1, "zombie!\n");
  }
 116:	e9 5a ff ff ff       	jmp    75 <main+0x75>

0000011b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	57                   	push   %edi
 11f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 120:	8b 4d 08             	mov    0x8(%ebp),%ecx
 123:	8b 55 10             	mov    0x10(%ebp),%edx
 126:	8b 45 0c             	mov    0xc(%ebp),%eax
 129:	89 cb                	mov    %ecx,%ebx
 12b:	89 df                	mov    %ebx,%edi
 12d:	89 d1                	mov    %edx,%ecx
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
 132:	89 ca                	mov    %ecx,%edx
 134:	89 fb                	mov    %edi,%ebx
 136:	89 5d 08             	mov    %ebx,0x8(%ebp)
 139:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 13c:	5b                   	pop    %ebx
 13d:	5f                   	pop    %edi
 13e:	5d                   	pop    %ebp
 13f:	c3                   	ret    

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 146:	8b 45 08             	mov    0x8(%ebp),%eax
 149:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 14c:	90                   	nop
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	8d 50 01             	lea    0x1(%eax),%edx
 153:	89 55 08             	mov    %edx,0x8(%ebp)
 156:	8b 55 0c             	mov    0xc(%ebp),%edx
 159:	8d 4a 01             	lea    0x1(%edx),%ecx
 15c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 15f:	0f b6 12             	movzbl (%edx),%edx
 162:	88 10                	mov    %dl,(%eax)
 164:	0f b6 00             	movzbl (%eax),%eax
 167:	84 c0                	test   %al,%al
 169:	75 e2                	jne    14d <strcpy+0xd>
    ;
  return os;
 16b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16e:	c9                   	leave  
 16f:	c3                   	ret    

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 173:	eb 08                	jmp    17d <strcmp+0xd>
    p++, q++;
 175:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 179:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	0f b6 00             	movzbl (%eax),%eax
 183:	84 c0                	test   %al,%al
 185:	74 10                	je     197 <strcmp+0x27>
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	0f b6 10             	movzbl (%eax),%edx
 18d:	8b 45 0c             	mov    0xc(%ebp),%eax
 190:	0f b6 00             	movzbl (%eax),%eax
 193:	38 c2                	cmp    %al,%dl
 195:	74 de                	je     175 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	0f b6 00             	movzbl (%eax),%eax
 19d:	0f b6 d0             	movzbl %al,%edx
 1a0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a3:	0f b6 00             	movzbl (%eax),%eax
 1a6:	0f b6 c0             	movzbl %al,%eax
 1a9:	29 c2                	sub    %eax,%edx
 1ab:	89 d0                	mov    %edx,%eax
}
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    

000001af <strlen>:

uint
strlen(char *s)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
 1b2:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1bc:	eb 04                	jmp    1c2 <strlen+0x13>
 1be:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1c5:	8b 45 08             	mov    0x8(%ebp),%eax
 1c8:	01 d0                	add    %edx,%eax
 1ca:	0f b6 00             	movzbl (%eax),%eax
 1cd:	84 c0                	test   %al,%al
 1cf:	75 ed                	jne    1be <strlen+0xf>
    ;
  return n;
 1d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d4:	c9                   	leave  
 1d5:	c3                   	ret    

000001d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d6:	55                   	push   %ebp
 1d7:	89 e5                	mov    %esp,%ebp
 1d9:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1dc:	8b 45 10             	mov    0x10(%ebp),%eax
 1df:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
 1ed:	89 04 24             	mov    %eax,(%esp)
 1f0:	e8 26 ff ff ff       	call   11b <stosb>
  return dst;
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f8:	c9                   	leave  
 1f9:	c3                   	ret    

000001fa <strchr>:

char*
strchr(const char *s, char c)
{
 1fa:	55                   	push   %ebp
 1fb:	89 e5                	mov    %esp,%ebp
 1fd:	83 ec 04             	sub    $0x4,%esp
 200:	8b 45 0c             	mov    0xc(%ebp),%eax
 203:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 206:	eb 14                	jmp    21c <strchr+0x22>
    if(*s == c)
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	0f b6 00             	movzbl (%eax),%eax
 20e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 211:	75 05                	jne    218 <strchr+0x1e>
      return (char*)s;
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	eb 13                	jmp    22b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
 21f:	0f b6 00             	movzbl (%eax),%eax
 222:	84 c0                	test   %al,%al
 224:	75 e2                	jne    208 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 226:	b8 00 00 00 00       	mov    $0x0,%eax
}
 22b:	c9                   	leave  
 22c:	c3                   	ret    

0000022d <gets>:

char*
gets(char *buf, int max)
{
 22d:	55                   	push   %ebp
 22e:	89 e5                	mov    %esp,%ebp
 230:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 233:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 23a:	eb 4c                	jmp    288 <gets+0x5b>
    cc = read(0, &c, 1);
 23c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 243:	00 
 244:	8d 45 ef             	lea    -0x11(%ebp),%eax
 247:	89 44 24 04          	mov    %eax,0x4(%esp)
 24b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 252:	e8 44 01 00 00       	call   39b <read>
 257:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 25a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 25e:	7f 02                	jg     262 <gets+0x35>
      break;
 260:	eb 31                	jmp    293 <gets+0x66>
    buf[i++] = c;
 262:	8b 45 f4             	mov    -0xc(%ebp),%eax
 265:	8d 50 01             	lea    0x1(%eax),%edx
 268:	89 55 f4             	mov    %edx,-0xc(%ebp)
 26b:	89 c2                	mov    %eax,%edx
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	01 c2                	add    %eax,%edx
 272:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 276:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 278:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27c:	3c 0a                	cmp    $0xa,%al
 27e:	74 13                	je     293 <gets+0x66>
 280:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 284:	3c 0d                	cmp    $0xd,%al
 286:	74 0b                	je     293 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 288:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28b:	83 c0 01             	add    $0x1,%eax
 28e:	3b 45 0c             	cmp    0xc(%ebp),%eax
 291:	7c a9                	jl     23c <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 293:	8b 55 f4             	mov    -0xc(%ebp),%edx
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	01 d0                	add    %edx,%eax
 29b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a1:	c9                   	leave  
 2a2:	c3                   	ret    

000002a3 <stat>:

int
stat(char *n, struct stat *st)
{
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b0:	00 
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	89 04 24             	mov    %eax,(%esp)
 2b7:	e8 07 01 00 00       	call   3c3 <open>
 2bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c3:	79 07                	jns    2cc <stat+0x29>
    return -1;
 2c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ca:	eb 23                	jmp    2ef <stat+0x4c>
  r = fstat(fd, st);
 2cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d6:	89 04 24             	mov    %eax,(%esp)
 2d9:	e8 fd 00 00 00       	call   3db <fstat>
 2de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e4:	89 04 24             	mov    %eax,(%esp)
 2e7:	e8 bf 00 00 00       	call   3ab <close>
  return r;
 2ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ef:	c9                   	leave  
 2f0:	c3                   	ret    

000002f1 <atoi>:

int
atoi(const char *s)
{
 2f1:	55                   	push   %ebp
 2f2:	89 e5                	mov    %esp,%ebp
 2f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fe:	eb 25                	jmp    325 <atoi+0x34>
    n = n*10 + *s++ - '0';
 300:	8b 55 fc             	mov    -0x4(%ebp),%edx
 303:	89 d0                	mov    %edx,%eax
 305:	c1 e0 02             	shl    $0x2,%eax
 308:	01 d0                	add    %edx,%eax
 30a:	01 c0                	add    %eax,%eax
 30c:	89 c1                	mov    %eax,%ecx
 30e:	8b 45 08             	mov    0x8(%ebp),%eax
 311:	8d 50 01             	lea    0x1(%eax),%edx
 314:	89 55 08             	mov    %edx,0x8(%ebp)
 317:	0f b6 00             	movzbl (%eax),%eax
 31a:	0f be c0             	movsbl %al,%eax
 31d:	01 c8                	add    %ecx,%eax
 31f:	83 e8 30             	sub    $0x30,%eax
 322:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 325:	8b 45 08             	mov    0x8(%ebp),%eax
 328:	0f b6 00             	movzbl (%eax),%eax
 32b:	3c 2f                	cmp    $0x2f,%al
 32d:	7e 0a                	jle    339 <atoi+0x48>
 32f:	8b 45 08             	mov    0x8(%ebp),%eax
 332:	0f b6 00             	movzbl (%eax),%eax
 335:	3c 39                	cmp    $0x39,%al
 337:	7e c7                	jle    300 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 339:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 33c:	c9                   	leave  
 33d:	c3                   	ret    

0000033e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 33e:	55                   	push   %ebp
 33f:	89 e5                	mov    %esp,%ebp
 341:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 34a:	8b 45 0c             	mov    0xc(%ebp),%eax
 34d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 350:	eb 17                	jmp    369 <memmove+0x2b>
    *dst++ = *src++;
 352:	8b 45 fc             	mov    -0x4(%ebp),%eax
 355:	8d 50 01             	lea    0x1(%eax),%edx
 358:	89 55 fc             	mov    %edx,-0x4(%ebp)
 35b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 35e:	8d 4a 01             	lea    0x1(%edx),%ecx
 361:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 364:	0f b6 12             	movzbl (%edx),%edx
 367:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 369:	8b 45 10             	mov    0x10(%ebp),%eax
 36c:	8d 50 ff             	lea    -0x1(%eax),%edx
 36f:	89 55 10             	mov    %edx,0x10(%ebp)
 372:	85 c0                	test   %eax,%eax
 374:	7f dc                	jg     352 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 376:	8b 45 08             	mov    0x8(%ebp),%eax
}
 379:	c9                   	leave  
 37a:	c3                   	ret    

0000037b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37b:	b8 01 00 00 00       	mov    $0x1,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <exit>:
SYSCALL(exit)
 383:	b8 02 00 00 00       	mov    $0x2,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <wait>:
SYSCALL(wait)
 38b:	b8 03 00 00 00       	mov    $0x3,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <pipe>:
SYSCALL(pipe)
 393:	b8 04 00 00 00       	mov    $0x4,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <read>:
SYSCALL(read)
 39b:	b8 05 00 00 00       	mov    $0x5,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <write>:
SYSCALL(write)
 3a3:	b8 10 00 00 00       	mov    $0x10,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <close>:
SYSCALL(close)
 3ab:	b8 15 00 00 00       	mov    $0x15,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <kill>:
SYSCALL(kill)
 3b3:	b8 06 00 00 00       	mov    $0x6,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <exec>:
SYSCALL(exec)
 3bb:	b8 07 00 00 00       	mov    $0x7,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <open>:
SYSCALL(open)
 3c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <mknod>:
SYSCALL(mknod)
 3cb:	b8 11 00 00 00       	mov    $0x11,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <unlink>:
SYSCALL(unlink)
 3d3:	b8 12 00 00 00       	mov    $0x12,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <fstat>:
SYSCALL(fstat)
 3db:	b8 08 00 00 00       	mov    $0x8,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <link>:
SYSCALL(link)
 3e3:	b8 13 00 00 00       	mov    $0x13,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <mkdir>:
SYSCALL(mkdir)
 3eb:	b8 14 00 00 00       	mov    $0x14,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <chdir>:
SYSCALL(chdir)
 3f3:	b8 09 00 00 00       	mov    $0x9,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <dup>:
SYSCALL(dup)
 3fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <getpid>:
SYSCALL(getpid)
 403:	b8 0b 00 00 00       	mov    $0xb,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <sbrk>:
SYSCALL(sbrk)
 40b:	b8 0c 00 00 00       	mov    $0xc,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <sleep>:
SYSCALL(sleep)
 413:	b8 0d 00 00 00       	mov    $0xd,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <uptime>:
SYSCALL(uptime)
 41b:	b8 0e 00 00 00       	mov    $0xe,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <gettime>:
SYSCALL(gettime)
 423:	b8 16 00 00 00       	mov    $0x16,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <settickets>:
SYSCALL(settickets)
 42b:	b8 17 00 00 00       	mov    $0x17,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 433:	55                   	push   %ebp
 434:	89 e5                	mov    %esp,%ebp
 436:	83 ec 18             	sub    $0x18,%esp
 439:	8b 45 0c             	mov    0xc(%ebp),%eax
 43c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 43f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 446:	00 
 447:	8d 45 f4             	lea    -0xc(%ebp),%eax
 44a:	89 44 24 04          	mov    %eax,0x4(%esp)
 44e:	8b 45 08             	mov    0x8(%ebp),%eax
 451:	89 04 24             	mov    %eax,(%esp)
 454:	e8 4a ff ff ff       	call   3a3 <write>
}
 459:	c9                   	leave  
 45a:	c3                   	ret    

0000045b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 45b:	55                   	push   %ebp
 45c:	89 e5                	mov    %esp,%ebp
 45e:	56                   	push   %esi
 45f:	53                   	push   %ebx
 460:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 463:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 46a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 46e:	74 17                	je     487 <printint+0x2c>
 470:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 474:	79 11                	jns    487 <printint+0x2c>
    neg = 1;
 476:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 47d:	8b 45 0c             	mov    0xc(%ebp),%eax
 480:	f7 d8                	neg    %eax
 482:	89 45 ec             	mov    %eax,-0x14(%ebp)
 485:	eb 06                	jmp    48d <printint+0x32>
  } else {
    x = xx;
 487:	8b 45 0c             	mov    0xc(%ebp),%eax
 48a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 48d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 494:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 497:	8d 41 01             	lea    0x1(%ecx),%eax
 49a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 49d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a3:	ba 00 00 00 00       	mov    $0x0,%edx
 4a8:	f7 f3                	div    %ebx
 4aa:	89 d0                	mov    %edx,%eax
 4ac:	0f b6 80 54 0c 00 00 	movzbl 0xc54(%eax),%eax
 4b3:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4b7:	8b 75 10             	mov    0x10(%ebp),%esi
 4ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4bd:	ba 00 00 00 00       	mov    $0x0,%edx
 4c2:	f7 f6                	div    %esi
 4c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4cb:	75 c7                	jne    494 <printint+0x39>
  if(neg)
 4cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4d1:	74 10                	je     4e3 <printint+0x88>
    buf[i++] = '-';
 4d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d6:	8d 50 01             	lea    0x1(%eax),%edx
 4d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4dc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4e1:	eb 1f                	jmp    502 <printint+0xa7>
 4e3:	eb 1d                	jmp    502 <printint+0xa7>
    putc(fd, buf[i]);
 4e5:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4eb:	01 d0                	add    %edx,%eax
 4ed:	0f b6 00             	movzbl (%eax),%eax
 4f0:	0f be c0             	movsbl %al,%eax
 4f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f7:	8b 45 08             	mov    0x8(%ebp),%eax
 4fa:	89 04 24             	mov    %eax,(%esp)
 4fd:	e8 31 ff ff ff       	call   433 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 502:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 506:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 50a:	79 d9                	jns    4e5 <printint+0x8a>
    putc(fd, buf[i]);
}
 50c:	83 c4 30             	add    $0x30,%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5d                   	pop    %ebp
 512:	c3                   	ret    

00000513 <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 513:	55                   	push   %ebp
 514:	89 e5                	mov    %esp,%ebp
 516:	83 ec 38             	sub    $0x38,%esp
 519:	8b 45 0c             	mov    0xc(%ebp),%eax
 51c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 51f:	8b 45 10             	mov    0x10(%ebp),%eax
 522:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 525:	8b 45 e0             	mov    -0x20(%ebp),%eax
 528:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 52b:	89 d0                	mov    %edx,%eax
 52d:	31 d2                	xor    %edx,%edx
 52f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 532:	8b 45 e0             	mov    -0x20(%ebp),%eax
 535:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 538:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53c:	74 22                	je     560 <printlong+0x4d>
 53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 541:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 548:	00 
 549:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 550:	00 
 551:	89 44 24 04          	mov    %eax,0x4(%esp)
 555:	8b 45 08             	mov    0x8(%ebp),%eax
 558:	89 04 24             	mov    %eax,(%esp)
 55b:	e8 fb fe ff ff       	call   45b <printint>
    printint(fd, lower, 16, 0);
 560:	8b 45 f0             	mov    -0x10(%ebp),%eax
 563:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 56a:	00 
 56b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 572:	00 
 573:	89 44 24 04          	mov    %eax,0x4(%esp)
 577:	8b 45 08             	mov    0x8(%ebp),%eax
 57a:	89 04 24             	mov    %eax,(%esp)
 57d:	e8 d9 fe ff ff       	call   45b <printint>
}
 582:	c9                   	leave  
 583:	c3                   	ret    

00000584 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 58a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 591:	8d 45 0c             	lea    0xc(%ebp),%eax
 594:	83 c0 04             	add    $0x4,%eax
 597:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 59a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5a1:	e9 ba 01 00 00       	jmp    760 <printf+0x1dc>
    c = fmt[i] & 0xff;
 5a6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ac:	01 d0                	add    %edx,%eax
 5ae:	0f b6 00             	movzbl (%eax),%eax
 5b1:	0f be c0             	movsbl %al,%eax
 5b4:	25 ff 00 00 00       	and    $0xff,%eax
 5b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c0:	75 2c                	jne    5ee <printf+0x6a>
      if(c == '%'){
 5c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5c6:	75 0c                	jne    5d4 <printf+0x50>
        state = '%';
 5c8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5cf:	e9 88 01 00 00       	jmp    75c <printf+0x1d8>
      } else {
        putc(fd, c);
 5d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d7:	0f be c0             	movsbl %al,%eax
 5da:	89 44 24 04          	mov    %eax,0x4(%esp)
 5de:	8b 45 08             	mov    0x8(%ebp),%eax
 5e1:	89 04 24             	mov    %eax,(%esp)
 5e4:	e8 4a fe ff ff       	call   433 <putc>
 5e9:	e9 6e 01 00 00       	jmp    75c <printf+0x1d8>
      }
    } else if(state == '%'){
 5ee:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5f2:	0f 85 64 01 00 00    	jne    75c <printf+0x1d8>
      if(c == 'd'){
 5f8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5fc:	75 2d                	jne    62b <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
 601:	8b 00                	mov    (%eax),%eax
 603:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 60a:	00 
 60b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 612:	00 
 613:	89 44 24 04          	mov    %eax,0x4(%esp)
 617:	8b 45 08             	mov    0x8(%ebp),%eax
 61a:	89 04 24             	mov    %eax,(%esp)
 61d:	e8 39 fe ff ff       	call   45b <printint>
        ap++;
 622:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 626:	e9 2a 01 00 00       	jmp    755 <printf+0x1d1>
      } else if(c == 'l') {
 62b:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 62f:	75 38                	jne    669 <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 631:	8b 45 e8             	mov    -0x18(%ebp),%eax
 634:	8b 50 04             	mov    0x4(%eax),%edx
 637:	8b 00                	mov    (%eax),%eax
 639:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 640:	00 
 641:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 648:	00 
 649:	89 44 24 04          	mov    %eax,0x4(%esp)
 64d:	89 54 24 08          	mov    %edx,0x8(%esp)
 651:	8b 45 08             	mov    0x8(%ebp),%eax
 654:	89 04 24             	mov    %eax,(%esp)
 657:	e8 b7 fe ff ff       	call   513 <printlong>
        // long longs take up 2 argument slots
        ap++;
 65c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 660:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 664:	e9 ec 00 00 00       	jmp    755 <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 669:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 66d:	74 06                	je     675 <printf+0xf1>
 66f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 673:	75 2d                	jne    6a2 <printf+0x11e>
        printint(fd, *ap, 16, 0);
 675:	8b 45 e8             	mov    -0x18(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 681:	00 
 682:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 689:	00 
 68a:	89 44 24 04          	mov    %eax,0x4(%esp)
 68e:	8b 45 08             	mov    0x8(%ebp),%eax
 691:	89 04 24             	mov    %eax,(%esp)
 694:	e8 c2 fd ff ff       	call   45b <printint>
        ap++;
 699:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69d:	e9 b3 00 00 00       	jmp    755 <printf+0x1d1>
      } else if(c == 's'){
 6a2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6a6:	75 45                	jne    6ed <printf+0x169>
        s = (char*)*ap;
 6a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ab:	8b 00                	mov    (%eax),%eax
 6ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6b8:	75 09                	jne    6c3 <printf+0x13f>
          s = "(null)";
 6ba:	c7 45 f4 de 09 00 00 	movl   $0x9de,-0xc(%ebp)
        while(*s != 0){
 6c1:	eb 1e                	jmp    6e1 <printf+0x15d>
 6c3:	eb 1c                	jmp    6e1 <printf+0x15d>
          putc(fd, *s);
 6c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c8:	0f b6 00             	movzbl (%eax),%eax
 6cb:	0f be c0             	movsbl %al,%eax
 6ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d2:	8b 45 08             	mov    0x8(%ebp),%eax
 6d5:	89 04 24             	mov    %eax,(%esp)
 6d8:	e8 56 fd ff ff       	call   433 <putc>
          s++;
 6dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e4:	0f b6 00             	movzbl (%eax),%eax
 6e7:	84 c0                	test   %al,%al
 6e9:	75 da                	jne    6c5 <printf+0x141>
 6eb:	eb 68                	jmp    755 <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ed:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6f1:	75 1d                	jne    710 <printf+0x18c>
        putc(fd, *ap);
 6f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6f6:	8b 00                	mov    (%eax),%eax
 6f8:	0f be c0             	movsbl %al,%eax
 6fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ff:	8b 45 08             	mov    0x8(%ebp),%eax
 702:	89 04 24             	mov    %eax,(%esp)
 705:	e8 29 fd ff ff       	call   433 <putc>
        ap++;
 70a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 70e:	eb 45                	jmp    755 <printf+0x1d1>
      } else if(c == '%'){
 710:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 714:	75 17                	jne    72d <printf+0x1a9>
        putc(fd, c);
 716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 719:	0f be c0             	movsbl %al,%eax
 71c:	89 44 24 04          	mov    %eax,0x4(%esp)
 720:	8b 45 08             	mov    0x8(%ebp),%eax
 723:	89 04 24             	mov    %eax,(%esp)
 726:	e8 08 fd ff ff       	call   433 <putc>
 72b:	eb 28                	jmp    755 <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 72d:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 734:	00 
 735:	8b 45 08             	mov    0x8(%ebp),%eax
 738:	89 04 24             	mov    %eax,(%esp)
 73b:	e8 f3 fc ff ff       	call   433 <putc>
        putc(fd, c);
 740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 743:	0f be c0             	movsbl %al,%eax
 746:	89 44 24 04          	mov    %eax,0x4(%esp)
 74a:	8b 45 08             	mov    0x8(%ebp),%eax
 74d:	89 04 24             	mov    %eax,(%esp)
 750:	e8 de fc ff ff       	call   433 <putc>
      }
      state = 0;
 755:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 75c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 760:	8b 55 0c             	mov    0xc(%ebp),%edx
 763:	8b 45 f0             	mov    -0x10(%ebp),%eax
 766:	01 d0                	add    %edx,%eax
 768:	0f b6 00             	movzbl (%eax),%eax
 76b:	84 c0                	test   %al,%al
 76d:	0f 85 33 fe ff ff    	jne    5a6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 773:	c9                   	leave  
 774:	c3                   	ret    

00000775 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 775:	55                   	push   %ebp
 776:	89 e5                	mov    %esp,%ebp
 778:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 77b:	8b 45 08             	mov    0x8(%ebp),%eax
 77e:	83 e8 08             	sub    $0x8,%eax
 781:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	a1 70 0c 00 00       	mov    0xc70,%eax
 789:	89 45 fc             	mov    %eax,-0x4(%ebp)
 78c:	eb 24                	jmp    7b2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	8b 00                	mov    (%eax),%eax
 793:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 796:	77 12                	ja     7aa <free+0x35>
 798:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 79e:	77 24                	ja     7c4 <free+0x4f>
 7a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a3:	8b 00                	mov    (%eax),%eax
 7a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a8:	77 1a                	ja     7c4 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ad:	8b 00                	mov    (%eax),%eax
 7af:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b8:	76 d4                	jbe    78e <free+0x19>
 7ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bd:	8b 00                	mov    (%eax),%eax
 7bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7c2:	76 ca                	jbe    78e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c7:	8b 40 04             	mov    0x4(%eax),%eax
 7ca:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d4:	01 c2                	add    %eax,%edx
 7d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d9:	8b 00                	mov    (%eax),%eax
 7db:	39 c2                	cmp    %eax,%edx
 7dd:	75 24                	jne    803 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e2:	8b 50 04             	mov    0x4(%eax),%edx
 7e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e8:	8b 00                	mov    (%eax),%eax
 7ea:	8b 40 04             	mov    0x4(%eax),%eax
 7ed:	01 c2                	add    %eax,%edx
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	8b 10                	mov    (%eax),%edx
 7fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ff:	89 10                	mov    %edx,(%eax)
 801:	eb 0a                	jmp    80d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 803:	8b 45 fc             	mov    -0x4(%ebp),%eax
 806:	8b 10                	mov    (%eax),%edx
 808:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 810:	8b 40 04             	mov    0x4(%eax),%eax
 813:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 81a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81d:	01 d0                	add    %edx,%eax
 81f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 822:	75 20                	jne    844 <free+0xcf>
    p->s.size += bp->s.size;
 824:	8b 45 fc             	mov    -0x4(%ebp),%eax
 827:	8b 50 04             	mov    0x4(%eax),%edx
 82a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82d:	8b 40 04             	mov    0x4(%eax),%eax
 830:	01 c2                	add    %eax,%edx
 832:	8b 45 fc             	mov    -0x4(%ebp),%eax
 835:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 838:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83b:	8b 10                	mov    (%eax),%edx
 83d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 840:	89 10                	mov    %edx,(%eax)
 842:	eb 08                	jmp    84c <free+0xd7>
  } else
    p->s.ptr = bp;
 844:	8b 45 fc             	mov    -0x4(%ebp),%eax
 847:	8b 55 f8             	mov    -0x8(%ebp),%edx
 84a:	89 10                	mov    %edx,(%eax)
  freep = p;
 84c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84f:	a3 70 0c 00 00       	mov    %eax,0xc70
}
 854:	c9                   	leave  
 855:	c3                   	ret    

00000856 <morecore>:

static Header*
morecore(uint nu)
{
 856:	55                   	push   %ebp
 857:	89 e5                	mov    %esp,%ebp
 859:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 85c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 863:	77 07                	ja     86c <morecore+0x16>
    nu = 4096;
 865:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 86c:	8b 45 08             	mov    0x8(%ebp),%eax
 86f:	c1 e0 03             	shl    $0x3,%eax
 872:	89 04 24             	mov    %eax,(%esp)
 875:	e8 91 fb ff ff       	call   40b <sbrk>
 87a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 87d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 881:	75 07                	jne    88a <morecore+0x34>
    return 0;
 883:	b8 00 00 00 00       	mov    $0x0,%eax
 888:	eb 22                	jmp    8ac <morecore+0x56>
  hp = (Header*)p;
 88a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 890:	8b 45 f0             	mov    -0x10(%ebp),%eax
 893:	8b 55 08             	mov    0x8(%ebp),%edx
 896:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 899:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89c:	83 c0 08             	add    $0x8,%eax
 89f:	89 04 24             	mov    %eax,(%esp)
 8a2:	e8 ce fe ff ff       	call   775 <free>
  return freep;
 8a7:	a1 70 0c 00 00       	mov    0xc70,%eax
}
 8ac:	c9                   	leave  
 8ad:	c3                   	ret    

000008ae <malloc>:

void*
malloc(uint nbytes)
{
 8ae:	55                   	push   %ebp
 8af:	89 e5                	mov    %esp,%ebp
 8b1:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b4:	8b 45 08             	mov    0x8(%ebp),%eax
 8b7:	83 c0 07             	add    $0x7,%eax
 8ba:	c1 e8 03             	shr    $0x3,%eax
 8bd:	83 c0 01             	add    $0x1,%eax
 8c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8c3:	a1 70 0c 00 00       	mov    0xc70,%eax
 8c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8cf:	75 23                	jne    8f4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8d1:	c7 45 f0 68 0c 00 00 	movl   $0xc68,-0x10(%ebp)
 8d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8db:	a3 70 0c 00 00       	mov    %eax,0xc70
 8e0:	a1 70 0c 00 00       	mov    0xc70,%eax
 8e5:	a3 68 0c 00 00       	mov    %eax,0xc68
    base.s.size = 0;
 8ea:	c7 05 6c 0c 00 00 00 	movl   $0x0,0xc6c
 8f1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f7:	8b 00                	mov    (%eax),%eax
 8f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ff:	8b 40 04             	mov    0x4(%eax),%eax
 902:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 905:	72 4d                	jb     954 <malloc+0xa6>
      if(p->s.size == nunits)
 907:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90a:	8b 40 04             	mov    0x4(%eax),%eax
 90d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 910:	75 0c                	jne    91e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 912:	8b 45 f4             	mov    -0xc(%ebp),%eax
 915:	8b 10                	mov    (%eax),%edx
 917:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91a:	89 10                	mov    %edx,(%eax)
 91c:	eb 26                	jmp    944 <malloc+0x96>
      else {
        p->s.size -= nunits;
 91e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 921:	8b 40 04             	mov    0x4(%eax),%eax
 924:	2b 45 ec             	sub    -0x14(%ebp),%eax
 927:	89 c2                	mov    %eax,%edx
 929:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 92f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 932:	8b 40 04             	mov    0x4(%eax),%eax
 935:	c1 e0 03             	shl    $0x3,%eax
 938:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 93b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 941:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 944:	8b 45 f0             	mov    -0x10(%ebp),%eax
 947:	a3 70 0c 00 00       	mov    %eax,0xc70
      return (void*)(p + 1);
 94c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94f:	83 c0 08             	add    $0x8,%eax
 952:	eb 38                	jmp    98c <malloc+0xde>
    }
    if(p == freep)
 954:	a1 70 0c 00 00       	mov    0xc70,%eax
 959:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 95c:	75 1b                	jne    979 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 95e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 961:	89 04 24             	mov    %eax,(%esp)
 964:	e8 ed fe ff ff       	call   856 <morecore>
 969:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 970:	75 07                	jne    979 <malloc+0xcb>
        return 0;
 972:	b8 00 00 00 00       	mov    $0x0,%eax
 977:	eb 13                	jmp    98c <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 979:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 97f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 982:	8b 00                	mov    (%eax),%eax
 984:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 987:	e9 70 ff ff ff       	jmp    8fc <malloc+0x4e>
}
 98c:	c9                   	leave  
 98d:	c3                   	ret    
