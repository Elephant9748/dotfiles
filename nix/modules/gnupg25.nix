{
  pkgs,
  lib,
  ...
}: let
  version = "2.5.21";
  pname = "gnupg";
in {
  programs = {
    gpg = {
      enable = true;
      # package = pkgs.callPackage ../../pkgs/gnupg/24.nix {};
      package = pkgs.gnupg.overrideAttrs (oldAttrs: rec {
        inherit version pname;
        src = pkgs.fetchurl {
          url = "mirror://gnupg/gnupg/${pname}-${version}.tar.bz2";
          hash = "sha256-468sjKpGpmqTKfp8aICvJgRRkU2BlZW+q8LCZZezE1I=";
        };
        freepgPatches = pkgs.fetchFromGitLab {
          owner = "freepg";
          repo = "gnupg";
          tag = "source-2.5.21-freepg";
          hash = "sha256-P3XdRnnVJuYe80S6wTMmmCO4jWBbUIkHkLKA75qSnNg=";
        };
        patches =
          [
            # ../pkgs/gnupg/fix-libusb-include-path.patch
            # Without this, scdaemon isn't linked to libusb, causing smartcards to not work correctly
            # ./fix-libusb-include-path.patch
            # Use pkg-config to find tss2-esys to fix static building
            # Submitted upstream: https://dev.gnupg.org/D606
            # The diff is larger than upstream because configure.ac was modified,
            # requiring configure to be regenerated. For reasons we don't totally
            # understand, regenerating configure has all sorts of other undesirable
            # side effects. So to unbreak things, instead of regenerating configure,
            # we can include just the configure changes relevant to the static patch
            # in the patch file.
            # ./static.patch
            # ../pkgs/gnupg/static.patch
          ]
          ++ lib.map (v: "${freepgPatches}/STABLE-BRANCH-2-4-freepg/" + v) [
            "0002-gpg-accept-subkeys-with-a-good-revocation-but-no-sel.patch"
            "0003-gpg-allow-import-of-previously-known-keys-even-witho.patch"
            "0004-tests-add-test-cases-for-import-without-uid.patch"
            # "0005-gpg-drop-import-clean-from-default-keyserver-import-.patch"
            # "0008-avoid-systemd-deprecation-warning.patch"
            "0009-Add-systemd-support-for-keyboxd.patch"
            "0010-Ship-sample-systemd-unit-files.patch"
            "0011-el-gamal-default-to-3072-bits.patch"
            "0012-gpg-default-digest-algorithm-SHA512.patch"
            "0013-gpg-Prefer-SHA-512-and-SHA-384-in-personal-digest.patch"
            "0018-Avoid-simple-memory-dumps-via-ptrace.patch"
            # "0019-Disallow-compressed-signatures-and-certificates.patch"
            "0020-ssh-agent-emulation-under-systemd-inject-SSH_AUTH_SO.patch"
            # "0021-gpg-Sync-compliance-mode-cleanup-with-master.patch"
            "0022-gpg-emit-RSA-pubkey-algorithm-when-in-compatibility-.patch"
            "0023-gpg-Reintroduce-openpgp-as-distinct-from-rfc4880.patch"
            "0024-gpg-Emit-LibrePGP-material-only-in-compliance-gnupg.patch"
            "0025-gpg-gpgconf-list-report-actual-compliance-mode.patch"
            # "0026-gpg-Default-to-compliance-openpgp.patch"
            "0027-gpg-Fix-newlines-in-Cleartext-Signature-Framework-CS.patch"
            "0029-Add-keyboxd-systemd-support.patch"
            # "0033-Support-large-RSA-keygen-in-non-batch-mode.patch"
            # "0034-gpg-Verify-Text-mode-Signatures-over-binary-Literal-.patch"
            # "0039-gpg-Do-not-use-a-default-when-asking-for-another-out.patch"
          ];

        # dont do postPatch in gnupg25
        postPatch = ''
        '';
      });
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
