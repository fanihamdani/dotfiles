source $HOME/.bashrc_paths
source $HOME/.bashrc_aliases

# set prompt
ORIG_PS1=$PS1
function _update_ps1() {
  export PS1="$(~/opt/bin/powerline-shell.py $? --mode patched 2> /dev/null)"
}
function _reset_prompt() {
  export PROMPT_COMMAND=""
  #export PS1=$ORIG_PS1
  if [ ! -z "$PROMPT" ]; then
    export PS1=$PROMPT
  else
    export PS1="\u: \W \$ "
  fi
}
[ "$DISABLE_POWERLINE_PROMPT" != "1" ] && \
	export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND" || \
	_reset_prompt;

# On Mac OS, the default limit on the number of simultaneous file descriptors open is too low and
# a highly parallel build (make -jX) process may exceed this limit
ulimit -S -n 1024

# default editor
export EDITOR=nano

# Colors for Dark Terminal Themes
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Colors for Light Terminal Themes
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
