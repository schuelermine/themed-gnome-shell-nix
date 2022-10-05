{
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      gresourceHandling = ./gresourceHandling.sh;
    in
    {
      packages.themed-gnome-shell = theme: pkgs.gnome.gnome-shell.overrideAttrs (self: super: {
        buildInputs = super.buildInputs ++ [ pkgs.breakpointHook ];
        postBuild = super.postBuild or "" + ''
          exit 1
          PATH+=:${pkgs.glib.dev}/bin
          workDir=$(mktemp -d)
          source ${gresourceHandling}
        '';
      });
    });
}
