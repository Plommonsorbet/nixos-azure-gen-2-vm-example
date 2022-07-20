{
  inputs.nixos.url = "github:nixos/nixpkgs/nixos-22.05";

  outputs = { nixos, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixos { inherit system; };
    in
    {
      packages.${system}.azure-image =
        let
          img = nixos.lib.nixosSystem {
	    inherit pkgs system;

            modules = [ ./image.nix ./common.nix ];
          };
        in
        img.config.system.build.azureImage;
    };
}

