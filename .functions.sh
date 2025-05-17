function cdl {
        builtin cd "$@" && ls
}

function mkd {
        mkdir -p "$1" && cd "$1"
}

function nixify() {
        if [ ! -e ./.envrc ]; then
                echo "use nix" > .envrc
                direnv allow
        fi

        if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
                cat > default.nix <<'EOF'
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}
EOF
        ${EDITOR:-vim} default.nix
        fi
}

function flakify() {
        if [ ! -e flake.nix ]; then
                nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
                echo "use flake" > .envrc
                direnv allow
        fi
        ${EDITOR:-vim} flake.nix
}

