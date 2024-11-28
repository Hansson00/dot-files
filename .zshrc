# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

ZSH_THEME="nicoulaj"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

####################
# Venvs
####################
alias piovenv='source ~/.config/venv/platformio/bin/activate'
alias cppgenvenv='source ~/.config/venv/cpp-generator/bin/activate'

####################
# FZF Config
####################
source <(fzf --zsh)
alias fd='fdfind'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

####################
# My config
####################

alias dark_mode='python3 ~/.scripts/toggle_bright.py ~/.config/alacritty/alacritty.toml'

alias vim="nvim"
alias cdb='piovenv;platformio run --target compiledb --environment compdb --project-dir $(git rev-parse --show-toplevel); deactivate'

function build() {
piovenv
platformio run --project-dir $(git rev-parse --show-toplevel) --environment $1
deactivate
}

function clean() {
piovenv
platformio run --target clean --project-dir $(git rev-parse --show-toplevel) --environment $1
deactivate
}

function upload() {
piovenv
platformio run --project-dir $(git rev-parse --show-toplevel) -t upload --environment $1
deactivate
}

function monitor() {
piovenv
platformio device monitor
deactivate
}

function buildAll() {
	build rear
	build front
	build ams
	build dash
	build steering_wheel
}

alias compile='piovenv; platformio run --environment test_linux; deactivate'
alias run='./.pio/test_linux/program'

alias compileGcov='platformio run --environment gcov'
alias runGcov='./.pio/gcov/program'

function cov() {
  rm -rf *.html *.css
  repo_root=$(git rev-parse --show-toplevel)
  rm -rf $repo_root/.build_cache
  platformio run --environment gcov
  ./.pio/gcov/program
  gcovr -r ../../ --html --html-details -o out.html
  firefox out.html
}

function cNr() {
  compile
	./.pio/test_linux/program
}

# alias canCartSetup='bash find_tty.sh CANable | sudo slcand -o -s8 -t hw -S 3000000 '
# alias canCartUp='sudo ip link set up slcan0'

alias canSetup='sudo ip link set can0 type can bitrate 1000000'
alias canUp='sudo ip link set up can0'

alias nf='cd ~/Documents/cfs/node-firmware'
alias cfs='cd ~/Documents/cfs/; cd $(find . -maxdepth 1 | fzf);pwd'
alias connectToSchool='~/Downloads/distans-cdal.sh ssvncviewer 1600x1000'
alias st='~/.local/tmux-addons/tmux-session-handler/session-handler.sh'

alias gModU='git submodule update --init --recursive'
alias gAmend='git commit --amend --all'
alias grip='/home/isak/.local/bin/grip -b'
alias restore='git status -s | fzf | awk '\''{print $2}'\'' | xargs git restore'
alias diff='git status -s | fzf | awk '\''{print $2}'\'' | xargs git diff'
alias ftest='nf; find . -type f -name "*.ini" | sed '\''s/\/test\/bin\/platformio.ini//'\'' | fzf | read dir; cd "$dir/test/bin"'
alias clangConf='vim ~/.config/clangd/config.yaml'

export PATH="/home/isak/Documents/cfs/node-patcher/bin:$PATH"

alias delBranch='git branch -D $(git branch -a | grep -v remote | fzf)'
alias checkout='git checkout $(git branch -a | grep -v remote | grep -v \* | fzf)'
alias flash='nf; ls $(git rev-parse --show-toplevel)/src/nodes | fzf | read node; build $node; node-patcher $node .pio/build/$node/firmware.hex; cd -'
alias fgit='find ~/Documents -name .git | fzf | read dir; cd $dir../'
alias src='source ~/Documents/cfs/cfs-imgui-client/source.sh'
alias gRoot='cd $(git rev-parse --show-toplevel)'
alias boards='firefox https://gitlab.com/groups/chalmersfs/software/embedded/-/boards'
