
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 24             	sub    $0x24,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	8b 45 08             	mov    0x8(%ebp),%eax
   a:	89 04 24             	mov    %eax,(%esp)
   d:	e8 dd 03 00 00       	call   3ef <strlen>
  12:	8b 55 08             	mov    0x8(%ebp),%edx
  15:	01 d0                	add    %edx,%eax
  17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1a:	eb 04                	jmp    20 <fmtname+0x20>
  1c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  23:	3b 45 08             	cmp    0x8(%ebp),%eax
  26:	72 0a                	jb     32 <fmtname+0x32>
  28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2b:	0f b6 00             	movzbl (%eax),%eax
  2e:	3c 2f                	cmp    $0x2f,%al
  30:	75 ea                	jne    1c <fmtname+0x1c>
    ;
  p++;
  32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  39:	89 04 24             	mov    %eax,(%esp)
  3c:	e8 ae 03 00 00       	call   3ef <strlen>
  41:	83 f8 0d             	cmp    $0xd,%eax
  44:	76 05                	jbe    4b <fmtname+0x4b>
    return p;
  46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  49:	eb 5f                	jmp    aa <fmtname+0xaa>
  memmove(buf, p, strlen(p));
  4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 99 03 00 00       	call   3ef <strlen>
  56:	89 44 24 08          	mov    %eax,0x8(%esp)
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	89 44 24 04          	mov    %eax,0x4(%esp)
  61:	c7 04 24 ec 0e 00 00 	movl   $0xeec,(%esp)
  68:	e8 11 05 00 00       	call   57e <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  70:	89 04 24             	mov    %eax,(%esp)
  73:	e8 77 03 00 00       	call   3ef <strlen>
  78:	ba 0e 00 00 00       	mov    $0xe,%edx
  7d:	89 d3                	mov    %edx,%ebx
  7f:	29 c3                	sub    %eax,%ebx
  81:	8b 45 f4             	mov    -0xc(%ebp),%eax
  84:	89 04 24             	mov    %eax,(%esp)
  87:	e8 63 03 00 00       	call   3ef <strlen>
  8c:	05 ec 0e 00 00       	add    $0xeec,%eax
  91:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  95:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  9c:	00 
  9d:	89 04 24             	mov    %eax,(%esp)
  a0:	e8 71 03 00 00       	call   416 <memset>
  return buf;
  a5:	b8 ec 0e 00 00       	mov    $0xeec,%eax
}
  aa:	83 c4 24             	add    $0x24,%esp
  ad:	5b                   	pop    %ebx
  ae:	5d                   	pop    %ebp
  af:	c3                   	ret    

000000b0 <ls>:

