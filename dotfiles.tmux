###############################
# for poderosa, cygwin @Win7
###############################

# reloading command
unbind r
bind C-r source-file ~/.tmux.conf \; display-message "reloaded"

# vim
#set-window-option -g mode-keys vi

# prefix
unbind C-b
set -g prefix C-a

# 256色ターミナル
#set -g default-terminal screen

# UTF8 Support
#setw -g utf8 on
# コピーモードのキーバインドをviライクにする
setw -g mode-keys vi
# ウィンドウ名が実行中のコマンド名になるのを止める
setw -g automatic-rename off
# ウィンドウの開始番号を1にする
set -g base-index 1
# ペインの開始番号を1にする
set -g pane-base-index 1

# status
set -g status-fg white
set -g status-bg colour235

set -g status-left '#[fg=green,bold][#20(whoami)@#H]#[default]'
set -g status-right '#[fg=white][%Y/%m/%d(%a)%H:%M]#[default]'
set -g status-right-bg black

# window-status-current
setw -g window-status-current-fg black
setw -g window-status-current-bg white

# pane-active-border
set -g pane-active-border-fg white
set -g pane-active-border-bg black

# scroll
set-window-option -g mode-mouse on
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
set-option -g history-limit 100000

# home key and end key
#set-option -g xterm-keys on
set -g default-terminal xterm
#set-option -g default-terminal "xterm"
set-option -g terminal-overrides "xterm-color:khome=\033[1~"

# mode-mouse
bind m \
  set -g mode-mouse on \; \
  display "Mouse: ON"
bind M \
  set -g mode-mouse off \; \
  display "Mouse: OFF"
