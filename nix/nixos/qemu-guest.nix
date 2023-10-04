{ pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  services = {
    openssh.enable = true;
    spice-vdagentd.enable = true;
    qemuGuest.enable = true;
    xserver = {
      videoDrivers = [
        "modesetting"
        "fbdev"
        "qxl"
      ];
    };
  };

  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules =
        [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
      kernelModules = [ ];
    };
  };

  boot.kernelParams = [
    "console=tty1"
    "console=ttyS0,115200"
  ];

  environment.systemPackages = with pkgs; [
    spice-vdagent
    qemu-utils
  ];

  virtualisation.qemu.guestAgent.enable = true;
}
