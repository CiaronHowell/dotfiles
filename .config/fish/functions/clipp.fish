function clipp --wraps='pwd | pbcopy' --description 'alias clipp pwd | pbcopy'
  pwd | pbcopy $argv; 
end