void
ls(char *path)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  bc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  c3:	00 
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	89 04 24             	mov    %eax,(%esp)
  ca:	e8 34 05 00 00       	call   603 <open>
  cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d6:	79 20                	jns    f8 <ls+0x48>
    printf(2, "ls: cannot open %s\n", path);
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	89 44 24 08          	mov    %eax,0x8(%esp)
  df:	c7 44 24 04 ce 0b 00 	movl   $0xbce,0x4(%esp)
  e6:	00 
  e7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  ee:	e8 d1 06 00 00       	call   7c4 <printf>
    return;
  f3:	e9 01 02 00 00       	jmp    2f9 <ls+0x249>
  }
  
  if(fstat(fd, &st) < 0){
  f8:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 102:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 105:	89 04 24             	mov    %eax,(%esp)
 108:	e8 0e 05 00 00       	call   61b <fstat>
 10d:	85 c0                	test   %eax,%eax
 10f:	79 2b                	jns    13c <ls+0x8c>
    printf(2, "ls: cannot stat %s\n", path);
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	89 44 24 08          	mov    %eax,0x8(%esp)
 118:	c7 44 24 04 e2 0b 00 	movl   $0xbe2,0x4(%esp)
 11f:	00 
 120:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 127:	e8 98 06 00 00       	call   7c4 <printf>
    close(fd);
 12c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12f:	89 04 24             	mov    %eax,(%esp)
 132:	e8 b4 04 00 00       	call   5eb <close>
    return;
 137:	e9 bd 01 00 00       	jmp    2f9 <ls+0x249>
  }
  
  switch(st.type){
 13c:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 143:	98                   	cwtl   
 144:	83 f8 01             	cmp    $0x1,%eax
 147:	74 53                	je     19c <ls+0xec>
 149:	83 f8 02             	cmp    $0x2,%eax
 14c:	0f 85 9c 01 00 00    	jne    2ee <ls+0x23e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 152:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 158:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15e:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 165:	0f bf d8             	movswl %ax,%ebx
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	89 04 24             	mov    %eax,(%esp)
 16e:	e8 8d fe ff ff       	call   0 <fmtname>
 173:	89 7c 24 14          	mov    %edi,0x14(%esp)
 177:	89 74 24 10          	mov    %esi,0x10(%esp)
 17b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 17f:	89 44 24 08          	mov    %eax,0x8(%esp)
 183:	c7 44 24 04 f6 0b 00 	movl   $0xbf6,0x4(%esp)
 18a:	00 
 18b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 192:	e8 2d 06 00 00       	call   7c4 <printf>
    break;
 197:	e9 52 01 00 00       	jmp    2ee <ls+0x23e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	89 04 24             	mov    %eax,(%esp)
 1a2:	e8 48 02 00 00       	call   3ef <strlen>
 1a7:	83 c0 10             	add    $0x10,%eax
 1aa:	3d 00 02 00 00       	cmp    $0x200,%eax
 1af:	76 19                	jbe    1ca <ls+0x11a>
      printf(1, "ls: path too long\n");
 1b1:	c7 44 24 04 03 0c 00 	movl   $0xc03,0x4(%esp)
 1b8:	00 
 1b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c0:	e8 ff 05 00 00       	call   7c4 <printf>
      break;
 1c5:	e9 24 01 00 00       	jmp    2ee <ls+0x23e>
    }
    strcpy(buf, path);
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d1:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d7:	89 04 24             	mov    %eax,(%esp)
 1da:	e8 a1 01 00 00       	call   380 <strcpy>
    p = buf+strlen(buf);
 1df:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 02 02 00 00       	call   3ef <strlen>
 1ed:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1f3:	01 d0                	add    %edx,%eax
 1f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1fb:	8d 50 01             	lea    0x1(%eax),%edx
 1fe:	89 55 e0             	mov    %edx,-0x20(%ebp)
 201:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 204:	e9 be 00 00 00       	jmp    2c7 <ls+0x217>
      if(de.inum == 0)
 209:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 210:	66 85 c0             	test   %ax,%ax
 213:	75 05                	jne    21a <ls+0x16a>
        continue;
 215:	e9 ad 00 00 00       	jmp    2c7 <ls+0x217>
      memmove(p, de.name, DIRSIZ);
 21a:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 221:	00 
 222:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 228:	83 c0 02             	add    $0x2,%eax
 22b:	89 44 24 04          	mov    %eax,0x4(%esp)
 22f:	8b 45 e0             	mov    -0x20(%ebp),%eax
 232:	89 04 24             	mov    %eax,(%esp)
 235:	e8 44 03 00 00       	call   57e <memmove>
      p[DIRSIZ] = 0;
 23a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 23d:	83 c0 0e             	add    $0xe,%eax
 240:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 243:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 253:	89 04 24             	mov    %eax,(%esp)
 256:	e8 88 02 00 00       	call   4e3 <stat>
 25b:	85 c0                	test   %eax,%eax
 25d:	79 20                	jns    27f <ls+0x1cf>
        printf(1, "ls: cannot stat %s\n", buf);
 25f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 265:	89 44 24 08          	mov    %eax,0x8(%esp)
 269:	c7 44 24 04 e2 0b 00 	movl   $0xbe2,0x4(%esp)
 270:	00 
 271:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 278:	e8 47 05 00 00       	call   7c4 <printf>
        continue;
 27d:	eb 48                	jmp    2c7 <ls+0x217>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 27f:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 285:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 28b:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 292:	0f bf d8             	movswl %ax,%ebx
 295:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 29b:	89 04 24             	mov    %eax,(%esp)
 29e:	e8 5d fd ff ff       	call   0 <fmtname>
 2a3:	89 7c 24 14          	mov    %edi,0x14(%esp)
 2a7:	89 74 24 10          	mov    %esi,0x10(%esp)
 2ab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 2af:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b3:	c7 44 24 04 f6 0b 00 	movl   $0xbf6,0x4(%esp)
 2ba:	00 
 2bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2c2:	e8 fd 04 00 00       	call   7c4 <printf>
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2c7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 2ce:	00 
 2cf:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2dc:	89 04 24             	mov    %eax,(%esp)
 2df:	e8 f7 02 00 00       	call   5db <read>
 2e4:	83 f8 10             	cmp    $0x10,%eax
 2e7:	0f 84 1c ff ff ff    	je     209 <ls+0x159>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2ed:	90                   	nop
  }
  close(fd);
 2ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2f1:	89 04 24             	mov    %eax,(%esp)
 2f4:	e8 f2 02 00 00       	call   5eb <close>
}
 2f9:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 2ff:	5b                   	pop    %ebx
 300:	5e                   	pop    %esi
 301:	5f                   	pop    %edi
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    

00000304 <main>:

int
main(int argc, char *argv[])
{
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	83 e4 f0             	and    $0xfffffff0,%esp
 30a:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
 30d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 311:	7f 11                	jg     324 <main+0x20>
    ls(".");
 313:	c7 04 24 16 0c 00 00 	movl   $0xc16,(%esp)
 31a:	e8 91 fd ff ff       	call   b0 <ls>
    exit();
 31f:	e8 9f 02 00 00       	call   5c3 <exit>
  }
  for(i=1; i<argc; i++)
 324:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 32b:	00 
 32c:	eb 1f                	jmp    34d <main+0x49>
    ls(argv[i]);
 32e:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 339:	8b 45 0c             	mov    0xc(%ebp),%eax
 33c:	01 d0                	add    %edx,%eax
 33e:	8b 00                	mov    (%eax),%eax
 340:	89 04 24             	mov    %eax,(%esp)
 343:	e8 68 fd ff ff       	call   b0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 348:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 34d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 351:	3b 45 08             	cmp    0x8(%ebp),%eax
 354:	7c d8                	jl     32e <main+0x2a>
    ls(argv[i]);
  exit();
 356:	e8 68 02 00 00       	call   5c3 <exit>

0000035b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 35b:	55                   	push   %ebp
 35c:	89 e5                	mov    %esp,%ebp
 35e:	57                   	push   %edi
 35f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 360:	8b 4d 08             	mov    0x8(%ebp),%ecx
 363:	8b 55 10             	mov    0x10(%ebp),%edx
 366:	8b 45 0c             	mov    0xc(%ebp),%eax
 369:	89 cb                	mov    %ecx,%ebx
 36b:	89 df                	mov    %ebx,%edi
 36d:	89 d1                	mov    %edx,%ecx
 36f:	fc                   	cld    
 370:	f3 aa                	rep stos %al,%es:(%edi)
 372:	89 ca                	mov    %ecx,%edx
 374:	89 fb                	mov    %edi,%ebx
 376:	89 5d 08             	mov    %ebx,0x8(%ebp)
 379:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 37c:	5b                   	pop    %ebx
 37d:	5f                   	pop    %edi
 37e:	5d                   	pop    %ebp
 37f:	c3                   	ret    

