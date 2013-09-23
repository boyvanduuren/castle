# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

alias ls="ls --color"

# The next part changes the prompt based on the output
# of some git commands. From http://gist.github.com/31934 

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"
 
function parse_git_branch {
	git rev-parse --git-dir &> /dev/null
	git_status="$(git status 2> /dev/null)"
	branch_pattern="^# On branch ([^${IFS}]*)"
	remote_pattern="# Your branch is (.*) of"
	diverge_pattern="# Your branch and (.*) have diverged"

	if [[ ! ${git_status}} =~ "working directory clean" ]]; then
		state="${YELLOW}⚡"
	fi

	# add an else if or two here if you want to get more specific
	if [[ ${git_status} =~ ${remote_pattern} ]]; then
		if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
			remote="${YELLOW}↑"
		else
			remote="${YELLOW}↓"
		fi
	fi

	if [[ ${git_status} =~ ${diverge_pattern} ]]; then
		remote="${YELLOW}↕"
	fi

	if [[ ${git_status} =~ ${branch_pattern} ]]; then
		branch=${BASH_REMATCH[1]}
		echo " (${branch})${remote}${state}"
	fi
}
 
function prompt_func() {
	previous_return_value=$?;
	prompt="${TITLEBAR}${LIGHT_BLUE}[${LIGHT_RED}\w${LIGHT_GREEN}$(parse_git_branch)${LIGHT_BLUE}]${COLOR_NONE} "

	if test $previous_return_value -eq 0; then
		PS1="${prompt}➔ "
	else
		PS1="${prompt}${LIGHT_RED}➔${COLOR_NONE} "
	fi
}
 
PROMPT_COMMAND=prompt_func
