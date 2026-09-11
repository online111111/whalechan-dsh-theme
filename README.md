# DeepSeek Harness Whale-chan 鲸鱼娘主题

**简体中文** · [English](README.en.md)

这是一个面向 DeepSeek Harness Web GUI 的可逆、非官方社区同人主题。它提供海洋蓝视觉系统、Whale-chan 风格控制与状态图标、内置 Harness 工具专属图标，以及可在页面内随时开关的主题按钮。

> **非官方社区项目。** 本仓库不隶属于 DeepSeek，也没有获得 DeepSeek 的维护、认可或背书。“DeepSeek”及相关标识归各自权利方所有。Whale-chan 设计方向参考 Neko3000 的社区 **DeepSeek Whale-chan Project**，详情请阅读 [`ATTRIBUTION.md`](ATTRIBUTION.md)。

## 主要功能和效果展示

本主题会替换或适配：

- DeepSeek Harness 品牌标志：Whale-chan 骑在经典黑色鲸鱼上；
- 工作区、文件管理器、输入区、会话和面板控制图标；
  
  <img width="776" height="338" alt="image" src="https://github.com/user-attachments/assets/ef21a590-15bf-4d4e-9382-4c7371aa718a" />

- 推理、Compact/上下文、Tool Call 和命令卡片；
- Harness 内置工具使用各自专属图标；MCP、用户自定义及未知工具统一使用通用 Tool Call 图标；

  <img width="699" height="494" alt="image" src="https://github.com/user-attachments/assets/23f4c8b9-1906-4161-b0c6-42244bb8f271" />

- Read Only、Workspace Write、Full access 三档权限使用独立护盾；

- 活跃会话和子代理状态图标，同时保留动态上下文计量信息。
  <img width="718" height="227" alt="image" src="https://github.com/user-attachments/assets/7896c90d-5c96-49e7-8be7-3018c366bb70" />


功能辨识度优先：多数图标保留标准 UI 轮廓，只加入克制的 Whale-chan、鲸尾、珍珠和海洋元素。

## 使用 Agent 自动安装（推荐）

如果你正在使用 DeepSeek Harness 或其他编码 Agent，可以把下面这段提示词直接发给 Agent：

```text
请帮我安装并验证这个 DeepSeek Harness Whale-chan 主题：
https://github.com/online111111/whalechan-dsh-theme

要求：
1. 先检查当前操作系统、工作目录、Git 和 PowerShell 是否可用；不要猜测 DeepSeek Harness 的安装路径。
2. 将仓库克隆到一个合适的普通目录；如果已经存在，则检查远程地址并安全更新，不要覆盖我的其他文件。
3. 阅读仓库中的 README.md、install.ps1、verify.ps1 和 uninstall.ps1，确认脚本行为后再执行。
4. 在 Windows PowerShell 中为当前进程临时使用 Bypass，然后运行 install.ps1。优先让脚本自动定位 Harness；若定位失败，再根据本机实际安装位置传入 -HarnessRoot 或 -DistPath。
5. 不要修改 DeepSeek Harness 的 Host 配置、Agent preset、会话数据、模型设置、工具配置或凭据；只允许安装仓库声明的静态 Web 主题文件。
6. 安装后运行 verify.ps1；如果当前 Harness GUI 已经在运行，再使用它的实际 URL运行可选的 -BaseUrl HTTP 验证。不要启动一个替代服务器。
7. 检查 index.html 中 Whale-chan 的 CSS/JS 标签各只有一个，确认 /whalechan 资源完整，并确认 window.__DSH_BOOT__ 仍然保留。
8. 如果遇到权限或沙箱拒绝，说明需要访问的准确路径与原因，按当前环境的授权流程处理；不要绕过安全策略。
9. 最后告诉我：仓库保存位置、检测到的 Harness dist 路径、安装和验证结果、需要怎样刷新页面，以及卸载命令。不要输出任何密码、Token、Cookie 或其他个人信息。
```

也可以复制独立文档中的版本：[`docs/AGENT-INSTALL-PROMPT.zh-CN.md`](docs/AGENT-INSTALL-PROMPT.zh-CN.md)。

## 环境要求

- Windows 10/11；
- Windows PowerShell 5.1 或 PowerShell 7+；
- 已安装 DeepSeek Harness，且安装中包含 `@deepseek-ai/dsh-web-frontend/dist`；
- 当前用户有权修改该前端发布目录。

安装器只修改静态 Web 前端文件，**不会**修改 Host 配置、Agent、会话、工具、模型设置或聊天数据。

## 手动安装

