#!/system/bin/sh
cat << '_EOF_'
CC='ccache clang --target=aarch64-linux-android28'
CXX='ccache clang++ --target=aarch64-linux-android28'
WARNFLAGS='-Wunknown-warning-option -Wno-error=int-conversion -Wno-error=implicit-int'
CPPFLAGS='-DNDEBUG -UDEBUG -D_GNU_SOURCE -D_BSD_SOURCE -D_FORTIFY_SOURCE=2'
CFLAGS='-Oz -g -fomit-frame-pointer -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-strict-aliasing -march=native -mcpu=native -mtune=native -munaligned-access -pipe'
CXXFLAGS="$CFLAGS -fno-rtti -fno-exceptions"
LDFLAGS='-Wl,-O1 -Wl,-z,now -Wl,-z,relro -Wl,-z,combreloc -Wl,-z,noexecstack -Wl,--hash-style=gnu -Wl,--enable-new-dtags -Wl,--eh-frame-hdr -Wl,--gc-sections -Wl,--sort-common -Wl,--sort-section=alignment -Wl,--use-android-relr-tags -Wl,--pack-dyn-relocs=android+relr'
MAKEFLAGS='-j4'
export CC CXX WARNFLAGS CPPFLAGS CFLAGS CXXFLAGS LDFLAGS MAKEFLAGS
_EOF_
