function gdog --wraps='git log --all --decorate --oneline --graph' --description 'alias gdog git log --all --decorate --oneline --graph'
  git log --all --decorate --oneline --graph $argv; 
end
