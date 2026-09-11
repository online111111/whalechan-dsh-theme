# Whale-chan Theme for DeepSeek Harness

[简体中文](README.md) · **English**

A reversible community fan-art theme for the DeepSeek Harness Web GUI. It adds a marine-blue visual system, Whale-chan-inspired controls and status art, dedicated icons for built-in Harness tools, and a persistent on-page theme toggle.

> **Unofficial community project.** This repository is not affiliated with, endorsed by, or maintained by DeepSeek. “DeepSeek” and related marks belong to their respective owners. The Whale-chan direction references the community **DeepSeek Whale-chan Project** by **Neko3000**; see [`ATTRIBUTION.md`](ATTRIBUTION.md).

## Features and screenshots

The theme replaces or adapts:

- DeepSeek Harness brand mark with Whale-chan riding the black whale;
- workspace, file-manager, composer, session and panel controls;

  <img width="776" height="338" alt="Whale-chan brand, workspace, sidebar, and session controls" src="https://github.com/user-attachments/assets/ef21a590-15bf-4d4e-9382-4c7371aa718a" />

- reasoning, compact/context, tool-call and command surfaces;
- built-in Harness tool icons, while MCP/user-defined tools use one generic tool-call icon;

  <img width="699" height="494" alt="Whale-chan built-in tool and command icons" src="https://github.com/user-attachments/assets/23f4c8b9-1906-4161-b0c6-42244bb8f271" />

- permission levels with separate Read Only, Workspace Write and Full access shields;
- active-session and subagent status indicators without hiding dynamic context-meter data.

  <img width="718" height="227" alt="Whale-chan active-session and subagent status indicators" src="https://github.com/user-attachments/assets/7896c90d-5c96-49e7-8be7-3018c366bb70" />

Functional clarity takes priority: most icons preserve familiar UI silhouettes and add only restrained marine/Whale-chan motifs.

## Requirements

- Windows 10/11;
- Windows PowerShell 5.1 or PowerShell 7+;
- an installed DeepSeek Harness distribution containing `@deepseek-ai/dsh-web-frontend/dist`;
- permission to modify the installed frontend files.

The installer modifies only static Web frontend files. It does **not** change Host configuration, agents, sessions, tools, model settings or conversation data.

## Install with a coding Agent

If you are already using DeepSeek Harness or another coding Agent, copy the ready-made prompt from [`docs/AGENT-INSTALL-PROMPT.md`](docs/AGENT-INSTALL-PROMPT.md). The prompt asks the Agent to clone or update this repository, run the safe installer, locate the active Harness frontend when necessary, verify all assets, and report exactly what changed without touching user data.

## Manual installation

Clone or download this repository, then open PowerShell in its root:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1
```

The installer attempts to locate the active `dsh-web-frontend/dist` automatically. If automatic discovery cannot find it, pass one of the following:

```powershell
# Folder containing node_modules\@deepseek-ai\dsh-web-frontend
.\install.ps1 -HarnessRoot 'D:\path\to\deepseek-harness'

# Or the exact frontend dist directory
.\install.ps1 -DistPath 'D:\path\to\dsh-web-frontend\dist'
```

Refresh the existing Harness page after installation. If the browser cached old assets, press **Ctrl+F5**.

## Update

Pull/download the new release and run `install.ps1` again. Installation is idempotent: existing Whale-chan assets and injection tags are replaced rather than duplicated.

DeepSeek Harness upgrades may replace `node_modules` or the frontend `dist` directory. Re-run `install.ps1` after an upgrade.

## Theme toggle

Use the floating Whale-chan/whale button in the Web GUI to enable or disable the theme. The preference is stored only in the browser under:

```text
dsh.whalechan.theme.enabled
```

Turning the theme off does not uninstall files; it restores native styling immediately through the theme scope.

## Verify installation

Offline file and reference checks:

```powershell
.\verify.ps1
```

Optional live HTTP checks, using the URL of the already-running Harness GUI:

```powershell
.\verify.ps1 -BaseUrl 'http://127.0.0.1:3080'
```

Use `-HarnessRoot` or `-DistPath` with `verify.ps1` when needed.

## Uninstall

```powershell
.\uninstall.ps1
```

Or specify the location explicitly:

```powershell
.\uninstall.ps1 -DistPath 'D:\path\to\dsh-web-frontend\dist'
```

The uninstaller removes only the two Whale-chan tags from `index.html` and the `dist/whalechan` asset directory. It does not restore a potentially stale full-file backup, so it remains safe across Harness upgrades.

## Safety and reversibility

- Every visual override is scoped to `html[data-whalechan-theme="on"]`.
- Installation uses identifiable HTML attributes and removes older unmarked Whale-chan tags before adding the current version.
- `index.html` is written as UTF-8 without BOM through a temporary file.
- The installer does not launch another server or alter `window.__DSH_BOOT__`.
- The theme does not collect telemetry, access credentials, or send network requests.

See [`docs/TECHNICAL.md`](docs/TECHNICAL.md) for implementation and compatibility details.

## Repository layout

```text
.
├── install.ps1             # Safe/idempotent installer
├── uninstall.ps1           # Precise uninstaller
├── verify.ps1              # Offline and optional HTTP validation
├── scripts/
│   └── Theme.Common.ps1    # Shared path discovery and HTML cleanup
├── theme/                   # Ready-to-install runtime assets
├── docs/
│   ├── TECHNICAL.md
│   └── ASSETS-AND-LICENSING.md
├── LICENSE                  # MIT license for project code
├── ATTRIBUTION.md           # Whale-chan attribution and CC BY-NC-SA notice
└── .gitignore
```

The repository intentionally ships ready-to-use runtime assets. End users do not need image-generation services or asset-building software.

## Compatibility

DeepSeek Harness uses generated CSS class names in parts of its frontend. The theme prefers semantic attributes and stable slot/class prefixes where available, but a future upstream UI update may require selector maintenance. Run `verify.ps1`, inspect the UI after Harness upgrades, and open an issue with the Harness version and screenshots if a surface no longer matches.

## Contributing

Please keep additions:

1. reversible under the theme scope;
2. recognizable at 16–18 px;
3. high-DPI friendly (prefer 64/128 px source assets for small rendered icons);
4. free of personal paths, browser profiles, screenshots containing private conversations, credentials and generated audit dumps;
5. respectful of third-party intellectual property and the asset notes in this repository.
