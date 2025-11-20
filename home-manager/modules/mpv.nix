{
  pkgs,
  lib,
  ...
}: let
  make-conf = attrs:
    builtins.concatStringsSep "\n" (
      builtins.map (key: "${key} = ${toString attrs.${key}}") (builtins.attrNames attrs)
    );

  config = {
    alang = lib.strings.concatStringsSep "," ["jpn" "eng" "por"];
    slang = lib.strings.concatStringsSep "," ["eng" "por" "jpn"];
    osd-on-seek = "no";

    sub-auto = "fuzzy";

    sub-file-paths = lib.strings.concatStringsSep ":" [
      "sub"
      "Sub"
      "subs"
      "Subs"
      "subtitles"
      "Subtitles"
    ];
  };

  fuzzy-sub-script = ''
    local utils = require('mp.utils')

    local function ends_with(str, suffix)
      return str:sub(-#suffix) == suffix
    end

    local function find_subs(path, exts)
      local files = utils.readdir(path, 'files')

      if not files then
        return {}
      end

      local results = {}
      for _, f in ipairs(files) do
        for _, ext in ipairs(exts) do
          if ends_with(f, "." .. ext) then
            table.insert(results, utils.join_path(path, f))
          end
        end
      end

      return results
    end

    local function load()
      local paths = mp.get_property_native('sub-file-paths')
      local exts = mp.get_property_native('sub-auto-exts')
      local cwd = utils.getcwd()

      local media_filename = mp.get_property('filename/no-ext')

      for _, p in ipairs(paths) do
        local sub_media_dir = utils.join_path(utils.join_path(cwd, p), media_filename)

        local sub_files = find_subs(sub_media_dir, exts)

        for _, sub_file in ipairs(sub_files) do
          mp.commandv('sub-add', sub_file, 'auto')
        end
      end
    end

    mp.add_hook('on_load', 10, load)
  '';
in {
  catppuccin.mpv.enable = true;
  programs.mpv = {
    enable = true;
    bindings = {
      WHEEL_UP = "seek 5";
      WHEEL_DOWN = "seek -5";
      "Shift+WHEEL_UP" = "seek 10";
      "Shift+WHEEL_DOWN" = "seek -10";
      "Ctrl+WHEEL_UP" = "add video-zoom 0.1";
      "Ctrl+WHEEL_DOWN" = "add video-zoom -0.1";
    };
  };

  xdg.configFile."mpv/mpv.conf".text = make-conf config;
  xdg.configFile."mpv/scripts/fuzzy-subs.lua".text = fuzzy-sub-script;

  home.packages = [pkgs.open-in-mpv];
}
