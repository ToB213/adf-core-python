{
  description = "Development environment for adf-core-python";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      nativeLibraries = with pkgs; [
        geos
        libspatialindex
      ];
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python313
          uv
          pkg-config
        ] ++ nativeLibraries;

        UV_PYTHON = "${pkgs.python313}/bin/python3.13";
        UV_PYTHON_DOWNLOADS = "never";
        DYLD_LIBRARY_PATH = pkgs.lib.makeLibraryPath nativeLibraries;
      };
    };
}
