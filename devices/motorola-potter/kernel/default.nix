{
  mobile-nixos
, stdenv
, fetchFromGitHub
, ...
}:


mobile-nixos.kernel-builder {
  version = "5.18.3";
  configfile = ./config.aarch64;

  src = fetchFromGitHub {
    owner = "msm8953-mainline";
    repo = "linux";
    rev = "b265c0627c38629719e2f472755b5a9b32603fb2";
    sha256 = "sha256-eUdefCBXAn/TTiiQK6Q8iXvr4210jcywnLP/mAesbHk=";
  };

  patches = [
  ];

#  enableRemovingWerror = true;
  isModular = true;
  isQcdt = false;
  needsAppendedFdt = "dtbs/qcom/sdm625-motorola-potter.dtb";
}
