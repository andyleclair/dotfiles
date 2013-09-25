# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eastwood"
SRC=$HOME/src

DISABLE_AUTO_UPDATE="true"

plugins=(git rvm brew gem github heroku node npm osx rails3)

source $ZSH/oh-my-zsh.sh

# source credentials and don't store them in git
source $SRC/dotfiles/.credentials

# (s)exports
export AWS_CREDENTIAL_FILE=$HOME/aws_credentials
export EC2_HOME=/Users/aleclair/ec2-api-tools
export AWS_AUTO_SCALING_HOME=/Users/aleclair/as-api-tools
export AWS_ELB_HOME=/Users/aleclair/elb-api-tools
export JAVA_HOME=/usr
export GOPATH=$SRC/go
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin:$EC2_HOME/bin:$AWS_AUTO_SCALING_HOME/bin:$AWS_ELB_HOME/bin:$PATH
export PATH=/usr/local/Cellar/rabbitmq/3.0.0/sbin:$HOME/.rvm/bin:$GOPATH/bin:$PATH
export PATH=/usr/local/heroku/bin:$PATH

# aliases
alias resource="source ~/.zshrc"
alias mvim="open -a MacVim"
alias sync_music="rsync -av ~/Music/iTunes/iTunes\ Media/Music/ /Volumes/LOLPRONS/Music"
alias gpu="git push origin"
alias gpl="git pull origin"
alias be="bundle exec"
alias love="/Applications/love.app/Contents/MacOS/love"
alias knife="nocorrect knife"
alias override_chef="export CHEF_URL_OVERRIDE=\"http://ec2-23-20-7-225.compute-1.amazonaws.com:4000\""
alias unoverride_chef="unset CHEF_URL_OVERRIDE"

precmd () { print -Pn "\e]2;%n@%M | %~\a" } # title bar prompt

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

rvm default
