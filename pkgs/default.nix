final: prev: {
  TLauncher = final.callPackage ./tlauncher {};

  nodeCustomPackages = {
    prettierd = final.callPackage ./prettierd {};
  };
}
