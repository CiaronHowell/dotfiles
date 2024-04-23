function ll --wraps=ls --wraps='eza --long --git --icons --classify --header --no-permissions' --description 'alias ll exa --long --git --icons --classify --header --no-permissions'
  ls --long --git --icons --classify --header --no-permissions $argv; 
end
