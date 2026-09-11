# Coding Agent installation prompt

Copy the full prompt below into DeepSeek Harness, Claude Code, Codex, or another coding Agent with filesystem and PowerShell capabilities.

```text
Install and verify this Whale-chan theme for DeepSeek Harness:
https://github.com/online111111/whalechan-dsh-theme

Goal: safely install the theme into the DeepSeek Harness Web GUI that I actually use, preserve reversibility, and complete verification.

Installation choice:
- If `@linxin666/dsh-client-ui-skin-center` or the dsh-web aggregate is already installed, ask whether I prefer the `integrations/dsh-web-skin` Skin Center edition.
- If Skin Center is absent, I explicitly request the standalone edition, or full dynamic permission-menu behavior is required, use the root `install.ps1`.
- Do not install both editions at the same time because their styles would overlap.

Requirements:
1. Inspect the operating system, current working directory, Git, and PowerShell first. Determine real paths with pwd/Get-Location; do not infer them from examples.
2. Clone the repository into a suitable normal directory. If it already exists, inspect its Git status and origin. Use git pull --ff-only only when the worktree is clean and the remote is correct. Never overwrite unrelated files or force-reset local changes.
3. Read README.en.md, install.ps1, verify.ps1, uninstall.ps1, and scripts/Theme.Common.ps1 before execution. Confirm that installation affects only static Web frontend files.
4. On Windows, set the execution policy only for the current PowerShell process:
   Set-ExecutionPolicy -Scope Process Bypass
   Then run .\install.ps1.
5. Let the installer auto-discover the Harness frontend first. If discovery fails, determine the real local layout and use either:
   -HarnessRoot '<directory containing node_modules\@deepseek-ai\dsh-web-frontend>'
   or:
   -DistPath '<full path to dsh-web-frontend\dist>'
6. Do not modify DeepSeek Harness Host/Cordis compositions, Agent presets, sessions, model settings, tool configuration, environment variables, credentials, or user files. Do not start a replacement server. Install only the static theme files declared by this repository.
7. Run .\verify.ps1 after installation. If the existing Harness GUI is running, also run:
   .\verify.ps1 -BaseUrl '<actual Harness URL>'
   Do not assume that the port is 3080.
8. Confirm that index.html contains exactly one data-whalechan-theme="style" tag and one data-whalechan-theme="script" tag, dist\whalechan exists with all referenced assets, window.__DSH_BOOT__ remains present, and unrelated entry content was not removed.
9. If a file sandbox or permission policy denies changes to the installed Harness directory, report the exact denied path, required permission, and reason. Use the client's normal approval flow; do not bypass security boundaries.
10. Do not claim the running page is updated unless you actually refreshed and verified the existing Harness URL. Otherwise tell me to press Ctrl+F5 on the original page.
11. Report the repository location, detected Harness dist path, installer result, every verification result, refresh instructions, and uninstall command.
12. Never print, commit, or upload passwords, tokens, cookies, Git credentials, private conversations, usernames, browser profiles, or other personal information.
```

Chinese version: [`AGENT-INSTALL-PROMPT.zh-CN.md`](AGENT-INSTALL-PROMPT.zh-CN.md).
