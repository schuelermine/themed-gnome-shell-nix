{
  outputs = { self }: {
    overlays.default = themeLoc: selfPkgs: superPkgs: {
      gnome = superPkgs.gnome // {
        gnome-shell = superPkgs.gnome.gnome-shell.overrideAttrs (selfAttrs: superAttrs: {
          pname = "themed-gnome-shell";
          buildInputs = superAttrs.buildInputs ++ [ selfPkgs.breakpointHook ];
          postInstall = superAttrs.postInstall or "" + ''
            rm $out/share/gnome-shell/gnome-shell-theme.gresource
            cp ${themeLoc} $out/share/gnome-shell/gnome-shell-theme.gresource
          '';
        });
      };
    };
  };
}
