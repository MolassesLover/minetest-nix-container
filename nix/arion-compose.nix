{
  project.name = "minetest";
  services.server = {
    service = {
      image = "vriska:latest";
      ports = [ "30000:30000/udp" ];
      volumes = [ "$HOME/.minetest:/home/workuser/.minetest:U,z" ];
    };
  };
}
