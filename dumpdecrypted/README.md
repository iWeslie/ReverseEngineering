# Usage:

iPod:~ root# DYLD_INSERT_LIBRARIES=dumpdecrypted.dylib /var/mobile/Applications/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/Scan.app/Scan
mach-o decryption dumper

copy dumpdecrypted.dylib to /var/root
```bash
/var/root root# DYLD_INSERT_LIBRARIES=dumpdecrypted.dylib <exec-path(ps -A | grep ...)>
```