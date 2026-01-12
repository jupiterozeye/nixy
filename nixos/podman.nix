# Docker is a containerization platform that allows you to run applications in isolated environments called containers.
{config, ...}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  users.users."${config.var.username}".extraGroups = ["podman"];
}
