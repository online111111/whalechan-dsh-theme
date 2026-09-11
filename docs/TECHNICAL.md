# Technical notes

## Installation model

This project is a static frontend overlay, not a Cordis runtime plugin. `install.ps1` locates the installed `@deepseek-ai/dsh-web-frontend/dist`, copies the ready-to-use `theme/` directory to `dist/whalechan`, and adds two tagged elements:

```html
<link rel="stylesheet" href="/whalechan/whalechan-theme.css" data-whalechan-theme="style">
<script src="/whalechan/whalechan-theme.js" data-whalechan-theme="script"></script>
```

The JavaScript mounts the floating switch, restores the browser-local preference, and tags dynamic permission-menu items so each permission level can receive a distinct icon.

## Location discovery

The shared resolver accepts an exact `-DistPath` or a `-HarnessRoot`, then checks:

1. explicit parameters;
2. `DSH_ROOT` and `DEEPSEEK_HARNESS_ROOT` environment variables;
3. parent directories around the `dsh` command, if it is on `PATH`;
4. the current directory and its ancestors.

A valid target must end in `dist` and contain `index.html`. Explicit `-DistPath` is recommended for uncommon layouts.

## Reversibility

Theme CSS is scoped under:

```css
html[data-whalechan-theme="on"]
```

The toggle changes this one data attribute. Uninstall removes the injected CSS/JS elements and deletes `dist/whalechan`.

The installer deliberately does not depend on a full `index.html` backup. Restoring a stale backup after a Harness upgrade could reference obsolete hashed bundles and break the Web GUI. Precise tag removal is safer.

## Asset policy

Small UI icons are rendered from larger PNG assets and downsampled by the browser into 16–20 px boxes. This avoids the soft appearance produced by scaling an already-small raster image on high-DPI displays.

Dynamic native graphics such as the context token meter remain visible where they encode live state. Theme styling changes color, stroke or surrounding decoration without destroying the underlying data visualization.

## Tool icon routing

Exact built-in Harness tools receive specialized fan-art icons. MCP tools, user-defined tools and unknown tool names intentionally use the generic Tool Call icon. This prevents arbitrary third-party names from accidentally matching unrelated artwork.

## Compatibility boundaries

This theme relies on both semantic DOM attributes and generated class prefixes from the current DeepSeek Harness frontend. Upstream UI releases can rename generated classes or alter component structure. The installation process should remain safe, but individual visual replacements may need selector updates.

## Security and privacy

The runtime JavaScript:

- does not call `fetch` or open network connections;
- does not read conversation content;
- does not access cookies or credentials;
- stores only the theme enabled/disabled preference in `localStorage`;
- observes DOM mutations only to label permission controls rendered by the existing UI.
