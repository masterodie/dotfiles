{ pkgs, ... }:
{
  users.users = {
    odie = {
      initialPassword = "Passw0rd";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIByWNNmKhjVk5VEjk3aSKosOXzglCbiq7q8IQ8mA0qQe odie"
      ];
      extraGroups = [ "wheel" "audio" "video" ];
      shell = pkgs.zsh;
    };
  };
}
