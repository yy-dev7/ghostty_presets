# Ghosstty

macOS 下基于 Ghostty 终端的完整开发环境配置，包含 Shell、提示符、编辑器配色等一站式方案。

## 预览

```
 …/project   main +2/-1   v1.3.11   10:52
```

Pastel Powerline 风格提示符，支持 Git 状态、语言版本检测、命令耗时显示。

## 技术栈

| 组件 | 工具 | 版本 |
|------|------|------|
| 终端 | [Ghostty](https://ghostty.org/) | 1.3.1 |
| Shell | [Fish](https://fishshell.com/) | 4.5.0 |
| 提示符 | [Starship](https://starship.rs/) | 1.24.2 |
| 文件查看 | [bat](https://github.com/sharkdp/bat) | 0.26.1 |
| 文件列表 | [eza](https://github.com/eza-community/eza) | 0.23.4 |
| 目录跳转 | [zoxide](https://github.com/ajeetdsouza/zoxide) | 0.9.8 |
| 模糊搜索 | [fzf](https://github.com/junegunn/fzf) | 0.70.0 |
| Git TUI | [lazygit](https://github.com/jesseduffield/lazygit) | 0.60.0 |
| Node 管理 | [fnm](https://github.com/Schniz/fnm) | - |

### 字体

- **中文/CJK**: [Sarasa Term SC](https://github.com/be5invis/Sarasa-Gothic) (更纱黑体)
- **英文/符号**: [JetBrainsMono Nerd Font Mono](https://www.nerdfonts.com/)

## 目录结构

```
.
├── ghostty/
│   └── config              # Ghostty 终端配置
├── fish/
│   ├── config.fish         # Fish Shell 配置
│   └── fish_plugins        # Fisher 插件列表
├── starship/
│   └── starship.toml       # Starship 提示符配置
├── bat/
│   └── config              # bat 配置
└── vim/
    ├── .vimrc              # Vim 配置
    └── catppuccin_mocha.vim # Catppuccin Mocha 配色方案
```

## 安装

### 1. 安装依赖

```bash
brew install fish starship bat eza zoxide fzf lazygit fnm
brew install --cask ghostty
```

### 2. 安装字体

```bash
brew install --cask font-sarasa-gothic font-jetbrains-mono-nerd-font
```

### 3. 部署配置文件

```bash
# Ghostty
cp ghostty/config ~/.config/ghostty/config

# Fish
cp fish/config.fish ~/.config/fish/config.fish
cp fish/fish_plugins ~/.config/fish/fish_plugins

# Starship
cp starship/starship.toml ~/.config/starship.toml

# bat
mkdir -p ~/.config/bat
cp bat/config ~/.config/bat/config

# Vim
cp vim/.vimrc ~/.vimrc
mkdir -p ~/.vim/colors
cp vim/catppuccin_mocha.vim ~/.vim/colors/catppuccin_mocha.vim
```

### 4. 安装 Fish 插件

```bash
# 安装 Fisher 插件管理器
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# 根据 fish_plugins 安装所有插件
fisher update
```

## Fish 插件说明

| 插件 | 说明 |
|------|------|
| [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher) | Fish 插件管理器 |
| [jhillyerd/plugin-git](https://github.com/jhillyerd/plugin-git) | Git 缩写命令集 |
| [patrickf1/fzf.fish](https://github.com/patrickf1/fzf.fish) | fzf 集成，Ctrl+R 搜索历史 |
| [meaningful-ooo/sponge](https://github.com/meaningful-ooo/sponge) | 自动清理失败命令的历史记录 |
| [jorgebucaran/autopair.fish](https://github.com/jorgebucaran/autopair.fish) | 自动配对括号和引号 |
| [nickeb96/puffer-fish](https://github.com/nickeb96/puffer-fish) | `..` 自动展开为 `../..` |
| [gazorby/fish-abbreviation-tips](https://github.com/gazorby/fish-abbreviation-tips) | 提示可用的缩写 |
| [franciscolourenco/done](https://github.com/franciscolourenco/done) | 长时间命令结束后发送桌面通知 |

## 配置说明

### Ghostty

- **双字体方案**: Sarasa Term SC 渲染中文，JetBrainsMono Nerd Font Mono 渲染英文和图标符号（通过 `font-codepoint-map` 按 Unicode 范围映射）
- **配色**: 基于 Oil 主题自定义，背景色 `#292A3A`
- **分屏快捷键**:
  - `Cmd+D` 右侧分屏 / `Cmd+Shift+D` 下方分屏
  - `Cmd+Alt+方向键` 切换面板
  - `Cmd+Shift+=` 均分面板
  - `Cmd+W` 关闭面板

### Starship 提示符

基于 [Catppuccin Powerline](https://starship.rs/presets/catppuccin-powerline) 预设，配色切换为 [M365Princess](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/M365Princess.omp.json) Pastel Powerline 风格：

| 段 | 颜色 | 色值 |
|---|---|---|
| 目录 | 腮红 Blush | `#DA627D` |
| Git 分支/状态 | 鲑鱼 Salmon | `#FCA17D` |
| 语言版本 | 天蓝 Sky | `#86BBD8` |
| 时间 | 深青 Teal Blue | `#33658A` |
| 段内文字 | 白色 | `#FFFFFF` |

支持的语言检测: Node.js, Bun, Go, Rust, Python, C, PHP, Java, Kotlin, Haskell

命令耗时以灰色胶囊样式显示。

### bat & Vim

两者统一使用 **Catppuccin Mocha** 配色方案，确保 `bat` 查看文件和 `vi` 编辑文件时语法高亮风格一致。

### Fish Shell 缩写

```
cat  → bat          ls  → eza --icons    l   → eza --icons -la
ll   → eza --icons -l   gg  → lazygit      cls → clear
```

### Claude Code 通知

全局配置 `~/.claude/settings.json` 中添加了 hooks，当 Claude Code 任务完成或需要输入时自动发送 macOS 桌面通知：

```bash
# 依赖
brew install terminal-notifier
```

配置的两个 hook：
- **Notification**: Claude 等待用户输入/权限确认时通知
- **Stop**: Claude 完成任务时通知

通知带有提示音，使用 Claude 图标（需安装 Claude 桌面端）。

## 许可

MIT
