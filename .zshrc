#!/usr/bin/env zsh
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

SRC=$HOME/src
PERSONAL=$HOME/personal

# Load TEM
source ~/.em.sh

# source credentials and don't store them in git
source $PERSONAL/dotfiles/.credentials

# (s)exports
export AWS_CREDENTIAL_FILE=$HOME/aws_credentials
export EC2_HOME=$HOME/ec2-api-tools
export AWS_AUTO_SCALING_HOME=$HOME/as-api-tools
export AWS_ELB_HOME=$HOME/elb-api-tools
#export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export GOPATH=$SRC/go
export ANDROID_HOME=/Users/aleclair/Library/Android/sdk
export ANDROID_NDK=/Users/aleclair/Downloads/android-ndk-r10d
export EDITOR=nvim
export ERL_AFLAGS="-kernel shell_history enabled"
export NVM_DIR="$HOME/.nvm"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$EC2_HOME/bin:$PATH
export PATH=$AWS_AUTO_SCALING_HOME/bin:$PATH
export PATH=$AWS_ELB_HOME/bin:$PATH
export PATH=/usr/local/Cellar/rabbitmq/3.0.0/sbin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/opt/go/libexec/bin:$PATH
export PATH=/usr/local/heroku/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$PERSONAL/dotfiles/scripts:$PATH
export PATH=$HOME/Library/Python/2.7/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/Applications/Racket/bin:$PATH
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH

 #aliases
alias resource="source ~/.zshrc"
alias n="nvim"
alias nd="n ."
alias gpu="git push origin"
alias gpl="git pull origin"
alias be="bundle exec"
alias love="/Applications/love.app/Contents/MacOS/love"
alias irb="pry" #seriously
alias g="git"
alias aam="em aws"

# functions

tcssh () {
  facet=$1


  if [ -z $facet ]; then
    echo "Error: no facet given."
    echo "Usage: tcssh <group>"
    return 1
  fi

  # Make sure there isn't already a tcssh session in tmux
  if [ "" != "$(tmux list-sessions 2>1 | grep tcssh)" ]; then
    echo "Error: tcssh session already running! Please kill the session before opening a new one."
    return 1
  fi

  instances=$(aws ec2 describe-instances --region us-west-2 --output json --filters "Name=tag:Application,Values=api" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[PublicIpAddress]" | jq ".[] | .[] | .[]" | tr -d '"')

  if [ -z $instances ]
  then
    echo "No groups found"
    return 1
  fi

  let i=0
  for instance in ${(f)instances}; do
    cmd="ssh `whoami`@$instance"
    if [ $i -eq 0 ]; then
      tmux new-session -s tcssh -n tcssh -d "$cmd"
    else
      tmux split-window "$cmd"
      tmux select-layout tiled
    fi
    ((i++))
  done
  tmux set-window-option synchronize-panes on
  tmux -2 attach-session -t tcssh
}

precmd () { print -Pn "\e]2;%n@%M | %~\a" } # title bar prompt

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

source $HOME/.em.sh
em init # Loads default Profiles for each Platform found

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/.cargo/env
