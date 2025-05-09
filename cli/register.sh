#/usr/bin/env bash

_revdep_rebuild() {
	local cur prev opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	opts="add install"

	if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] || \
	   [[ ${prev} == @(-q|--quiet) ]] ; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi
}
complete -F _revdep_rebuild ./nvim.sh
