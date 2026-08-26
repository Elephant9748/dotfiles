{
  inputs,
  lib,
  ...
}: let
  modifications = final: prev: rec {
    freepgPatches = prev.fetchFromGitLab {
      owner = "freepg";
      repo = "gnupg";
      tag = "source-2.5.21-freepg";
      hash = "sha256-P3XdRnnVJuYe80S6wTMmmCO4jWBbUIkHkLKA75qSnNg=";
    };
    gnupg = inputs.nixpkgs.legacyPackages."${prev.stdenv.hostPlatform.system}".gnupg.overrideAttrs (oldAttrs: rec {
      version = "2.5.21";
      pname = "gnupg";
      src = prev.fetchurl {
        url = "mirror://gnupg/gnupg/${pname}-${version}.tar.bz2";
        hash = "sha256-468sjKpGpmqTKfp8aICvJgRRkU2BlZW+q8LCZZezE1I=";
      };
      postPatch =
        # Switch the default key server to keys.openpgp.org
        # The original motivation in 2019 was to switch away from the then-default SKS network: https://github.com/NixOS/nixpkgs/pull/63952
        # In 2021 upstream also switched away, but to keyserver.ubuntu.com: https://dev.gnupg.org/rG47c4e3e00a7ef55f954c14b3c237496e54a853c1,
        # while NixOS kept the keys.openpgp.org default: https://github.com/NixOS/nixpkgs/pull/159604
        # TODO: Should this patch be removed so that the now-uncompromised default is used once again?
        # A significant difference between the two seems to be that keys.openpgp.org is verifying keys, while keyserver.ubuntu.com isn't: https://unix.stackexchange.com/a/694528
        # The keys.openpgp.org also has a great FAQ: https://keys.openpgp.org/about/faq
        ''
          substituteInPlace configure configure.ac \
            --replace-fail "hkps://keyserver.ubuntu.com"  "hkps://keys.openpgp.org"
          substituteInPlace doc/gnupg.info-1 doc/dirmngr.texi \
            --replace-fail "https://keyserver.ubuntu.com" "https://keys.openpgp.org"
        ''
        + lib.optionalString (prev.stdenv.hostPlatform.isLinux && false) ''
          sed -i 's,"libpcsclite\.so[^"]*","${lib.getLib prev.pcsclite}/lib/libpcsclite.so",g' scd/scdaemon.c
        '';
      patches =
        [
          # ./static.patch
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
    });
  };
in {
  nixpkgs.overlays = [modifications];
}

