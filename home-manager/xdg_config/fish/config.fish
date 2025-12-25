# Suppress the default greeting message
set -g fish_greeting ""

eval (/opt/homebrew/bin/brew shellenv fish)

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx DENO_INSTALL_ROOT $XDG_DATA_HOME/deno
set -gx GOPATH $XDG_DATA_HOME/go
set -gx PNPM_HOME $HOME/Library/pnpm
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

set -gx PATH \
  $CARGO_HOME/bin \
  $DENO_INSTALL_ROOT/bin \
  $GOPATH/bin \
  $HOME/.bun/bin \
  $HOME/.local/bin \
  "$HOME/Library/Application Support/Coursier/bin" \
  $PNPM_HOME \
  $RUSTUP_HOME/bin \
  /opt/homebrew/opt/llvm/bin \
  $PATH

if status is-interactive
  function fcd
    cd (ghq root)/(ghq list | fzf)
  end

  function gocryptfs
    command gocryptfs -extpass "op read op://Personal/gocryptfs/password" $argv
  end

  function rm
    echo "rm is dangerous, use trash instead"

    return 1
  end

  starship init fish | source
end
