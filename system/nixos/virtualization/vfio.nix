{ ... }:
let
  gpuIds = "8086:4c8a";
in
{
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
    "vfio-pci.ids=${gpuIds}"
  ];

  boot.blacklistedKernelModules = [ "i915" ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=${gpuIds}
  '';
}
