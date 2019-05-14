$ file <mach-o-file>
查看Mach-O的文件类型

otool：查看Mach-O特定部分和段的内容

lipo：常用于多架构Mach-O文件的处理
查看架构信息：lipo  -info  文件路径
导出某种特定架构：lipo  文件路径  -thin  架构类型  -output  输出文件路径
合并多种架构：lipo  文件路径1  文件路径2  -output  输出文件路径
