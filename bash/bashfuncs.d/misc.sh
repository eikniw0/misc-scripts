
. ~/etc/bashfuncs.d/msg.sh


# same as basename(1) except using shell string substitutiom,
# thus skipping a call to fork.
basename() {
    echo "${1/*\/}"
}

undef() {
    if [ -n "$(eval echo \$$1)" ]; then
        # its a var, which type wont detect properly
        unset $1
    else
        case "$(type -t $1)" in
            alias)
                unalias "$1" ;;
            function)
                unset "$1" ;;
            file|builtin)
                ;;
            *)
                _error "unknown type: '$(type -t $1)'\n" ;;
        esac
    fi
}
