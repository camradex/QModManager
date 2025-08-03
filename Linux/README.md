# QModManager: Building on Linux

This guide outlines how to build QModManager on Linux using Mono and MSBuild.

---

## Requirements

Make sure you have the following installed:

- `git`
- `mono`
- `mono-msbuild` or `msbuild` (package name depends on your distro)
- `nuget`
- `7zip` (verify that `7z a` works)
- `dotnet`

You can install them via your package manager.

### Command line knowledge is recommended, use at your own risk!

---

## Build Instructions

```bash
git clone https://github.com/SubnauticaModding/QModManager.git
# If this pr isn't merged clone my fork instead:
# git clone https://github.com/camradex/QModManager.git
cd QModManager

# Make the Linux post-build script executable in case it isn't
chmod +x Linux/QModPluginGenerator-post-build.sh

# Restore dependencies
nuget restore
dotnet restore
```

### Build the solution

#### Notes

- `GameDir` should point to the game’s root directory.
- `ManagedDir` should point to the game's `*_Data/Managed` folder.
- `Configuration` options:
  - `SN.STABLE` — Subnautica
  - `BZ.STABLE` — Below Zero
  - `SN.EXP` — Subnautica Experimental
  - `BZ.EXP` — Below Zero Experimental
- `Platform` options: `x64`, `x86`, `Any CPU`

You can define your own configurations in the MSBuild project file if needed.

```bash
msbuild QModManager.sln \
  /p:Configuration="SN.STABLE" \
  /p:Platform="x64" \
  /p:OS="Linux" \
  /p:GameDir="$HOME/.local/share/Steam/steamapps/common/Subnautica" \
  /p:ManagedDir="$HOME/.local/share/Steam/steamapps/common/Subnautica/Subnautica_Data/Managed"
```

---

## Output

After a successful build, the QModManager mod files will be placed in the `Build/` directory relative to the solution.

You can then copy them into your game’s `BepInEx` folder.  
Follow the [install instructions for Linux with Proton](https://github.com/SubnauticaModding/QModManager/issues/173).

---
