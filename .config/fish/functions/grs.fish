function grs --wraps='git restore --staged' --description 'alias grs git restore --staged'
  git restore --staged $argv; 
end
