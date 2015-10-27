# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eastwood"
SRC=$HOME/src
PERSONAL=$HOME/personal

plugins=(git rvm brew gem github heroku node npm osx rails lein)

source $ZSH/oh-my-zsh.sh

# source credentials and don't store them in git
source $PERSONAL/dotfiles/.credentials

# source aam
source ~/.aam.sh

# (s)exports
export AWS_CREDENTIAL_FILE=$HOME/aws_credentials
export EC2_HOME=$HOME/ec2-api-tools
export AWS_AUTO_SCALING_HOME=$HOME/as-api-tools
export AWS_ELB_HOME=$HOME/elb-api-tools
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export GOPATH=$SRC/go
export ANDROID_HOME=/Users/aleclair/Library/Android/sdk
export ANDROID_NDK=/Users/aleclair/Downloads/android-ndk-r10d
export EDITOR=vim
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH
export PATH=$EC2_HOME/bin:$PATH
export PATH=$AWS_AUTO_SCALING_HOME/bin:$PATH
export PATH=$AWS_ELB_HOME/bin:$PATH
export PATH=/usr/local/Cellar/rabbitmq/3.0.0/sbin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/opt/go/libexec/bin:$PATH
export PATH=/usr/local/heroku/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$PERSONAL/dotfiles/scripts:$PATH
export PATH=$HOME/.rvm/bin:$PATH
export PATH=$HOME/Library/Python/2.7/bin:$PATH
export PATH=/Applications/Racket/bin:$PATH

# aliases
alias resource="source ~/.zshrc"
alias mvim="open -a MacVim"
alias m="mvim"
alias md="m ."
alias sync_music="rsync -av ~/Music/iTunes/iTunes\ Media/Music/ /Volumes/LOLPRONS/Music"
alias gpu="git push origin"
alias gpl="git pull origin"
alias be="bundle exec"
alias love="/Applications/love.app/Contents/MacOS/love"
alias la="ls -la"
alias csshx="nocorrect csshx"
alias frbe="foreman run bundle exec"
alias irb="pry" #seriously

# functions

tcssh () {
  group=$1
 
  if [ -z $group ]; then
    echo "Error: no group given."
    echo "Usage: tcssh <group>"
    return 1
  fi
 
  # Make sure there isn't already a tcssh session in tmux
  if [ "" != "$(tmux list-sessions 2>1 | grep tcssh)" ]; then
    echo "Error: tcssh session already running! Please kill the session before opening a new one."
    return 1
  fi

  instances=`ec2-describe-instances --filter "group-name=$1" | grep "INSTANCE" | awk '{print $4}'`

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
