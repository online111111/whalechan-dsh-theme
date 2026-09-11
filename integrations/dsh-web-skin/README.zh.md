# dsh-web 皮肤中心版 Whale-chan Harness

中文 | [English](README.md)

本目录提供适配社区项目 [dsh-web](https://github.com/zhu1090093659/dsh-web) Skin Center v2 的 Whale-chan 声明式皮肤版本。

该版本不会修改 `dsh-web-frontend/dist/index.html`。皮肤的加载、作用域限定、试穿、应用、持久化和卸载均由皮肤中心管理。

## 前置条件

安装皮肤中心或 dsh-web 全家桶：

```sh
dsh plugin --profile web add @linxin666/dsh-client-ui-skin-center@latest
# 或：dsh plugin --profile web add @linxin666/dsh-web-all@latest
```

首次安装插件本身后，需要由用户重启 `dsh web`。

## 安装皮肤

在本仓库根目录执行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\integrations\dsh-web-skin\install-skin.ps1
```

脚本会把纯资产皮肤复制到 `$DSH_HOME/skins/whalechan-harness`；未设置 `DSH_HOME` 时默认使用 `~/.dsh/skins/whalechan-harness`。

更新已有皮肤：

```powershell
.\integrations\dsh-web-skin\install-skin.ps1 -Force
```

如果本机有 dsh-web 源码仓库，并希望通过其权威 CLI 验证和安装：

```powershell
.\integrations\dsh-web-skin\install-skin.ps1 `
  -DshWebRepository 'D:\path\to\dsh-web' `
  -Force
```

安装后进入 **设置 -> 皮肤中心**，选择 **Whale-chan 鲸鱼娘**，点击试穿或应用。手工安装用户皮肤不要求重启 dsh-web；重新打开皮肤中心或刷新页面即可更新目录。

## 验证

在 dsh-web 源码仓库根目录执行：

```sh
node scripts/dsh-skin validate /path/to/whalechan-dsh-theme/integrations/dsh-web-skin/whalechan-harness
```

当前皮肤已通过 Skin Center v2 验证。`patches.css` 为了精细替换部分图标，保留了若干生成类名选择器；验证器会对此给出兼容性警告，因为未来官方前端重新构建时这些类名可能变化。

## 纯声明式兼容版本

此用户目录版本不包含 `hooks.mjs`。Skin Center 不会执行未经审核的用户目录 Hooks，因此：

- 主题 Token、品牌标志、工具图标、文件图标、控制图标、状态美术和静态权限样式均已保留；
- 不提供独立版右下角浮动开关，因为换肤由皮肤中心接管；
- 不运行独立版 JavaScript 中根据文本动态标记权限菜单的逻辑，标准三档权限仍保留按菜单顺序匹配的 CSS 回退；
- 如果用户不想安装 dsh-web，或希望保留当前最完整的 DOM 动态行为，仍可使用仓库根目录的独立安装器。

## 卸载

```powershell
.\integrations\dsh-web-skin\uninstall-skin.ps1
```

删除正在使用的皮肤前，建议先在皮肤中心切换为官方主题或其他皮肤。

## 遥测披露

dsh-web 皮肤中心文档说明：其浏览器包每天会向 `dsh-market.com` 发送一次匿名安装心跳，只包含随机 localStorage 标识符和包名。该行为属于皮肤中心，而不是 Whale-chan 皮肤资产。Whale-chan 独立安装版本不会增加遥测。
