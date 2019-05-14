#define MH_OBJECT 0x1      /* relocatable object file */
#define MH_EXECUTE 0x2     /* demand paged executable file */
#define MH_FVMLIB 0x3      /* fixed VM shared library file */
#define MH_CORE 0x4        /* core file */
#define MH_PRELOAD 0x5     /* preloaded executable file */
#define MH_DYLIB 0x6       /* dynamically bound shared library */
#define MH_DYLINKER 0x7    /* dynamic link editor */
#define MH_BUNDLE 0x8      /* dynamically bound bundle file */
#define MH_DYLIB_STUB 0x9  /* shared library stub for static */
                           /*  linking only, no section contents */
#define MH_DSYM 0xa        /* companion file with only debug */
                           /*  sections */
#define MH_KEXT_BUNDLE 0xb /* x86_64 kexts */

/**
 * MH_OBJECT
 * 目标文件（.o）
 * 静态库文件(.a），静态库其实就是N个.o合并在一起
 *
 * MH_DYLIB
 * dylib
 * .framework/xx
 *
 * MH_DYLINKER：动态链接编辑器
 * /usr/lib/dyld
 *
 * MH_DSYM：存储着二进制文件符号信息的文件
 * .dSYM/Contents/Resources/DWARF/xx（常用于分析APP的崩溃信息）
 */