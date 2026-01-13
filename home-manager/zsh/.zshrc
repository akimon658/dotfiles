eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_DATA_HOME="$HOME/.local/share"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DENO_INSTALL_ROOT="$XDG_DATA_HOME/deno"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$DENO_INSTALL_ROOT/bin:$RUSTUP_HOME/bin:$PATH"
