{
  mobile-nixos
, stdenv
, fetchFromGitHub
, ...
}:


mobile-nixos.kernel-builder {
  version = "5.18.3";
  configfile = ./config.mainline.aarch64;

  src = fetchFromGitHub {
    owner = "msm8953-mainline";
    repo = "linux";
    rev = "b265c0627c38629719e2f472755b5a9b32603fb2";
    sha256 = lib.fakeHash;
  };

  patches = [
    # ./04_fix_camera_msm_isp.patch
    # ./99_framebuffer.patch
    # ./0001-Allow-building-WCD9335_CODEC-without-REGMAP_ALLOW_WR.patch
    # ./0005-Allow-building-with-sound-disabled.patch
    # ./0007-Coalesce-identical-device-trees.patch
    # ./0008-Notify-clients-when-FB-opened.patch
  ];

#  enableRemovingWerror = true;
  isModular = true;
  isQcdt = true;
}
