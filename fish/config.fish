if status is-interactive
    # Abbreviations - 输入后自动展开为完整命令，历史记录更清晰
    abbr --add cat 'bat'
    abbr --add cls clear
    abbr --add gg lazygit
    abbr --add ls 'eza --icons'
    abbr --add l 'eza --icons -la'
    abbr --add ll 'eza --icons -l'
    abbr --add glog 'git lg'

    # Git abbreviations - 覆盖 plugin-git，与 zsh oh-my-zsh 保持一致
    abbr --add gcm 'git checkout (__git.default_branch)'
    abbr --add gcmsg 'git commit -m'
    abbr --add ggf 'git push --force origin (__git.current_branch)'
    abbr --add gpsup 'git push --set-upstream origin (__git.current_branch)'
    abbr --add php_docker 'docker exec -it php-nginx-fpm bash'
    abbr --add python python3
    abbr --add yolo 'claude --dangerously-skip-permissions'

    # fzf.fish - 禁用冲突快捷键，仅保留 Ctrl+R 搜索历史
    fzf_configure_bindings --directory= --git_log= --git_status= --variables=

    # 导出命令耗时供 Starship 自定义模块读取
    function __export_cmd_duration --on-event fish_postexec
        set -gx STARSHIP_CMD_DURATION_MS $CMD_DURATION
    end

    # Starship prompt
    starship init fish | source

    # zoxide
    zoxide init fish | source
end

# fnm
fnm env --use-on-cd | source

# Environment variables (set before PATH entries that depend on them)
set -gx BUN_INSTALL $HOME/.bun
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx LDFLAGS -L/opt/homebrew/opt/ruby/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/ruby/include
set -gx GOOGLE_CLOUD_PROJECT modified-legacy-464108-h9
set -gx GOOGLE_APPLICATION_CREDENTIALS $HOME/.claude-vertex/tencent-gcp-sg-imur-7d8fb472be16.json

# PATH
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/development/flutter/bin
fish_add_path $HOME/Library/Python/3.9/bin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path $ANDROID_HOME/platform-tools
