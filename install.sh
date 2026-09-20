#!/bin/bash
# atomcode-auto 安装脚本（macOS / Linux）
# 用法: curl -fsSL https://wsh66660.github.io/atomcode-auto/install.sh | bash
set -e

BASE_URL="https://wsh66660.github.io/atomcode-auto"
BIN_DIR="$HOME/local/bin"

mkdir -p "$BIN_DIR"

echo "==> 下载 atomcode-auto 到 $BIN_DIR/"
curl -fsSL "$BASE_URL/atomcode-auto" -o "$BIN_DIR/atomcode-auto"
chmod +x "$BIN_DIR/atomcode-auto"

# ~/local/bin 与 atomcode 本体同目录，默认已在 PATH 中，无需额外配置

# 检查 atomcode 本体
if ! command -v atomcode >/dev/null 2>&1; then
  echo "==> 提示: 未检测到 atomcode，请先安装: https://atomcode.atomgit.com/docs/zh/index.html"
fi

echo "==> 安装完成。首次使用: atomcode-auto login <账户名>"
"$BIN_DIR/atomcode-auto" status || true
