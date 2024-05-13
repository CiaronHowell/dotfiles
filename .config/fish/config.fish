status is-login; and pyenv init --path | source
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/opt/tcl-tk/bin
fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
if not set -q $ITERM_SESSION_ID
  source ~/.iterm2_shell_integration.(basename $SHELL)
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ciaron.howell/Documents/google-cloud-sdk/path.fish.inc' ]; . '/Users/ciaron.howell/Documents/google-cloud-sdk/path.fish.inc'; end
fish_add_path /usr/local/opt/bzip2/bin

pyenv init - | source
set -g -x LDFLAGS "$LDFLAGS -L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
set -g -x CPPFLAGS "$CPPFLAGS -I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

set -x GOPATH $HOME/go
set -x GOROOT "$(brew --prefix golang)/libexec"

set -x PATH $PATH $GOROOT/bin $GOPATH/bin
fish_add_path /usr/local/opt/libxml2/bin

set -x Z_DATA $HOME/.z.fish

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/ciaronhowell/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# pnpm
set -gx PNPM_HOME "/Users/ciaron.howell/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Created by `pipx` on 2023-02-27 18:26:35
set PATH $PATH /Users/ciaronhowell/.local/bin

zoxide init fish | source
