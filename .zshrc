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
# FZF Config
####################
source <(fzf --zsh)
# alias fd='fdfind'

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
export LANG=en_US.UTF-8

####################
# Alacritty & TMUX
####################
alias dark_mode='python3 ~/.scripts/toggle_bright.py ~/.config/alacritty/alacritty.toml'
alias st='~/.local/tmux-addons/tmux-session-handler/session-handler.sh'
alias clangConf='vim ~/.config/clangd/config.yaml'

####################
# Venvs
####################
alias piovenv='source ~/.config/venv/platformio/bin/activate'
alias cppgenvenv='source ~/.config/venv/cpp-generator/bin/activate'
alias fikavenv='source ~/.config/venv/fika/bin/activate'

####################
# Platformio
####################
alias compile='piovenv; platformio run --environment test_linux; deactivate'
alias run='./.pio/test_linux/program'
alias compileGcov='platformio run --environment gcov'
alias runGcov='./.pio/gcov/program'

####################
# Node-firmware
####################
alias ftest='nf; find . -type f -name "*.ini" | sed '\''s/\/test\/bin\/platformio.ini//'\'' | fzf | read dir; cd "$dir/test/bin"; pwd'
alias nf='cd ~/Documents/cfs/node-firmware'
alias cdb='piovenv;platformio run --target compiledb --environment compdb --project-dir $(git rev-parse --show-toplevel); deactivate'
alias flash='nf; ls $(git rev-parse --show-toplevel)/src/nodes | fzf | read node; build $node; node-patcher $node .pio/build/$node/firmware.hex; cd -'

####################
# CAN
####################
alias canSetup='sudo ip link set can0 type can bitrate 1000000'
alias canUp='sudo ip link set up can0'
alias cfs='cd ~/Documents/cfs/; cd $(find . -maxdepth 1 | fzf);pwd'

####################
# GIT
####################
alias gModU='git submodule update --init --recursive'
alias gAmend='git commit --amend --all'
alias restore='git status -s | fzf | awk '\''{print $2}'\'' | xargs git restore'
alias diff='git status -s | fzf | awk '\''{print $2}'\'' | xargs git diff'
alias delBranch='git branch -D $(git branch -a | grep -v remote | fzf)'
alias checkout='git checkout $(git branch -a | grep -v remote | grep -v \* | fzf)'
alias gRoot='cd $(git rev-parse --show-toplevel)'
alias fgit='find ~/Documents -name .git | fzf | read dir; cd $dir/../'

####################
# IMGUI CLIENT
####################
alias srcImgui='source ~/Documents/cfs/cfs-imgui-client/source.sh'

####################
# OTHER
####################
alias grip='/home/isak/.local/bin/grip -b'
alias vim="nvim"
alias boards='firefox https://gitlab.com/groups/chalmersfs/software/embedded/-/boards'
alias windows_update='sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y'

alias fa=' alias | fzf | awk -F= "{print \$1}" | xargs -I{} zsh -ic "{}"'


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

export PATH="/home/isak/Documents/cfs/node-patcher/bin:$PATH"
export PATH="/home/isak/.local/zig/zig-linux-x86_64-0.14.0-dev.2851+b074fb7dd/:$PATH"
export PATH="/home/isak/.local/zls/zig-out/bin/:$PATH"


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

# function runWindows(){
# qemu-system-x86_64 \
# -display gtk,window-close=off \
# -machine type=q35,accel=kvm \
# -enable-kvm \
# -cpu Skylake-Client-v4,hv_relaxed,hv_vpindex,hv_time,hv_vapic,hv_runtime,hv_synic,hv_stimer,hv_tlbflush,hv_ipi,hv_frequencies \
# -smp 4 \
# -m 4096 -mem-prealloc \
# -vga virtio \
# -device ich9-intel-hda \
# -device hda-duplex,audiodev=hda \
# -audiodev pa,id=hda,server=unix:/run/user/1000/pulse/native,out.frequency=44100 \
# -device qemu-xhci,id=xhci \
# -device usb-tablet,bus=xhci.0 \
# -chardev socket,path=/tmp/qga.sock,server=on,wait=off,id=qga0 \
# -device virtio-serial \
# -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
# -object rng-random,id=rng0,filename=/dev/urandom \
# -device virtio-rng-pci,max-bytes=1024,period=1000 \
# -drive format=raw,file=windows.img \
# -drive file=Win10_22H2_English_x64v1.iso,media=cdrom \
# -boot menu=on
# }
