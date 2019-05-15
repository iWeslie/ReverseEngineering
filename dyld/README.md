dyld
- dynamic link editor，动态链接编辑器
- dynamic loader，动态加载器

编译dsc_extractor.cpp
clang++ -o dsc_extractor dsc_extractor.cpp

使用dsc_extractor
./dsc_extractor  动态库共享缓存文件的路径   用于存放抽取结果的文件夹

