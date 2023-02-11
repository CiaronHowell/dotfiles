# Defined via `source`
function gs --wraps='git status -s' --description 'alias gs git status'
  git status -s $argv; 
end
