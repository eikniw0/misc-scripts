# termux-native.sh
# intended for environmental inclusion to build *only* against
# native (i.e., /system) libraries.


TGT_TRIPLE='aarch64-linux-android'

unset tools
declare -gA tools=(
	['addr2line']=''
	['ar']=''
	['as']=''
	['cc']=''
	['cxx']=''
	['cpp']=''
	['cxxcpp']=''
	['ld']=''
	['libtool']=''
	['make']=''
	['makeinfo']=''
	['nm']=''
	['objcopy']=''
	['objdump']=''
	['ranlib']=''
	['readelf']=''
	['size']=''
	['strings']=''
	['strip']=''
	['warnflags']=''
	['cppflags']=''
	['cflags']=''
	['cxxflags']=''
	['asflags']=''
	['ldflags']=''
	['makeflags']=''
	)

useBinutils() {
	tools[ar]=gcc-ar
	tools[as]=as
	tools[ld]=ld.bfd
	tools[nm]=gcc-nm
	tools[ranlib]=gcc-ranlib
}

useLLVM() {
	tools[ar]=llvm-ar
	tools[as]=llvm-as
	tools[ld]=ld.lld
	tools[nm]=llvm-nm
	tools[ranlib]=llvm-ranlib
}

printTool() {
	[[ -n "${1:-}" ]] || return 1

	local toolname="${tools[$1]:-}"
	if [ -n "$toolname" ]; then
		printf "$toolname"
		return 0
	else
		return 1
	fi
}

printAllTools() {
	local index
	local -u capsVar

	for index in "${!tools[@]}" ; do
		[[ -n "${tools[$index]}" ]] || continue

		capsVar="$index"
		printf "$capsVar=\"${tools[$index]}\"\n"
	done
}

useBinutils
printAllTools
useLLVM
printAllTools
exit 0

BIN_PATH="$PREFIX/opt/binutils/cross/bin"

ADDR2LINE="${TGT_TRIPLE}-addr2line"
AR="${TGT_TRIPLE}-ar"
AS="${TGT_TRIPLE}-as"
CXXFILT="${TGT_TRIPLE}-c++filt"
ELFEDIT="${TGT_TRIPLE}-elfedit"
GPROF="${TGT_TRIPLE}-gprof"
LD="${TGT_TRIPLE}-ld"
NM="${TGT_TRIPLE}-nm"
OBJCOPY="${TGT_TRIPLE}-objcopy"
OBJDUMP="${TGT_TRIPLE}-objdump"
RANLIB="${TGT_TRIPLE}-ranlib"
READELF="${TGT_TRIPLE}-readelf"
SIZE="${TGT_TRIPLE}-size"
STRINGS="${TGT_TRIPLE}-strings"
STRIP="${TGT_TRIPLE}-strip"

# vim: ts=4 sw=4 noet ft=bash
