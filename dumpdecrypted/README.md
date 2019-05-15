# Usage

copy dumpdecrypted.dylib to /var/root
```bash
/var/root root# DYLD_INSERT_LIBRARIES=dumpdecrypted.dylib <exec-path(ps -A | grep ...)>
```

