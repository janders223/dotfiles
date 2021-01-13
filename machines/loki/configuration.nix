{ pkgs, modulesPath, lib, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  users.groups = {
    sudo = { };
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.root = {
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDu4CfpWlJoP8FD5ImduQLbC48IdvBBFd0yWtkxwh4mQRq7xhiWZGxLbGiH/pKiJZtz73F2eKJoA8bsKtXoiCZRrl97Pjux1SNJi86sdWSzDiNXk7FBwj8rIPDMctqso0oouUtSmEsZ7UQDHL58WrC1+Xv0Nhw9NrOXfXb6tT7Kr5xPocJn3Vrc0ZVC7mskOK7vVIJYsModEzrKWDvoQNKjafoOw+JgpMeJpayYKYZWkhdNFojFLRB/JDDjWQMbpL62SDq4JQ3zLMGBb5ymRaGsc7O8AIDkeQkYZQN+tmuuE2bBAvgAPE6tG7mToJRRmOVVURN+GRuJD7nXkCjLjRNhxnjbcyQDmrMugxRqMWSgvBG1AyWwjTNfq7DNhzjHl12lc07wR0Rc/9zD1Cl/aqhnNGqdTnBgHTayTbANTy8OBKCMRR0ZJLnJnz/hBfsXp7l/iofIqHLk1hvdadsHE+yu1PoGsytf1eFt3F0QaIFUYNWuV9x+3wdRgR4hmFXALMiJCS4OHjt8zo04Y88BaGEBiIdbF273aj/dA4W3xmdRaUrnEaESItfV9yN7ItyLmvC7SnbV7hoMP0U2ElnfS2+uKCJTuj2yS1X62JzRU73m6tQ+q9969FBIleP8dkggi9NFHA8qvEFzIyqohi/Afe8mGcd2En7SlLBNtY+KhYoZ3w== jimanders223@gmail.com" ];
  };

  users.users.janders223 = {
    name = "Jim Anders";
    createHome = true;
    group = "janders223";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDu4CfpWlJoP8FD5ImduQLbC48IdvBBFd0yWtkxwh4mQRq7xhiWZGxLbGiH/pKiJZtz73F2eKJoA8bsKtXoiCZRrl97Pjux1SNJi86sdWSzDiNXk7FBwj8rIPDMctqso0oouUtSmEsZ7UQDHL58WrC1+Xv0Nhw9NrOXfXb6tT7Kr5xPocJn3Vrc0ZVC7mskOK7vVIJYsModEzrKWDvoQNKjafoOw+JgpMeJpayYKYZWkhdNFojFLRB/JDDjWQMbpL62SDq4JQ3zLMGBb5ymRaGsc7O8AIDkeQkYZQN+tmuuE2bBAvgAPE6tG7mToJRRmOVVURN+GRuJD7nXkCjLjRNhxnjbcyQDmrMugxRqMWSgvBG1AyWwjTNfq7DNhzjHl12lc07wR0Rc/9zD1Cl/aqhnNGqdTnBgHTayTbANTy8OBKCMRR0ZJLnJnz/hBfsXp7l/iofIqHLk1hvdadsHE+yu1PoGsytf1eFt3F0QaIFUYNWuV9x+3wdRgR4hmFXALMiJCS4OHjt8zo04Y88BaGEBiIdbF273aj/dA4W3xmdRaUrnEaESItfV9yN7ItyLmvC7SnbV7hoMP0U2ElnfS2+uKCJTuj2yS1X62JzRU73m6tQ+q9969FBIleP8dkggi9NFHA8qvEFzIyqohi/Afe8mGcd2En7SlLBNtY+KhYoZ3w== jimanders223@gmail.com" ];
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services.openssh = {
    ports = [ 3518 ];
    passwordAuthentication = false;
  };
}
