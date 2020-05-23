{ config, lib, pkgs, ... }:

{
  mobile.device.name = "xiaomi-lavender";
  mobile.device.identity = {
    name = "Redmi Note 7";
    manufacturer = "Xiaomi";
  };

  mobile.device.info = rec {
    # TODO : make kernel part of options.
    kernel = pkgs.callPackage ./kernel { kernelPatches = pkgs.defaultKernelPatches; };
    kernel_cmdline = lib.concatStringsSep " " [
      "earlycon=msm_serial_dm,0xc170000"
      "androidboot.hardware=qcom"
      "user_debug=31"
      "msm_rtb.filter=0x37"
      "ehci-hcd.park=3"
      "lpm_levels.sleep_disabled=1"
      "sched_enable_hmp=1"
      "sched_enable_power_aware=1"
      "service_locator.enable=1"
      "swiotlb=1"
      "firmware_class.path=/vendor/firmware_mnt/image"
      "loop.max_part=7"
      "androidboot.selinux=permissive"
      "buildvariant=userdebug"
    ];
    bootimg_qcdt = false;
    flash_offset_base = "0x00000000";
    flash_offset_kernel = "0x00008000";
    flash_offset_ramdisk = "0x01000000";
    flash_offset_second = "0x00f00000";
    flash_offset_tags = "0x00000100";
    flash_pagesize = "4096";

    # This device adds skip_initramfs to cmdline for normal boots
    boot_as_recovery = true;
    # Though this device has "boot_as_recovery", it still has a classic
    # recovery partition for recovery. Go figure.
    has_recovery_partition = true;

    vendor_partition = "/dev/disk/by-partlabel/vendor";
    gadgetfs.functions = {
      rndis = "rndis_bam.rndis";
      # FIXME: This is likely the right function name, but doesn't work.
      # adb = "ffs.usb0";
    };
  };
  mobile.hardware = {
    soc = "qualcomm-sdm660";
    # 4GB for the specific revision supported.
    # When this will be actually used, this may be dropped to 3, and/or
    # document all ram types as a list and work with min/max of those.
    ram = 1024 * 4;
    screen = {
      width = 1080; height = 2340;
    };
  };

  mobile.usb.mode = "gadgetfs";
  # FIXME: attribute to sources.
  mobile.usb.idVendor  = "2717"; # Xiaomi Communications Co., Ltd.
  mobile.usb.idProduct = "FF80"; # Mi/Redmi series (RNDIS)

  mobile.system.type = "android";
}
