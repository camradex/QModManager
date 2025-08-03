#!/bin/bash
set -e

solutionDir="$(realpath "$1")"
targetDir="$(realpath "$2")"
configName="$3"

copy_files_and_zip() {
    local basePath="$1"
    local zipName="$2"

    mkdir -p "$basePath/patchers/QModManager"
    mkdir -p "$basePath/plugins/QModManager"

    cp "$targetDir/QModManager.QModPluginGenerator.dll" "$basePath/patchers/QModManager/"
    cp "$targetDir/QModInstaller.dll" "$basePath/plugins/QModManager/"
    cp "$targetDir/QModInstaller.xml" "$basePath/plugins/QModManager/"

    zipPath="$solutionDir/BepinexPackages/$zipName"
    [ -f "$zipPath" ] && rm -f "$zipPath"

    7z a "$zipPath" "$basePath/*"
}

case "$configName" in
    "SN.STABLE")
        copy_files_and_zip "$solutionDir/BepinexPackages/Subnautica_Packages/QModManager" "QModManager_Subnautica.zip"
        ;;
    "SN.EXP")
        copy_files_and_zip "$solutionDir/BepinexPackages/Subnautica_Packages/QModManager_Exp" "QModManager_Subnautica_Experimental.zip"
        ;;
    "BZ.STABLE")
        copy_files_and_zip "$solutionDir/BepinexPackages/BelowZero_Packages/QModManager" "QModManager_BelowZero.zip"
        ;;
    "BZ.EXP")
        copy_files_and_zip "$solutionDir/BepinexPackages/BelowZero_Packages/QModManager_Exp" "QModManager_BelowZero_Experimental.zip"
        ;;
    *)
        echo "Unknown configName: $configName"
        exit 1
        ;;
esac
