# Disable greeting
set -g fish_greeting ""
set -gx PKG_CONFIG_PATH /usr/local/lib/pkgconfig $PKG_CONFIG_PATH

# Paths
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH "$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH"
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.npm-global/bin $PATH
set -gx GOPATH $HOME/.local/go
set -gx PATH $GOPATH/bin $PATH
set -U fish_user_paths $fish_user_paths $HOME/.Android/Sdk/emulator $HOME/.Android/Sdk/tools $HOME/.Android/Sdk/tools/bin $HOME/.Android/Sdk/platform-tools
set -gx PATH $fish_user_paths $PATH
set -Ux ANDROID_HOME $HOME/.Android/Sdk
set -Ux PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools
set -gx PATH $PATH $HOME/.Android/cmdline-tools/latest/bin/
set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk
set -gx PATH $JAVA_HOME/bin $PATH

fish_vi_key_bindings

# alias 
alias ls="eza -hg --icons --group-directories-first"
alias la="eza -hg --icons --group-directories-first -A"
alias ll="eza -hg --icons --group-directories-first -l"
alias lla="eza -hg --icons --group-directories-first -l -A"
alias g="git"
alias r=" cargo build && clear && cargo run"
alias i="doas xbps-install -S"
alias s="doas xbps-query -Rs"
alias d="doas xbps-remove  -RF"
alias u="doas xbps-install -u xbps && doas xbps-install -Syu"

# Prompt
function fish_prompt
    echo -n ' '(prompt_pwd) ' '
end

function fish_mode_prompt
end

walrs -r -q -S -W
