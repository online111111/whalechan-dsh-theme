# Whale-chan Harness skin for dsh-web Skin Center

[中文](README.zh.md) | English

This directory contains a declarative Skin Center v2 edition of the Whale-chan theme for the community [dsh-web](https://github.com/zhu1090093659/dsh-web) ecosystem.

It does not modify `dsh-web-frontend/dist/index.html`. Skin Center owns loading, scoping, try-on, activation, persistence, and teardown.

## Prerequisite

Install the Skin Center plugin or the dsh-web aggregate package:

```sh
dsh plugin --profile web add @linxin666/dsh-client-ui-skin-center@latest
# Or: dsh plugin --profile web add @linxin666/dsh-web-all@latest
```

Restart `dsh web` after installing the plugin itself.

## Install the skin

From this repository:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\integrations\dsh-web-skin\install-skin.ps1
```

The script copies the pure asset skin to `$DSH_HOME/skins/whalechan-harness` (default: `~/.dsh/skins/whalechan-harness`). To update an existing copy:

```powershell
.\integrations\dsh-web-skin\install-skin.ps1 -Force
```

If you have a local dsh-web checkout and want its authoritative CLI validation/install path:

```powershell
.\integrations\dsh-web-skin\install-skin.ps1 `
  -DshWebRepository 'D:\path\to\dsh-web' `
  -Force
```

Then open **Settings -> Skin Center**, select **Whale-chan Harness**, and choose Try on or Apply. A manually copied user skin requires no dsh-web restart; reopen Skin Center or refresh the page to update the catalog.

## Validate

From a dsh-web checkout:

```sh
node scripts/dsh-skin validate /path/to/whalechan-dsh-theme/integrations/dsh-web-skin/whalechan-harness
```

The package passes Skin Center v2 validation. `patches.css` intentionally uses several generated-class selectors for fine-grained icon replacement; the validator reports compatibility warnings for those selectors because an upstream frontend rebuild may rename them.

## Declarative compatibility edition

This user-directory edition intentionally contains no `hooks.mjs`. Skin Center does not execute unreviewed user-directory hooks. Therefore:

- theme tokens, branding, tool icons, file icons, controls, status art, and static permission styling are included;
- the standalone floating theme toggle is omitted because Skin Center owns skin switching;
- dynamic permission-menu text tagging from the standalone JavaScript is not used; the CSS retains ordered fallbacks for the standard three permission entries;
- the original standalone installer remains available when the fullest current DOM-specific behavior is preferred without installing dsh-web.

## Uninstall

```powershell
.\integrations\dsh-web-skin\uninstall-skin.ps1
```

Before removing the active skin, select the official theme or another skin in Skin Center.

## Telemetry disclosure

The dsh-web Skin Center documentation states that its browser package sends one anonymous installation heartbeat per UTC day to `dsh-market.com`, containing a random localStorage identifier and the package name. This behavior belongs to Skin Center, not to the Whale-chan skin assets. The standalone Whale-chan installer does not add telemetry.