00000380 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 386:	8b 45 08             	mov    0x8(%ebp),%eax
 389:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 38c:	90                   	nop
 38d:	8b 45 08             	mov    0x8(%ebp),%eax
 390:	8d 50 01             	lea    0x1(%eax),%edx
 393:	89 55 08             	mov    %edx,0x8(%ebp)
 396:	8b 55 0c             	mov    0xc(%ebp),%edx
 399:	8d 4a 01             	lea    0x1(%edx),%ecx
 39c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 39f:	0f b6 12             	movzbl (%edx),%edx
 3a2:	88 10                	mov    %dl,(%eax)
 3a4:	0f b6 00             	movzbl (%eax),%eax
 3a7:	84 c0                	test   %al,%al
 3a9:	75 e2                	jne    38d <strcpy+0xd>
    ;
  return os;
 3ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3ae:	c9                   	leave  
 3af:	c3                   	ret    

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3b3:	eb 08                	jmp    3bd <strcmp+0xd>
    p++, q++;
 3b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3b9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3bd:	8b 45 08             	mov    0x8(%ebp),%eax
 3c0:	0f b6 00             	movzbl (%eax),%eax
 3c3:	84 c0                	test   %al,%al
 3c5:	74 10                	je     3d7 <strcmp+0x27>
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	0f b6 10             	movzbl (%eax),%edx
 3cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d0:	0f b6 00             	movzbl (%eax),%eax
 3d3:	38 c2                	cmp    %al,%dl
 3d5:	74 de                	je     3b5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3d7:	8b 45 08             	mov    0x8(%ebp),%eax
 3da:	0f b6 00             	movzbl (%eax),%eax
 3dd:	0f b6 d0             	movzbl %al,%edx
 3e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e3:	0f b6 00             	movzbl (%eax),%eax
 3e6:	0f b6 c0             	movzbl %al,%eax
 3e9:	29 c2                	sub    %eax,%edx
 3eb:	89 d0                	mov    %edx,%eax
}
 3ed:	5d                   	pop    %ebp
 3ee:	c3                   	ret    

000003ef <strlen>:

