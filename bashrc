# Function to get the git branch name to display in shell prompt
function parse_git_branch() { 
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/' 
} 

# shell prompt format 
export PS1='\h:\[\033[32m\]\W\[\e[01;33m\]$(parse_git_branch)\[\033[00m\]\$ '
