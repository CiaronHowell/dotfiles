function ll --wraps=ls --wraps='exa --long --git --icons --classify --header --no-permissions' --description 'alias ll exa --long --git --icons --classify --header --no-permissions'
  exa --long --git --icons --classify --header --no-permissions $argv; 
end
