if status is-interactive
    # Commands to run in interactive sessions can go here
end

function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    set -l bg_color B4BEFE # catppuccin lavender
    set -l text_color 11111B # catppuccin crust

    set_color $bg_color; echo 
    set_color -b $bg_color $text_color ; starship module time
    set_color -b normal $bg_color; echo 
    set_color normal
end

set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim

starship init fish | source
enable_transience

# source "~/.config/fish/themes/{{theme}}.theme"
fish_config theme choose {{theme}}
