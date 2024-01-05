{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; } }:
pkgs.dockerTools.buildImage {
  name = "vriska";
  tag = "latest";
  contents = pkgs.buildEnv {
    name = "image-root";
    paths = with pkgsLinux; [ minetestserver bashInteractive coreutils ];
    pathsToLink = [ "/bin" ];
  };
  runAsRoot = ''
    #!${pkgsLinux.runtimeShell}
    ${pkgsLinux.dockerTools.shadowSetup}
    groupadd -r minetest
    useradd -m -r -g minetest workuser
  '';
  config = {
    Cmd = [ "${pkgs.minetestserver}/bin/minetestserver" ];
    User = "workuser:minetest";
  };
}

