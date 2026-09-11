# Agent 自动安装提示词（简体中文）

把下面整段提示词复制给 DeepSeek Harness、Claude Code、Codex 或其他具备文件与 PowerShell 操作能力的编码 Agent。

```text
请帮我安装并验证这个 DeepSeek Harness Whale-chan 主题：
https://github.com/online111111/whalechan-dsh-theme

目标：在我当前实际使用的 DeepSeek Harness Web GUI 中安全安装主题，保持可逆，并完成验证。

安装方式选择：
- 如果本机已经安装并使用 `@linxin666/dsh-client-ui-skin-center` 或 dsh-web 全家桶，优先询问我是否使用 `integrations/dsh-web-skin` 的皮肤中心版本；
- 如果没有皮肤中心、我明确要求独立版本，或需要完整动态权限菜单行为，则使用仓库根目录的 `install.ps1`；
- 不要同时安装两种版本，避免样式叠加。

执行要求：
1. 先检查当前操作系统、工作目录、Git 和 PowerShell 是否可用；使用 pwd/Get-Location 确定实际目录，不要根据示例猜测路径。
2. 将仓库克隆到一个合适的普通目录；如果本地已经存在仓库，先检查 Git 状态和 origin，只在工作区干净且远程正确时使用 git pull --ff-only。不要覆盖我的其他文件或强制重置。
3. 阅读 README.md、install.ps1、verify.ps1、uninstall.ps1 和 scripts/Theme.Common.ps1，确认安装只涉及静态 Web 前端后再执行。
4. 在 Windows PowerShell 中仅为当前进程设置执行策略：
   Set-ExecutionPolicy -Scope Process Bypass
   然后运行 .\install.ps1。
5. 优先让安装器自动定位 Harness 前端。如果自动定位失败，再根据本机真实安装结构传入：
   -HarnessRoot '<包含 node_modules\@deepseek-ai\dsh-web-frontend 的目录>'
   或：
   -DistPath '<dsh-web-frontend\dist 的完整路径>'
6. 不要修改 DeepSeek Harness 的 Host composition、Cordis composition、Agent preset、会话数据、模型设置、工具配置、环境变量、凭据或用户文件。不要启动替代服务器。只安装仓库声明的静态主题文件。
7. 安装后运行 .\verify.ps1。如果当前 Harness GUI 已经在运行，再用其实际 URL 执行：
   .\verify.ps1 -BaseUrl '<实际 Harness URL>'
   不要假定端口一定是 3080。
8. 检查并确认：
   - index.html 中 data-whalechan-theme="style" 只有一个；
   - data-whalechan-theme="script" 只有一个；
   - dist\whalechan 目录存在且资源引用完整；
   - window.__DSH_BOOT__ 仍然保留；
   - 没有改变其他 Harness 页面入口内容。
9. 如果文件沙箱或权限策略拒绝修改 Harness 安装目录，准确说明被拒绝的路径、所需权限和原因，按照当前客户端提供的审批流程处理；不要绕过安全边界，也不要用其他方式偷偷修改。
10. 安装成功后不要声称页面已经生效，除非你确实刷新并验证了现有 Harness URL。否则明确告诉我需要在原页面按 Ctrl+F5。
11. 最后汇报：
   - 仓库保存位置；
   - 检测到的 Harness dist 路径；
   - install.ps1 执行结果；
   - verify.ps1 每项检查结果；
   - 页面刷新方法；
   - 对应的卸载命令。
12. 全程不要输出、提交或上传密码、Token、Cookie、Git 凭据、私人对话、用户名、浏览器 Profile 或其他个人信息。
```

## 更新主题提示词

```text
请安全更新已安装的 Whale-chan DeepSeek Harness 主题。找到本地 whalechan-dsh-theme 仓库，先检查工作区和 origin；工作区干净时运行 git pull --ff-only，然后重新运行 install.ps1 和 verify.ps1。不要强制重置，不要覆盖本地修改，不要修改 Harness 的 Host、Agent、会话或模型配置。最后报告更新前后提交号、Harness dist 路径和验证结果。
```

## 卸载主题提示词

```text
请安全卸载 Whale-chan DeepSeek Harness 主题。先找到 whalechan-dsh-theme 仓库并阅读 uninstall.ps1，定位当前实际使用的 dsh-web-frontend\dist，然后执行 uninstall.ps1 和必要的验证。只移除 Whale-chan 注入标签及 dist\whalechan 资源，不要用旧版 index.html 备份覆盖当前 Harness，不要修改 Host、Agent、会话或模型配置。最后报告卸载结果和页面刷新方法。
```
