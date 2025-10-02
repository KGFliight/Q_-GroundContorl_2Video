# Windows Build & Packaging (from GitHub Actions)

This repo includes a GitHub Actions workflow to produce a Windows Release build and package artifacts without needing a local Windows setup.

## Quick Start

1. Push your branch to GitHub.
2. Go to Actions → "Windows Release" → Run workflow.
3. Download the artifacts after the job completes. You'll get `QGroundControl.exe` and CPack outputs.

## What the workflow does

- Installs build tools: CMake, Ninja, Git
- Installs GStreamer (MSVC x86_64 runtime + devel)
- Installs Qt 6.9.2 for MSVC 2022 via `aqtinstall`
- Uses CMake Preset `Windows` (Ninja Multi-Config) to configure and build
- Runs the `package` target to create distributable artifacts

See `.github/workflows/windows-release.yml` for details.

## Local Windows Build (optional)

If you want to build locally on Windows:

- Install Visual Studio 2022 Build Tools (Desktop development with C++)
- Install Qt 6.9.2 MSVC 2022 and set `QT_ROOT_DIR` to `C:\\Qt\\6.9.2\\msvc2022_64`
- Install GStreamer MSVC x86_64 runtime + devel and set `GSTREAMER_1_0_ROOT_MSVC_X86_64` to `C:\\gstreamer\\1.0\\msvc_x86_64`

Then run:

```powershell
cmake --preset Windows
cmake --build --preset Windows
cmake --build --preset Windows --target package
```

Artifacts:
- `build\\qt6-Windows\\Release\\QGroundControl.exe`
- CPack outputs under `build\\qt6-Windows\\_CPack_Packages`
