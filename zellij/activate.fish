# Fish activation script for zellij-tmux-shim
# Translates Claude Code's tmux calls to Zellij equivalents
# Source: https://github.com/stanislc/zellij-claude-teams

# Guard: only activate inside Zellij
if not set -q ZELLIJ
    echo "zellij-tmux-shim: not inside zellij, skipping activation" >&2
    return 1
end

# Guard: don't double-activate
if set -q ZELLIJ_TMUX_SHIM_ACTIVE
    return 0
end

# XDG-compliant install directory
set -gx ZELLIJ_TMUX_SHIM_DIR "$HOME/.local/share/zellij-tmux-shim"

# Runtime state directory, scoped by session name
set -l runtime_base (set -q TMPDIR; and echo $TMPDIR; or echo /tmp)
set -l shim_root "$runtime_base/zellij-tmux-shim-"(id -u)
set -l session_name (set -q ZELLIJ_SESSION_NAME; and echo $ZELLIJ_SESSION_NAME; or echo default)
set -gx ZELLIJ_TMUX_SHIM_STATE "$shim_root/$session_name"

# Save real tmux path before we shadow it
set -gx ZELLIJ_TMUX_SHIM_REAL_TMUX (command -v tmux 2>/dev/null; or echo "")

# Save original PATH for deactivation
set -gx ZELLIJ_TMUX_SHIM_ORIG_PATH $PATH

# Prepend shim bin to PATH so our tmux shadows the real one
fish_add_path --prepend "$ZELLIJ_TMUX_SHIM_DIR/bin"

# Set fake tmux env vars so Claude Code thinks it's inside tmux
set -gx TMUX "zellij-shim:/tmp/zellij-shim,$fish_pid,0"
set -gx TMUX_PANE "%0"

# Initialize state directory with secure permissions
if test -L "$shim_root"
    echo "zellij-tmux-shim: ERROR: state root is a symlink, refusing to activate" >&2
    return 1
end

mkdir -p "$shim_root"
chmod 700 "$shim_root"

set -l owner (stat -f '%u' "$shim_root" 2>/dev/null)
if test "$owner" != (id -u)
    echo "zellij-tmux-shim: ERROR: state root not owned by current user" >&2
    return 1
end

mkdir -p "$ZELLIJ_TMUX_SHIM_STATE"

# Initialize next_id counter
if not test -f "$ZELLIJ_TMUX_SHIM_STATE/next_id"
    echo "1" > "$ZELLIJ_TMUX_SHIM_STATE/next_id"
end

# Initialize sessions file
if not test -f "$ZELLIJ_TMUX_SHIM_STATE/sessions"
    touch "$ZELLIJ_TMUX_SHIM_STATE/sessions"
end

# Sweep stale state from prior crashed sessions
for pidfile in $ZELLIJ_TMUX_SHIM_STATE/*.pid
    test -f "$pidfile"; or continue
    set -l pid (cat "$pidfile" 2>/dev/null)
    if test -n "$pid"; and not kill -0 $pid 2>/dev/null
        set -l key (basename "$pidfile" .pid)
        rm -f "$ZELLIJ_TMUX_SHIM_STATE/$key.pid" \
              "$ZELLIJ_TMUX_SHIM_STATE/$key.zellij_id" \
              "$ZELLIJ_TMUX_SHIM_STATE/$key.fifo" \
              "$ZELLIJ_TMUX_SHIM_STATE/$key.ready" \
              "$ZELLIJ_TMUX_SHIM_STATE/$key.cmd" \
              "$ZELLIJ_TMUX_SHIM_STATE/$key.named" \
              "$ZELLIJ_TMUX_SHIM_STATE/$key.group"
    end
end

# Clean up orphaned .zellij_id files
for idfile in $ZELLIJ_TMUX_SHIM_STATE/*.zellij_id
    test -f "$idfile"; or continue
    set -l key (basename "$idfile" .zellij_id)
    test -f "$ZELLIJ_TMUX_SHIM_STATE/$key.pid"; or rm -f "$idfile"
end

# Remove stale env snapshot and lock from prior sessions
rm -f "$ZELLIJ_TMUX_SHIM_STATE/parent.env"
rm -rf "$ZELLIJ_TMUX_SHIM_STATE/next_id.lock"

set -gx ZELLIJ_TMUX_SHIM_ACTIVE 1
