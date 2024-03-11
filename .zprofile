if [ -d "/opt/homebrew" ]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source ~/.bashrc

bindkey "[D" backward-word
bindkey "[C" forward-word
