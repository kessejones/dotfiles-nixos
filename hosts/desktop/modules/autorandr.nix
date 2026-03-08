{...}: let
  dp_id_1 = "00ffffffffffff0006b30327abd9000006210104a53c22783bc365a4554d99260e5054bfcf00814081809500714f81c0b30001010101023a801871382d40582c450056502100001ed09480a070381e403040350056502100001a000000fd0030a5c8c83c010a202020202020000000fc004153555320564732373951314101d502032ef14d010304131f120211900e0f1d1e230907078301000065030c0010006d1a0000020130a5000000000000866f80a0703840403020350056502100001a0782805070384d400820f80c56502100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000065";

  dp_id_2 = "00ffffffffffff0006b35927010101012e220104b53c22783b9785ab5148a8270e5054254a008140818081c0a9c0d1c0010101010101023a801871382d40582c450055502100001e000000fd0c30f019193c010a202020202020000000fc005647323739514d35410a202020000000ff0054394c4d54463030373835360a01a5020336f14d01030212111304202122903f4023090707830100006d1a0000020130f0000000000000e305c000e606050162621ce200ea866f80a0703840403020350055502100001e5a8780a070384d403020350055502100001a03da80a0703826403020350055502100001a0000000000000000000000000000000000000076";

  hdmi_id = "00ffffffffffff0004728005dd123010031f0103803c2278ee53a5a756529c26115054b30c00714f818081c081009500b300d1c001012a4480a0703827403020350056502100001a023a801871382d40582c450056502100001e000000fd00304c1f5412000a202020202020000000fc0053413237300a202020202020200120020327f14b900102030405111213141f230907078301000065030c001000681a00000101304be6023a801871382d40582c450056502100001e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e96005650210000182a4480a0703827403020350056502100001a000000000000000000000000000000001f";
in {
  services.autorandr = {
    enable = true;
    defaultTarget = "desktop-setup-1";
    profiles = {
      "desktop-setup-1" = {
        fingerprint = {
          "DP-0" = dp_id_1;
          "DP-2" = dp_id_2;
        };
        config = {
          "DP-0" = {
            enable = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "165.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          "DP-2" = {
            enable = true;
            primary = true;
            position = "1920x0";
            mode = "1920x1080";
            rate = "240.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
      };
      "desktop-setup-2" = {
        fingerprint = {
          "DP-0" = dp_id_1;
          "DP-2" = dp_id_2;
          "HDMI-0" = hdmi_id;
        };
        config = {
          "DP-0" = {
            enable = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "165.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          "DP-2" = {
            enable = true;
            primary = true;
            position = "1920x0";
            mode = "1920x1080";
            rate = "240.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
          "HDMI-0" = {
            enable = true;
            primary = true;
            position = "3840x0";
            mode = "1920x1080";
            rate = "75.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
      };
      "desktop-setup-3" = {
        fingerprint = {
          "DP-0" = dp_id_1;
        };
        config = {
          "DP-0" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "165.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
      };
      "desktop-setup-4" = {
        fingerprint = {
          "DP-2" = dp_id_2;
        };
        config = {
          "DP-2" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "165.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
      };
      "desktop-setup-5" = {
        fingerprint = {
          "HDMI-0" = hdmi_id;
        };
        config = {
          "HDMI-0" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rate = "75.0";
            scale = {
              x = 1.0;
              y = 1.0;
            };
          };
        };
      };
    };
  };
}
