{
  outputs = { self }: {
    overlays.default = themeLoc: selfPkgs: superPkgs: {
      gnome = superPkgs.gnome // {
        gnome-shell = superPkgs.gnome.gnome-shell.overrideAttrs (selfAttrs: superAttrs: {
          pname = "themed-gnome-shell";
          buildInputs = superAttrs.buildInputs ++ [ selfPkgs.breakpointHook ];
          postBuild = superAttrs.postBuild or "" + ''
            rm data/gnome-shell-theme.gresource
            cp ${themeLoc} data/gnome-shell-theme.gresource
          '';
        });
      };
    };
  };
}