uint
strlen(char *s)
{
 3ef:	55                   	push   %ebp
 3f0:	89 e5                	mov    %esp,%ebp
 3f2:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3fc:	eb 04                	jmp    402 <strlen+0x13>
 3fe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 402:	8b 55 fc             	mov    -0x4(%ebp),%edx
 405:	8b 45 08             	mov    0x8(%ebp),%eax
 408:	01 d0                	add    %edx,%eax
 40a:	0f b6 00             	movzbl (%eax),%eax
 40d:	84 c0                	test   %al,%al
 40f:	75 ed                	jne    3fe <strlen+0xf>
    ;
  return n;
 411:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 414:	c9                   	leave  
 415:	c3                   	ret    

00000416 <memset>:

void*
memset(void *dst, int c, uint n)
{
 416:	55                   	push   %ebp
 417:	89 e5                	mov    %esp,%ebp
 419:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 41c:	8b 45 10             	mov    0x10(%ebp),%eax
 41f:	89 44 24 08          	mov    %eax,0x8(%esp)
 423:	8b 45 0c             	mov    0xc(%ebp),%eax
 426:	89 44 24 04          	mov    %eax,0x4(%esp)
 42a:	8b 45 08             	mov    0x8(%ebp),%eax
 42d:	89 04 24             	mov    %eax,(%esp)
 430:	e8 26 ff ff ff       	call   35b <stosb>
  return dst;
 435:	8b 45 08             	mov    0x8(%ebp),%eax
}
 438:	c9                   	leave  
 439:	c3                   	ret    

0000043a <strchr>:

char*
strchr(const char *s, char c)
{
 43a:	55                   	push   %ebp
 43b:	89 e5                	mov    %esp,%ebp
 43d:	83 ec 04             	sub    $0x4,%esp
 440:	8b 45 0c             	mov    0xc(%ebp),%eax
 443:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 446:	eb 14                	jmp    45c <strchr+0x22>
    if(*s == c)
 448:	8b 45 08             	mov    0x8(%ebp),%eax
 44b:	0f b6 00             	movzbl (%eax),%eax
 44e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 451:	75 05                	jne    458 <strchr+0x1e>
      return (char*)s;
 453:	8b 45 08             	mov    0x8(%ebp),%eax
 456:	eb 13                	jmp    46b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 458:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 45c:	8b 45 08             	mov    0x8(%ebp),%eax
 45f:	0f b6 00             	movzbl (%eax),%eax
 462:	84 c0                	test   %al,%al
 464:	75 e2                	jne    448 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 466:	b8 00 00 00 00       	mov    $0x0,%eax
}
 46b:	c9                   	leave  
 46c:	c3                   	ret    

0000046d <gets>:

char*
gets(char *buf, int max)
{
 46d:	55                   	push   %ebp
 46e:	89 e5                	mov    %esp,%ebp
 470:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 473:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 47a:	eb 4c                	jmp    4c8 <gets+0x5b>
    cc = read(0, &c, 1);
 47c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 483:	00 
 484:	8d 45 ef             	lea    -0x11(%ebp),%eax
 487:	89 44 24 04          	mov    %eax,0x4(%esp)
 48b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 492:	e8 44 01 00 00       	call   5db <read>
 497:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 49a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49e:	7f 02                	jg     4a2 <gets+0x35>
      break;
 4a0:	eb 31                	jmp    4d3 <gets+0x66>
    buf[i++] = c;
 4a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a5:	8d 50 01             	lea    0x1(%eax),%edx
 4a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4ab:	89 c2                	mov    %eax,%edx
 4ad:	8b 45 08             	mov    0x8(%ebp),%eax
 4b0:	01 c2                	add    %eax,%edx
 4b2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 4b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4bc:	3c 0a                	cmp    $0xa,%al
 4be:	74 13                	je     4d3 <gets+0x66>
 4c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4c4:	3c 0d                	cmp    $0xd,%al
 4c6:	74 0b                	je     4d3 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4cb:	83 c0 01             	add    $0x1,%eax
 4ce:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4d1:	7c a9                	jl     47c <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4d6:	8b 45 08             	mov    0x8(%ebp),%eax
 4d9:	01 d0                	add    %edx,%eax
 4db:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4de:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4e1:	c9                   	leave  
 4e2:	c3                   	ret    

000004e3 <stat>:

int
stat(char *n, struct stat *st)
{
 4e3:	55                   	push   %ebp
 4e4:	89 e5                	mov    %esp,%ebp
 4e6:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4f0:	00 
 4f1:	8b 45 08             	mov    0x8(%ebp),%eax
 4f4:	89 04 24             	mov    %eax,(%esp)
 4f7:	e8 07 01 00 00       	call   603 <open>
 4fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 503:	79 07                	jns    50c <stat+0x29>
    return -1;
 505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 50a:	eb 23                	jmp    52f <stat+0x4c>
  r = fstat(fd, st);
 50c:	8b 45 0c             	mov    0xc(%ebp),%eax
 50f:	89 44 24 04          	mov    %eax,0x4(%esp)
 513:	8b 45 f4             	mov    -0xc(%ebp),%eax
 516:	89 04 24             	mov    %eax,(%esp)
 519:	e8 fd 00 00 00       	call   61b <fstat>
 51e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 521:	8b 45 f4             	mov    -0xc(%ebp),%eax
 524:	89 04 24             	mov    %eax,(%esp)
 527:	e8 bf 00 00 00       	call   5eb <close>
  return r;
 52c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 52f:	c9                   	leave  
 530:	c3                   	ret    

00000531 <atoi>:

int
atoi(const char *s)
{
 531:	55                   	push   %ebp
 532:	89 e5                	mov    %esp,%ebp
 534:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 537:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 53e:	eb 25                	jmp    565 <atoi+0x34>
    n = n*10 + *s++ - '0';
 540:	8b 55 fc             	mov    -0x4(%ebp),%edx
 543:	89 d0                	mov    %edx,%eax
 545:	c1 e0 02             	shl    $0x2,%eax
 548:	01 d0                	add    %edx,%eax
 54a:	01 c0                	add    %eax,%eax
 54c:	89 c1                	mov    %eax,%ecx
 54e:	8b 45 08             	mov    0x8(%ebp),%eax
 551:	8d 50 01             	lea    0x1(%eax),%edx
 554:	89 55 08             	mov    %edx,0x8(%ebp)
 557:	0f b6 00             	movzbl (%eax),%eax
 55a:	0f be c0             	movsbl %al,%eax
 55d:	01 c8                	add    %ecx,%eax
 55f:	83 e8 30             	sub    $0x30,%eax
 562:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 565:	8b 45 08             	mov    0x8(%ebp),%eax
 568:	0f b6 00             	movzbl (%eax),%eax
 56b:	3c 2f                	cmp    $0x2f,%al
 56d:	7e 0a                	jle    579 <atoi+0x48>
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	0f b6 00             	movzbl (%eax),%eax
 575:	3c 39                	cmp    $0x39,%al
 577:	7e c7                	jle    540 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 579:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 57c:	c9                   	leave  
 57d:	c3                   	ret    

0000057e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 57e:	55                   	push   %ebp
 57f:	89 e5                	mov    %esp,%ebp
 581:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 584:	8b 45 08             	mov    0x8(%ebp),%eax
 587:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 58a:	8b 45 0c             	mov    0xc(%ebp),%eax
 58d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 590:	eb 17                	jmp    5a9 <memmove+0x2b>
    *dst++ = *src++;
 592:	8b 45 fc             	mov    -0x4(%ebp),%eax
 595:	8d 50 01             	lea    0x1(%eax),%edx
 598:	89 55 fc             	mov    %edx,-0x4(%ebp)
 59b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 59e:	8d 4a 01             	lea    0x1(%edx),%ecx
 5a1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5a4:	0f b6 12             	movzbl (%edx),%edx
 5a7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5a9:	8b 45 10             	mov    0x10(%ebp),%eax
 5ac:	8d 50 ff             	lea    -0x1(%eax),%edx
 5af:	89 55 10             	mov    %edx,0x10(%ebp)
 5b2:	85 c0                	test   %eax,%eax
 5b4:	7f dc                	jg     592 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5b9:	c9                   	leave  
 5ba:	c3                   	ret    

000005bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5bb:	b8 01 00 00 00       	mov    $0x1,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <exit>:
SYSCALL(exit)
 5c3:	b8 02 00 00 00       	mov    $0x2,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <wait>:
SYSCALL(wait)
 5cb:	b8 03 00 00 00       	mov    $0x3,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <pipe>:
SYSCALL(pipe)
 5d3:	b8 04 00 00 00       	mov    $0x4,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <read>:
SYSCALL(read)
 5db:	b8 05 00 00 00       	mov    $0x5,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <write>:
SYSCALL(write)
 5e3:	b8 10 00 00 00       	mov    $0x10,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <close>:
SYSCALL(close)
 5eb:	b8 15 00 00 00       	mov    $0x15,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <kill>:
SYSCALL(kill)
 5f3:	b8 06 00 00 00       	mov    $0x6,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <exec>:
SYSCALL(exec)
 5fb:	b8 07 00 00 00       	mov    $0x7,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <open>:
SYSCALL(open)
 603:	b8 0f 00 00 00       	mov    $0xf,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <mknod>:
SYSCALL(mknod)
 60b:	b8 11 00 00 00       	mov    $0x11,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <unlink>:
SYSCALL(unlink)
 613:	b8 12 00 00 00       	mov    $0x12,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <fstat>:
SYSCALL(fstat)
 61b:	b8 08 00 00 00       	mov    $0x8,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <link>:
SYSCALL(link)
 623:	b8 13 00 00 00       	mov    $0x13,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <mkdir>:
SYSCALL(mkdir)
 62b:	b8 14 00 00 00       	mov    $0x14,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <chdir>:
SYSCALL(chdir)
 633:	b8 09 00 00 00       	mov    $0x9,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <dup>:
SYSCALL(dup)
 63b:	b8 0a 00 00 00       	mov    $0xa,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <getpid>:
SYSCALL(getpid)
 643:	b8 0b 00 00 00       	mov    $0xb,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <sbrk>:
SYSCALL(sbrk)
 64b:	b8 0c 00 00 00       	mov    $0xc,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <sleep>:
SYSCALL(sleep)
 653:	b8 0d 00 00 00       	mov    $0xd,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <uptime>:
SYSCALL(uptime)
 65b:	b8 0e 00 00 00       	mov    $0xe,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <gettime>:
SYSCALL(gettime)
 663:	b8 16 00 00 00       	mov    $0x16,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <settickets>:
SYSCALL(settickets)
 66b:	b8 17 00 00 00       	mov    $0x17,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 673:	55                   	push   %ebp
 674:	89 e5                	mov    %esp,%ebp
 676:	83 ec 18             	sub    $0x18,%esp
 679:	8b 45 0c             	mov    0xc(%ebp),%eax
 67c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 67f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 686:	00 
 687:	8d 45 f4             	lea    -0xc(%ebp),%eax
 68a:	89 44 24 04          	mov    %eax,0x4(%esp)
 68e:	8b 45 08             	mov    0x8(%ebp),%eax
 691:	89 04 24             	mov    %eax,(%esp)
 694:	e8 4a ff ff ff       	call   5e3 <write>
}
 699:	c9                   	leave  
 69a:	c3                   	ret    

0000069b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 69b:	55                   	push   %ebp
 69c:	89 e5                	mov    %esp,%ebp
 69e:	56                   	push   %esi
 69f:	53                   	push   %ebx
 6a0:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6aa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6ae:	74 17                	je     6c7 <printint+0x2c>
 6b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6b4:	79 11                	jns    6c7 <printint+0x2c>
    neg = 1;
 6b6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 6c0:	f7 d8                	neg    %eax
 6c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6c5:	eb 06                	jmp    6cd <printint+0x32>
  } else {
    x = xx;
 6c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 6ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6d4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6d7:	8d 41 01             	lea    0x1(%ecx),%eax
 6da:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6dd:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6e3:	ba 00 00 00 00       	mov    $0x0,%edx
 6e8:	f7 f3                	div    %ebx
 6ea:	89 d0                	mov    %edx,%eax
 6ec:	0f b6 80 d8 0e 00 00 	movzbl 0xed8(%eax),%eax
 6f3:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6f7:	8b 75 10             	mov    0x10(%ebp),%esi
 6fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6fd:	ba 00 00 00 00       	mov    $0x0,%edx
 702:	f7 f6                	div    %esi
 704:	89 45 ec             	mov    %eax,-0x14(%ebp)
 707:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 70b:	75 c7                	jne    6d4 <printint+0x39>
  if(neg)
 70d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 711:	74 10                	je     723 <printint+0x88>
    buf[i++] = '-';
 713:	8b 45 f4             	mov    -0xc(%ebp),%eax
 716:	8d 50 01             	lea    0x1(%eax),%edx
 719:	89 55 f4             	mov    %edx,-0xc(%ebp)
 71c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 721:	eb 1f                	jmp    742 <printint+0xa7>
 723:	eb 1d                	jmp    742 <printint+0xa7>
    putc(fd, buf[i]);
 725:	8d 55 dc             	lea    -0x24(%ebp),%edx
 728:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72b:	01 d0                	add    %edx,%eax
 72d:	0f b6 00             	movzbl (%eax),%eax
 730:	0f be c0             	movsbl %al,%eax
 733:	89 44 24 04          	mov    %eax,0x4(%esp)
 737:	8b 45 08             	mov    0x8(%ebp),%eax
 73a:	89 04 24             	mov    %eax,(%esp)
 73d:	e8 31 ff ff ff       	call   673 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 742:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 746:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 74a:	79 d9                	jns    725 <printint+0x8a>
    putc(fd, buf[i]);
}
 74c:	83 c4 30             	add    $0x30,%esp
 74f:	5b                   	pop    %ebx
 750:	5e                   	pop    %esi
 751:	5d                   	pop    %ebp
 752:	c3                   	ret    

00000753 <printlong>:

static void
printlong(int fd, unsigned long long xx, int base, int sgn)
{
 753:	55                   	push   %ebp
 754:	89 e5                	mov    %esp,%ebp
 756:	83 ec 38             	sub    $0x38,%esp
 759:	8b 45 0c             	mov    0xc(%ebp),%eax
 75c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 75f:	8b 45 10             	mov    0x10(%ebp),%eax
 762:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    // Force hexadecimal
    uint upper, lower;
    upper = xx >> 32;
 765:	8b 45 e0             	mov    -0x20(%ebp),%eax
 768:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 76b:	89 d0                	mov    %edx,%eax
 76d:	31 d2                	xor    %edx,%edx
 76f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lower = xx & 0xffffffff;
 772:	8b 45 e0             	mov    -0x20(%ebp),%eax
 775:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(upper) printint(fd, upper, 16, 0);
 778:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 77c:	74 22                	je     7a0 <printlong+0x4d>
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 788:	00 
 789:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 790:	00 
 791:	89 44 24 04          	mov    %eax,0x4(%esp)
 795:	8b 45 08             	mov    0x8(%ebp),%eax
 798:	89 04 24             	mov    %eax,(%esp)
 79b:	e8 fb fe ff ff       	call   69b <printint>
    printint(fd, lower, 16, 0);
 7a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 7aa:	00 
 7ab:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 7b2:	00 
 7b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b7:	8b 45 08             	mov    0x8(%ebp),%eax
 7ba:	89 04 24             	mov    %eax,(%esp)
 7bd:	e8 d9 fe ff ff       	call   69b <printint>
}
 7c2:	c9                   	leave  
 7c3:	c3                   	ret    

000007c4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
// bdg 10/05/2015: Add %l
void
printf(int fd, char *fmt, ...)
{
 7c4:	55                   	push   %ebp
 7c5:	89 e5                	mov    %esp,%ebp
 7c7:	83 ec 48             	sub    $0x48,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 7ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7d1:	8d 45 0c             	lea    0xc(%ebp),%eax
 7d4:	83 c0 04             	add    $0x4,%eax
 7d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 7da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7e1:	e9 ba 01 00 00       	jmp    9a0 <printf+0x1dc>
    c = fmt[i] & 0xff;
 7e6:	8b 55 0c             	mov    0xc(%ebp),%edx
 7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ec:	01 d0                	add    %edx,%eax
 7ee:	0f b6 00             	movzbl (%eax),%eax
 7f1:	0f be c0             	movsbl %al,%eax
 7f4:	25 ff 00 00 00       	and    $0xff,%eax
 7f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 800:	75 2c                	jne    82e <printf+0x6a>
      if(c == '%'){
 802:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 806:	75 0c                	jne    814 <printf+0x50>
        state = '%';
 808:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 80f:	e9 88 01 00 00       	jmp    99c <printf+0x1d8>
      } else {
        putc(fd, c);
 814:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 817:	0f be c0             	movsbl %al,%eax
 81a:	89 44 24 04          	mov    %eax,0x4(%esp)
 81e:	8b 45 08             	mov    0x8(%ebp),%eax
 821:	89 04 24             	mov    %eax,(%esp)
 824:	e8 4a fe ff ff       	call   673 <putc>
 829:	e9 6e 01 00 00       	jmp    99c <printf+0x1d8>
      }
    } else if(state == '%'){
 82e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 832:	0f 85 64 01 00 00    	jne    99c <printf+0x1d8>
      if(c == 'd'){
 838:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 83c:	75 2d                	jne    86b <printf+0xa7>
        printint(fd, *ap, 10, 1);
 83e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 841:	8b 00                	mov    (%eax),%eax
 843:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 84a:	00 
 84b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 852:	00 
 853:	89 44 24 04          	mov    %eax,0x4(%esp)
 857:	8b 45 08             	mov    0x8(%ebp),%eax
 85a:	89 04 24             	mov    %eax,(%esp)
 85d:	e8 39 fe ff ff       	call   69b <printint>
        ap++;
 862:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 866:	e9 2a 01 00 00       	jmp    995 <printf+0x1d1>
      } else if(c == 'l') {
 86b:	83 7d e4 6c          	cmpl   $0x6c,-0x1c(%ebp)
 86f:	75 38                	jne    8a9 <printf+0xe5>
        printlong(fd, *(unsigned long long *)ap, 10, 0);
 871:	8b 45 e8             	mov    -0x18(%ebp),%eax
 874:	8b 50 04             	mov    0x4(%eax),%edx
 877:	8b 00                	mov    (%eax),%eax
 879:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
 880:	00 
 881:	c7 44 24 0c 0a 00 00 	movl   $0xa,0xc(%esp)
 888:	00 
 889:	89 44 24 04          	mov    %eax,0x4(%esp)
 88d:	89 54 24 08          	mov    %edx,0x8(%esp)
 891:	8b 45 08             	mov    0x8(%ebp),%eax
 894:	89 04 24             	mov    %eax,(%esp)
 897:	e8 b7 fe ff ff       	call   753 <printlong>
        // long longs take up 2 argument slots
        ap++;
 89c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        ap++;
 8a0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8a4:	e9 ec 00 00 00       	jmp    995 <printf+0x1d1>
      } else if(c == 'x' || c == 'p'){
 8a9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 8ad:	74 06                	je     8b5 <printf+0xf1>
 8af:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 8b3:	75 2d                	jne    8e2 <printf+0x11e>
        printint(fd, *ap, 16, 0);
 8b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8b8:	8b 00                	mov    (%eax),%eax
 8ba:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 8c1:	00 
 8c2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 8c9:	00 
 8ca:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ce:	8b 45 08             	mov    0x8(%ebp),%eax
 8d1:	89 04 24             	mov    %eax,(%esp)
 8d4:	e8 c2 fd ff ff       	call   69b <printint>
        ap++;
 8d9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8dd:	e9 b3 00 00 00       	jmp    995 <printf+0x1d1>
      } else if(c == 's'){
 8e2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 8e6:	75 45                	jne    92d <printf+0x169>
        s = (char*)*ap;
 8e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8eb:	8b 00                	mov    (%eax),%eax
 8ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 8f0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 8f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f8:	75 09                	jne    903 <printf+0x13f>
          s = "(null)";
 8fa:	c7 45 f4 18 0c 00 00 	movl   $0xc18,-0xc(%ebp)
        while(*s != 0){
 901:	eb 1e                	jmp    921 <printf+0x15d>
 903:	eb 1c                	jmp    921 <printf+0x15d>
          putc(fd, *s);
 905:	8b 45 f4             	mov    -0xc(%ebp),%eax
 908:	0f b6 00             	movzbl (%eax),%eax
 90b:	0f be c0             	movsbl %al,%eax
 90e:	89 44 24 04          	mov    %eax,0x4(%esp)
 912:	8b 45 08             	mov    0x8(%ebp),%eax
 915:	89 04 24             	mov    %eax,(%esp)
 918:	e8 56 fd ff ff       	call   673 <putc>
          s++;
 91d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 921:	8b 45 f4             	mov    -0xc(%ebp),%eax
 924:	0f b6 00             	movzbl (%eax),%eax
 927:	84 c0                	test   %al,%al
 929:	75 da                	jne    905 <printf+0x141>
 92b:	eb 68                	jmp    995 <printf+0x1d1>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 92d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 931:	75 1d                	jne    950 <printf+0x18c>
        putc(fd, *ap);
 933:	8b 45 e8             	mov    -0x18(%ebp),%eax
 936:	8b 00                	mov    (%eax),%eax
 938:	0f be c0             	movsbl %al,%eax
 93b:	89 44 24 04          	mov    %eax,0x4(%esp)
 93f:	8b 45 08             	mov    0x8(%ebp),%eax
 942:	89 04 24             	mov    %eax,(%esp)
 945:	e8 29 fd ff ff       	call   673 <putc>
        ap++;
 94a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 94e:	eb 45                	jmp    995 <printf+0x1d1>
      } else if(c == '%'){
 950:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 954:	75 17                	jne    96d <printf+0x1a9>
        putc(fd, c);
 956:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 959:	0f be c0             	movsbl %al,%eax
 95c:	89 44 24 04          	mov    %eax,0x4(%esp)
 960:	8b 45 08             	mov    0x8(%ebp),%eax
 963:	89 04 24             	mov    %eax,(%esp)
 966:	e8 08 fd ff ff       	call   673 <putc>
 96b:	eb 28                	jmp    995 <printf+0x1d1>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 96d:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 974:	00 
 975:	8b 45 08             	mov    0x8(%ebp),%eax
 978:	89 04 24             	mov    %eax,(%esp)
 97b:	e8 f3 fc ff ff       	call   673 <putc>
        putc(fd, c);
 980:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 983:	0f be c0             	movsbl %al,%eax
 986:	89 44 24 04          	mov    %eax,0x4(%esp)
 98a:	8b 45 08             	mov    0x8(%ebp),%eax
 98d:	89 04 24             	mov    %eax,(%esp)
 990:	e8 de fc ff ff       	call   673 <putc>
      }
      state = 0;
 995:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 99c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 9a0:	8b 55 0c             	mov    0xc(%ebp),%edx
 9a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a6:	01 d0                	add    %edx,%eax
 9a8:	0f b6 00             	movzbl (%eax),%eax
 9ab:	84 c0                	test   %al,%al
 9ad:	0f 85 33 fe ff ff    	jne    7e6 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 9b3:	c9                   	leave  
 9b4:	c3                   	ret    

000009b5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9b5:	55                   	push   %ebp
 9b6:	89 e5                	mov    %esp,%ebp
 9b8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9bb:	8b 45 08             	mov    0x8(%ebp),%eax
 9be:	83 e8 08             	sub    $0x8,%eax
 9c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c4:	a1 04 0f 00 00       	mov    0xf04,%eax
 9c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 9cc:	eb 24                	jmp    9f2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d1:	8b 00                	mov    (%eax),%eax
 9d3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9d6:	77 12                	ja     9ea <free+0x35>
 9d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9db:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9de:	77 24                	ja     a04 <free+0x4f>
 9e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e3:	8b 00                	mov    (%eax),%eax
 9e5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9e8:	77 1a                	ja     a04 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ed:	8b 00                	mov    (%eax),%eax
 9ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
 9f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9f5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 9f8:	76 d4                	jbe    9ce <free+0x19>
 9fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9fd:	8b 00                	mov    (%eax),%eax
 9ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a02:	76 ca                	jbe    9ce <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 a04:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a07:	8b 40 04             	mov    0x4(%eax),%eax
 a0a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a11:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a14:	01 c2                	add    %eax,%edx
 a16:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a19:	8b 00                	mov    (%eax),%eax
 a1b:	39 c2                	cmp    %eax,%edx
 a1d:	75 24                	jne    a43 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 a1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a22:	8b 50 04             	mov    0x4(%eax),%edx
 a25:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a28:	8b 00                	mov    (%eax),%eax
 a2a:	8b 40 04             	mov    0x4(%eax),%eax
 a2d:	01 c2                	add    %eax,%edx
 a2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a32:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a38:	8b 00                	mov    (%eax),%eax
 a3a:	8b 10                	mov    (%eax),%edx
 a3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a3f:	89 10                	mov    %edx,(%eax)
 a41:	eb 0a                	jmp    a4d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 a43:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a46:	8b 10                	mov    (%eax),%edx
 a48:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a4b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 a4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a50:	8b 40 04             	mov    0x4(%eax),%eax
 a53:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a5d:	01 d0                	add    %edx,%eax
 a5f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a62:	75 20                	jne    a84 <free+0xcf>
    p->s.size += bp->s.size;
 a64:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a67:	8b 50 04             	mov    0x4(%eax),%edx
 a6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a6d:	8b 40 04             	mov    0x4(%eax),%eax
 a70:	01 c2                	add    %eax,%edx
 a72:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a75:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a78:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a7b:	8b 10                	mov    (%eax),%edx
 a7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a80:	89 10                	mov    %edx,(%eax)
 a82:	eb 08                	jmp    a8c <free+0xd7>
  } else
    p->s.ptr = bp;
 a84:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a87:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a8a:	89 10                	mov    %edx,(%eax)
  freep = p;
 a8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a8f:	a3 04 0f 00 00       	mov    %eax,0xf04
}
 a94:	c9                   	leave  
 a95:	c3                   	ret    

00000a96 <morecore>:

static Header*
morecore(uint nu)
{
 a96:	55                   	push   %ebp
 a97:	89 e5                	mov    %esp,%ebp
 a99:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a9c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 aa3:	77 07                	ja     aac <morecore+0x16>
    nu = 4096;
 aa5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 aac:	8b 45 08             	mov    0x8(%ebp),%eax
 aaf:	c1 e0 03             	shl    $0x3,%eax
 ab2:	89 04 24             	mov    %eax,(%esp)
 ab5:	e8 91 fb ff ff       	call   64b <sbrk>
 aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 abd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 ac1:	75 07                	jne    aca <morecore+0x34>
    return 0;
 ac3:	b8 00 00 00 00       	mov    $0x0,%eax
 ac8:	eb 22                	jmp    aec <morecore+0x56>
  hp = (Header*)p;
 aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 ad0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ad3:	8b 55 08             	mov    0x8(%ebp),%edx
 ad6:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 adc:	83 c0 08             	add    $0x8,%eax
 adf:	89 04 24             	mov    %eax,(%esp)
 ae2:	e8 ce fe ff ff       	call   9b5 <free>
  return freep;
 ae7:	a1 04 0f 00 00       	mov    0xf04,%eax
}
 aec:	c9                   	leave  
 aed:	c3                   	ret    

00000aee <malloc>:

void*
malloc(uint nbytes)
{
 aee:	55                   	push   %ebp
 aef:	89 e5                	mov    %esp,%ebp
 af1:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af4:	8b 45 08             	mov    0x8(%ebp),%eax
 af7:	83 c0 07             	add    $0x7,%eax
 afa:	c1 e8 03             	shr    $0x3,%eax
 afd:	83 c0 01             	add    $0x1,%eax
 b00:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 b03:	a1 04 0f 00 00       	mov    0xf04,%eax
 b08:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b0b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 b0f:	75 23                	jne    b34 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 b11:	c7 45 f0 fc 0e 00 00 	movl   $0xefc,-0x10(%ebp)
 b18:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b1b:	a3 04 0f 00 00       	mov    %eax,0xf04
 b20:	a1 04 0f 00 00       	mov    0xf04,%eax
 b25:	a3 fc 0e 00 00       	mov    %eax,0xefc
    base.s.size = 0;
 b2a:	c7 05 00 0f 00 00 00 	movl   $0x0,0xf00
 b31:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b34:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b37:	8b 00                	mov    (%eax),%eax
 b39:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 b3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b3f:	8b 40 04             	mov    0x4(%eax),%eax
 b42:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b45:	72 4d                	jb     b94 <malloc+0xa6>
      if(p->s.size == nunits)
 b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4a:	8b 40 04             	mov    0x4(%eax),%eax
 b4d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 b50:	75 0c                	jne    b5e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b55:	8b 10                	mov    (%eax),%edx
 b57:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b5a:	89 10                	mov    %edx,(%eax)
 b5c:	eb 26                	jmp    b84 <malloc+0x96>
      else {
        p->s.size -= nunits;
 b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b61:	8b 40 04             	mov    0x4(%eax),%eax
 b64:	2b 45 ec             	sub    -0x14(%ebp),%eax
 b67:	89 c2                	mov    %eax,%edx
 b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b72:	8b 40 04             	mov    0x4(%eax),%eax
 b75:	c1 e0 03             	shl    $0x3,%eax
 b78:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b7e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b81:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b84:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b87:	a3 04 0f 00 00       	mov    %eax,0xf04
      return (void*)(p + 1);
 b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b8f:	83 c0 08             	add    $0x8,%eax
 b92:	eb 38                	jmp    bcc <malloc+0xde>
    }
    if(p == freep)
 b94:	a1 04 0f 00 00       	mov    0xf04,%eax
 b99:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b9c:	75 1b                	jne    bb9 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 b9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ba1:	89 04 24             	mov    %eax,(%esp)
 ba4:	e8 ed fe ff ff       	call   a96 <morecore>
 ba9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 bac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 bb0:	75 07                	jne    bb9 <malloc+0xcb>
        return 0;
 bb2:	b8 00 00 00 00       	mov    $0x0,%eax
 bb7:	eb 13                	jmp    bcc <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bc2:	8b 00                	mov    (%eax),%eax
 bc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 bc7:	e9 70 ff ff ff       	jmp    b3c <malloc+0x4e>
}
 bcc:	c9                   	leave  
 bcd:	c3                   	ret    
