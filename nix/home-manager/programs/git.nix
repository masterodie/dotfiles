{ ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Patrick Neff";
      userEmail = "odie86@gmail.com";
      extraConfig = {
        push = {
          default = "matching";
        };
        core = {
          autocrlf = "input";
        };
        pull = {
          rebase = false;
        };
        init = {
          defaultBranch = "master";
        };
      };
    };
  };
}
