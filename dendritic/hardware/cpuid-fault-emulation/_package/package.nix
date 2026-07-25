{ lib,
  stdenv,
  linuxPackages ? null,
  kernel ? (
    if linuxPackages != null then linuxPackages.kernel
    else throw "cpuid-fault-emulation: no kernel in scope — pass `kernel` or `linuxPackages` explicitly, e.g. pkgs.callPackage ./package.nix { linuxPackages = pkgs.linuxPackages_zen; }"
  )
}:

stdenv.mkDerivation {
  pname = "cpuid-fault-emulation";
  version = "0.1";

  src = lib.cleanSource ./source;

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "KERNEL=${kernel.modDirVersion}"
  ];

  buildPhase = ''
    runHook preBuild
    make $makeFlags
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    installDir=$out/lib/modules/${kernel.modDirVersion}/extra
    mkdir -p $installDir
    cp cpuid_fault_emulation.ko $installDir/
    runHook postInstall
  '';

  meta = with lib; {
    description = "AMD-V based emulation of Intel-style CPUID faulting";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
