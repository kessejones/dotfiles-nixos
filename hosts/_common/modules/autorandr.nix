{...}: let
  edp_id = "00ffffffffffff0006afed6100000000001a010495221378025925935859932926505400000001010101010101010101010101010101783780b470382e406c30aa0058c1100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231353648414e30362e31200a00ea";
  hdmi_id = "00ffffffffffff0004728005dd123010031f0103803c2278ee53a5a756529c26115054b30c00714f818081c081009500b300d1c001012a4480a0703827403020350056502100001a023a801871382d40582c450056502100001e000000fd00304c1f5412000a202020202020000000fc0053413237300a202020202020200120020327f14b900102030405111213141f230907078301000065030c001000681a00000101304be6023a801871382d40582c450056502100001e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000182a4480a0703827403020350056502100001a000000000000000000000000000000001f";
in {
  services.autorandr = {
    enable = true;
    defaultTarget = "laptop-dual";
    profiles = {
      "laptop" = {
        fingerprint = {
          "eDP-1-1" = edp_id;
        };
        config = {
          "eDP-1-1" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
          };
        };
      };

      "laptop-dual" = {
        fingerprint = {
          "eDP-1-1" = edp_id;
          "HDMI-0" = hdmi_id;
        };
        config = {
          "eDP-1-1" = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "1920x1080";
          };
          "HDMI-0" = {
            enable = true;
            primary = true;
            position = "1920x0";
            mode = "1920x1080";
          };
        };
      };
    };
  };
}
