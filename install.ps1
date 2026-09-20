# atomcode-auto 安装脚本（Windows PowerShell）
# 用法: 在 PowerShell 中执行
#   irm https://wsh66660.github.io/atomcode-auto/install.ps1 | iex
$ErrorActionPreference = "Stop"

$BaseUrl = "https://wsh66660.github.io/atomcode-auto"
$BinDir = Join-Path $HOME "bin"

New-Item -ItemType Directory -Force -Path $BinDir | Out-Null

Write-Host "==> 下载 atomcode-auto 到 $BinDir\"
Invoke-WebRequest -Uri "$BaseUrl/atomcode-auto" -OutFile (Join-Path $BinDir "atomcode-auto")

# 确保 ~/bin 在 PATH（用户级，永久生效）
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$BinDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$BinDir", "User")
    Write-Host "==> 已把 $BinDir 加入用户 PATH，新开终端生效；当前会话请执行:"
    Write-Host "    `$$env:Path = `"$env:Path;$BinDir`""
}

# 检查 atomcode 本体
if (-not (Get-Command atomcode -ErrorAction SilentlyContinue)) {
    Write-Host "==> 提示: 未检测到 atomcode，请先安装: https://atomcode.atomgit.com/docs/zh/index.html"
}

Write-Host "==> 安装完成。首次使用: atomcode-auto login <账户名>"
& (Join-Path $BinDir "atomcode-auto") status
