# Ghosstty - Ghostty 终端配置项目

## 项目目的

本项目用于管理和维护 Ghostty 终端模拟器的配置，借助 Claude 辅助完成配置调优。

## 环境信息

- **终端**: Ghostty 1.3.1 (stable)
- **多路复用**: Zellij 0.44.1
- **平台**: macOS (Darwin, Apple Silicon)
- **Shell**: Fish (`/opt/homebrew/bin/fish`)
- **提示符**: [Starship](https://starship.rs/)
- **历史**: 从 zsh 迁移至 fish

## 配置文件位置

- Ghostty 配置: `~/.config/ghostty/config`
- Zellij 配置: `~/.config/zellij/config.kdl`
- Zellij tmux shim: `~/.local/share/zellij-tmux-shim/`（含 Fish 激活脚本 `activate.fish`）
- Fish 配置: `~/.config/fish/config.fish`
- Starship 配置: `~/.config/starship.toml`

## 工作流程

- 修改 Ghostty 配置时，目标文件为 `~/.config/ghostty/config`
- Ghostty 配置采用 key-value 格式，每行一个配置项
- 可通过 `ghostty +show-config` 查看当前生效配置
- 可通过 `ghostty +list-themes` 查看可用主题
- 可通过 `ghostty +list-fonts` 查看可用字体
- Zellij 配置采用 KDL 格式，修改位于 `~/.config/zellij/config.kdl`
- Fish 相关配置修改位于 `~/.config/fish/`
- Starship 相关配置修改位于 `~/.config/starship.toml`

## 注意事项

- 用户已安装 fnm (Fast Node Manager)，在 fish 中通过 `fnm env --use-on-cd | source` 加载
- 用户此前使用 zsh，对 zsh 的配置方式有经验，解释 fish 差异时可对比 zsh
- Zellij 中运行 Claude Code 时，通过 tmux shim（zellij-claude-teams）实现 Agent Teams 自动分屏
- Fish 启动时如果检测到 `$ZELLIJ` 环境变量，会自动激活 tmux shim
