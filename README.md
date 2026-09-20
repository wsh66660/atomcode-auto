# atomcode-auto

atomcode CodingPlan 多账户额度查询与切换工具。查询各账户的 5 小时滚动窗口用量，手动一键切换账户。

## 安装

### macOS / Linux

```bash
curl -fsSL https://wsh66660.github.io/atomcode-auto/install.sh | bash
```

### Windows（PowerShell）

```powershell
irm https://wsh66660.github.io/atomcode-auto/install.ps1 | iex
```

> 前置要求：本机需已安装 [atomcode](https://atomcode.atomgit.com/docs/zh/index.html)。
> 安装脚本会把主脚本下载到 `~/.local/bin/`（与 atomcode 本体同目录，已在 PATH 中，无需额外配置）。

## 使用

### 1. 添加账户（每个账户只需一次）

```bash
atomcode-auto login A    # 自动登出 → 浏览器 OAuth 登录账号 A → 存快照
atomcode-auto login B    # 换下一个账号重复执行
```

### 2. 查看各账户用量

```bash
atomcode-auto status
# 当前: w771920097
#   w771920097  52%  重置 10:45
#   B           100% 重置 12:30
```

### 3. 切换账户

```bash
atomcode-auto use B      # 切到 B，下次启动 atomcode 即生效
atomcode-auto use        # 忘记名字时，列出所有已存账户
```

### 4. 日常启动

```bash
atomcode-auto            # 显示各账户用量后正常启动 atomcode（参数原样透传，如 atomcode-auto -c）
```

## 工作原理

- 每个账户登录后，凭证快照存于 `~/.atomcode/accounts/<名字>.toml`；
- `use` 即把对应快照复制为 `~/.atomcode/auth.toml`；
- 用量数据来自 GitCode 接口 `codingplan_token_usage`（用当前 auth.toml 的 access_token 查询）。

## 注意事项

- `~/.atomcode/accounts/` 下为账号凭证，注意不要外泄该目录；
- token 过期后重新 `atomcode-auto login <名字>` 刷新即可；
- 切换仅对新启动的 atomcode 会话生效，运行中的会话需退出重进；
- 仅适用于 AtomGit CodingPlan（OAuth 登录）方式，不适用于 API Key 方式。

## 文件清单

| 文件 | 说明 |
|------|------|
| `atomcode-auto` | 主脚本（bash，macOS/Linux） |
| `install.sh` | macOS/Linux 一键安装 |
| `install.ps1` | Windows 一键安装 |
