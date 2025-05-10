let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    ruby
  ];

  shellHook = ''
    # Use the Nix store path of Ruby as a reference
    RUBY_STORE_PATH=${pkgs.ruby}

    # Create an isolated gem directory tied to this Ruby version
    export GEM_HOME=/tmp/nix-ruby-gems-$(basename $RUBY_STORE_PATH)/${pkgs.ruby.version}
    export GEM_PATH=$GEM_HOME:${pkgs.ruby}/lib/ruby/gems/${pkgs.ruby.version}
    export PATH=$GEM_HOME/bin:$PATH

    mkdir -p $GEM_HOME
    echo "Ruby store path: $RUBY_STORE_PATH"
    echo "Gem environment: $GEM_HOME"  '';
}