克隆或下载仓库，然后在仓库根目录打开 PowerShell：

```powershell
git clone https://github.com/online111111/whalechan-dsh-theme.git
cd whalechan-dsh-theme
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1
```

安装器会尝试自动查找当前 `dsh-web-frontend/dist`。如果自动定位失败，可以显式指定：

```powershell
# 包含 node_modules\@deepseek-ai\dsh-web-frontend 的目录
.\install.ps1 -HarnessRoot 'D:\path\to\deepseek-harness'

# 或直接指定前端 dist 目录
.\install.ps1 -DistPath 'D:\path\to\dsh-web-frontend\dist'
```

安装后刷新原有 Harness 页面。如果浏览器仍使用旧缓存，请按 **Ctrl+F5**。

## 更新主题

```powershell
git pull --ff-only
.\install.ps1
```

安装过程是幂等的：重复执行不会反复添加 CSS/JS 标签，而会更新已有主题资源。

DeepSeek Harness 更新可能替换 `node_modules` 或前端 `dist`，升级 Harness 后通常需要重新运行一次 `install.ps1`。

## 页面主题开关

页面中的浮动鲸鱼娘/鲸鱼按钮可以临时开启或关闭主题。偏好只保存在当前浏览器的：

```text
dsh.whalechan.theme.enabled
```

关闭开关不会卸载文件，只会通过主题作用域立即恢复原生样式。

## 验证安装

离线检查注入标签和所有静态资源引用：

```powershell
.\verify.ps1
```

如果原来的 Harness GUI 正在运行，可以追加实际访问地址进行 HTTP 检查：

```powershell
.\verify.ps1 -BaseUrl 'http://127.0.0.1:3080'
```

如有需要，`verify.ps1` 同样支持 `-HarnessRoot` 或 `-DistPath`。

## 卸载

```powershell
.\uninstall.ps1
```

特殊安装位置：

```powershell
.\uninstall.ps1 -DistPath 'D:\path\to\dsh-web-frontend\dist'
```

卸载器只移除 `index.html` 中的两个 Whale-chan 标签和 `dist/whalechan` 资源目录。它不会用可能过期的完整 HTML 备份覆盖新版 Harness，因此适合在 Harness 升级后安全卸载。

## 安全性与可逆性

- 所有视觉覆盖均限制在 `html[data-whalechan-theme="on"]` 下；
- 安装器会清理旧主题标签，再写入带标识的新标签，避免重复；
- `index.html` 通过临时文件以 UTF-8 无 BOM 格式写入；
- 不会启动第二个 Web 服务器；
- 不会替换或删除 `window.__DSH_BOOT__`；
- 不收集遥测，不访问凭据，不发送网络请求；
- 安装和卸载均可使用 `verify.ps1` 检查。

技术细节参见 [`docs/TECHNICAL.md`](docs/TECHNICAL.md)。

## 目录结构

```text
.
├── install.ps1                  # 安全、幂等安装器
├── uninstall.ps1                # 精准卸载器
├── verify.ps1                   # 离线及可选 HTTP 验证
├── scripts/
│   └── Theme.Common.ps1         # 路径探测与 HTML 清理公共函数
├── theme/                       # 可直接安装的运行时资源
├── docs/
│   ├── TECHNICAL.md
│   ├── ASSETS-AND-LICENSING.md
│   ├── AGENT-INSTALL-PROMPT.md
│   └── AGENT-INSTALL-PROMPT.zh-CN.md
├── LICENSE                      # 项目代码 MIT 许可证
├── ATTRIBUTION.md               # Whale-chan 署名与 CC BY-NC-SA 说明
└── .gitignore
```

仓库已经包含完整运行时资源，普通用户不需要使用图像生成服务，也不需要重新构建图标。

## 兼容性说明

DeepSeek Harness 的部分前端样式使用构建时生成的类名。本主题尽量优先采用语义属性和稳定的类名前缀，但未来 Harness UI 更新仍可能导致个别选择器需要维护。

升级 Harness 后建议运行 `verify.ps1` 并查看主要界面。如果某个区域不再匹配，请在 Issue 中附上 Harness 版本和经过隐私检查的截图，不要上传私人对话、用户名、路径、Cookie 或凭据。

## 参与贡献

新增内容应满足：

1. 关闭主题或卸载后可以完整恢复；
2. 在 16–18 px 下仍然容易识别；
3. 适配高 DPI，建议小图标使用 64/128 px 来源；
4. 不包含个人路径、浏览器 Profile、私人对话截图、凭据或调试转储；
5. 遵守第三方知识产权及本仓库的美术资源说明。
