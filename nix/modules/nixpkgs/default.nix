{
  inputs,
  config,
  pkgs,
  ...
}: {
  # allow this until libguestfs fix
  nixpkgs.config = {
    problems.handlers.libguestfs.broken = "warn";
    permittedInsecurePackages = [
      "qutebrowser-3.7.0"
    ];
  };
}
