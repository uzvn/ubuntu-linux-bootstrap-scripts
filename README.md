# Ubuntu Linux Bootstrap Script

## Overview

This repository provides a **post-installation bootstrap provisioning system** for Ubuntu. It allows you to configure a complete workstation (browsers, media tools, messaging apps, dev tools) using **one command**, in a reproducible and version-controlled way.

This approach is commonly referred to as:

* **Bootstrap provisioning**
* **Post-install automation**

It is *not* a custom ISO or unattended OS installer.

---

## Features

* One-command installation
* Modular scripts (APT / Snap / Flatpak)
* Safe re-runs (idempotent)
* Bandwidth-aware mode (for low-bandwidth environments)
* Automatic Timeshift snapshot before changes
* Clean separation between user apps and system dependencies

---

## Repository Structure

```
ubuntu-linux-bootstrap-scripts/
├──post/cleanup.sh        # Clean
├── setup.sh              # Entry point (run this)
├── apt.sh                # APT-based applications
├── snap.sh               # Snap-based applications
├── preflight.sh          # Checks + Timeshift snapshot
└── README.md
├── LICENSE.md
```

---

## Prerequisites

* Ubuntu 24.04 (or compatible)
* Internet connection
* sudo privileges

---

## One‑Command Installation

```bash
curl -fsSL https://raw.githubusercontent.com/uzvn/ubuntu-linux-bootstrap-scripts/main/setup.sh | bash
```

---

## Bandwidth‑Aware Mode (Recommended in DRC)

Low-bandwidth mode disables:

* Large downloads where possible
* Parallel installs

Enable it by exporting an environment variable:

```bash
export LOW_BANDWIDTH=1
```

Then run the installer normally.

---

## What Gets Installed

### Browsers

* Google Chrome (APT – official Google repo)4
* Brave (APT – Brave repo)

### Applications

* MPV instead of VLC
* YACReader (openSUSE Build Service)
* Discord (Snap)
* Telegram Desktop (Snap)

* VSCode
* Android Studio

---

## Safety: Timeshift Snapshot

Before installing anything, the script:

1. Checks if Timeshift is installed
2. Creates a snapshot

This allows full rollback if something goes wrong.

---

## Re‑running the Script

The script is **idempotent**:

* Already installed apps are skipped
* Existing repositories are not duplicated

You can safely re-run it after system updates.

---

## License

MIT License

---

## Notes

* Do not mix Snap / Flatpak / APT for the same application
* Update repository versions when upgrading Ubuntu (e.g. 24.04 → 26.04)

---

## Author

Maintained for personal and professional Ubuntu workstation provisioning.
