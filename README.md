
<p align="center">
  <img src="https://raw.githubusercontent.com/Dronecode/UX-Design/35d8148a8a0559cd4bcf50bfa2c94614983cce91/QGC/Branding/Deliverables/QGC_RGB_Logo_Horizontal_Positive_PREFERRED/QGC_RGB_Logo_Horizontal_Positive_PREFERRED.svg" alt="QGroundControl Logo" width="500">
</p>

<p align="center">
  <a href="https://github.com/mavlink/QGroundControl/releases">
    <img src="https://img.shields.io/github/release/mavlink/QGroundControl.svg" alt="Latest Release">
  </a>
</p>

*QGroundControl* (QGC) is a highly intuitive and powerful Ground Control Station (GCS) designed for UAVs. Whether you're a first-time pilot or an experienced professional, QGC provides a seamless user experience for flight control and mission planning, making it the go-to solution for any *MAVLink-enabled drone*.

---

### 🌟 *Why Choose QGroundControl?*

- *🚀 Ease of Use*: A beginner-friendly interface designed for smooth operation without sacrificing advanced features for pros.
- *✈️ Comprehensive Flight Control*: Full flight control and mission management for *PX4* and *ArduPilot* powered UAVs.
- *🛠️ Mission Planning*: Easily plan complex missions with a simple drag-and-drop interface.

🔍 For a deeper dive into using QGC, check out the [User Manual](https://docs.qgroundcontrol.com/en/) – although, thanks to QGC's intuitive UI, you may not even need it!


---

### 🚁 *Key Features*

- 🕹️ *Full Flight Control*: Supports all *MAVLink drones*.
- ⚙️ *Vehicle Setup*: Tailored configuration for *PX4* and *ArduPilot* platforms.
- 🔧 *Fully Open Source*: Customize and extend the software to suit your needs.

🎯 Check out the latest updates in our [New Features and Release Notes](https://github.com/mavlink/qgroundcontrol/blob/master/ChangeLog.md).

---

### 💻 *Get Involved!*

QGroundControl is *open-source*, meaning you have the power to shape it! Whether you're fixing bugs, adding features, or customizing for your specific needs, QGC welcomes contributions from the community.

🛠️ Start building today with our [Developer Guide](https://dev.qgroundcontrol.com/en/) and [build instructions](https://dev.qgroundcontrol.com/en/getting_started/).

---

## Dual Video Source – Project State and How-To

This fork adds a secondary video source to QGroundControl and a fast swap gesture. It’s ready to build on macOS locally and on Windows via GitHub Actions (or locally, if preferred).

### What’s implemented
- Secondary source settings with feature parity:
  - `videoSource2`, `udpUrl2`, `tcpUrl2`, `rtspUrl2`
  - `aspectRatio2`, `videoFit2`, `rtspTimeout2`
  - `activeVideoSource` to track which source is live
- Triple‑click on the video view swaps between primary and secondary sources
- Video pipeline uses the active source’s URIs, aspect ratio/fit, and RTSP timeout
- Settings UI updated with “Secondary Connection” and “Secondary Settings”

### How to test the feature
1) Open Settings → General → Video
2) Configure Primary Source (e.g., UDP h.264 5600) and Secondary Source (e.g., UDP h.264 5601)
3) Triple‑click the video view to swap the active source

### Build on macOS (local)
Prereqs: Homebrew CMake, Ninja, Qt 6 (Homebrew), and GStreamer.framework.

```bash
cd "qgroundcontrol"
# Install dependencies (GStreamer + tools)
bash tools/setup/install-dependencies-osx.sh

# Configure & build (uses Qt 6 from Homebrew)
cmake -S . -B build/qt6-macOS -G Ninja -DQt6_DIR="/opt/homebrew/opt/qt/lib/cmake/Qt6"
ninja -C build/qt6-macOS

# Package DMG (ad‑hoc signed by default)
cmake --build build/qt6-macOS --target package
```

Artifacts:
- App: `build/qt6-macOS/QGroundControl.app`
- DMG: `build/qt6-macOS/QGroundControl-*.dmg`

### Build on Windows (GitHub Actions)
This repository includes a ready‑to‑use workflow: `.github/workflows/windows-release.yml`.

Steps:
1) Push branch `dual-video-ci` (or your branch) to GitHub
2) In GitHub → Actions → “Windows Release” → Run workflow
3) Download artifacts (`QGroundControl.exe` and CPack outputs)

See `BUILD_WINDOWS.md` for details.

### Build on Windows (local, optional)
From elevated PowerShell in the repo root:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
./tools/setup/windows-build.ps1 -QtVersion 6.9.2 -Config Release
```

Artifacts:
- `build\qt6-Windows\Release\QGroundControl.exe`
- CPack outputs under `build\qt6-Windows\_CPack_Packages`

### Next actions & direction
- Validate macOS DMG launch and triple‑click source swap
- Trigger the Windows Action run and verify artifacts start video
- If you need code signing/notarization, add signing identities to the mac packaging step and a Windows signing step in the workflow

### 🔗 *Useful Links*

- 🌐 [Official Website](http://qgroundcontrol.com)
- 📘 [User Manual](https://docs.qgroundcontrol.com/en/)
- 🛠️ [Developer Guide](https://dev.qgroundcontrol.com/en/)
- 💬 [Discussion & Support](https://docs.qgroundcontrol.com/en/Support/Support.html)
- 🤝 [Contributing](https://dev.qgroundcontrol.com/en/contribute/)
- 📜 [License Information](https://github.com/mavlink/qgroundcontrol/blob/master/.github/COPYING.md)

---

With QGroundControl, you're in full command of your UAV, ready to take your missions to the next level.
