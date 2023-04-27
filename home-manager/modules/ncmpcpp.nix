{
  pkgs,
  config,
  ...
}: {
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {visualizerSupport = true;};

    settings = {
      mpd_host = "127.0.0.1";
      mpd_port = 6600;

      message_delay_time = 1;
      playlist_disable_highlight_delay = 2;
      autocenter_mode = "yes";
      centered_cursor = "yes";
      ignore_leading_the = "yes";
      allow_for_physical_item_deletion = "no";

      # Appearance;
      colors_enabled = "yes";
      playlist_display_mode = "columns";
      user_interface = "classic";
      volume_color = "white";

      # Window;
      song_window_title_format = "Music";
      statusbar_visibility = "yes";
      header_visibility = "no";
      titles_visibility = "no";
      # now_playing_prefix = "$3> $b";

      # Progress bar;
      progressbar_look = "▂▂▂";
      progressbar_color = "black";
      progressbar_elapsed_color = "cyan";

      # Alternative UI;
      alternative_ui_separator_color = "black";
      alternative_header_first_line_format = "$b$5«$/b$5« $b$8{%t}|{%f}$/b $5»$b$5»$/b";
      alternative_header_second_line_format = "{$b{$2%a$9}{ - $7%b$9}{ ($2%y$9)}}|{%D}";

      # Song list;
      song_list_format = " $8%a • %t";
      song_status_format = " $6%a  $7%t  $5%b ";
      song_columns_list_format = "  (30)[blue]{t} (5)[green]{a}(8f) [red]{l}";

      # Colors;
      main_window_color = "blue";
      current_item_prefix = "$(blue)$r";
      current_item_suffix = "$/r$(end)";
      current_item_inactive_column_prefix = "red";
      current_item_inactive_column_suffix = "red";

      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "spectrum";
      visualizer_look = "+|";

      color1 = "white";
      color2 = "red";
    };

    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "J";
        command = ["select_item" "scroll_down"];
      }
      {
        key = "K";
        command = ["select_item" "scroll_up"];
      }
    ];
  };
}
