{pkgs, ...}: {
  xdg.configFile."picom/picom.conf".text = ''
    backend = "egl";

    animations = ({
    	triggers = ["geometry"];
    	preset = "geometry-change";
    	duration = 0.2;
    });

    shadow = true;
    shadow-exclude = [];
    shadow-radious = 12;
    shadow-offset-x = -12;
    shadow-offset-y = -12;
    shadow-opacity = 0.3;
  '';

  services.picom = {
    enable = true;
    package = pkgs.picom-git;
  };
}
