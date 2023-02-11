function start-language-server --wraps='docker run -d --rm -p 8010:8010 erikvl87/languagetool' --description 'alias start-language-server docker run -d --rm -p 8010:8010 erikvl87/languagetool'
  docker run -d --rm -p 8010:8010 erikvl87/languagetool $argv; 
end
