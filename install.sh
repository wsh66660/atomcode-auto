#!/bin/bash
# atomcode-auto 安装脚本（macOS / Linux）
# 用法: curl -fsSL https://wsh66660.github.io/atomcode-auto/install.sh | bash
set -e

BASE_URL="https://wsh66660.github.io/atomcode-auto"
BIN_DIR="$HOME/bin"

mkdir -p "$BIN_DIR"

echo "==> 下载 atomcode-auto 到 $BIN_DIR/"
curl -fsSL "$BASE_URL/atomcode-auto" -o "$BIN_DIR/atomcode-auto"
chmod +x "$BIN_DIR/atomcode-auto"

# 确保 ~/bin 在 PATH 中
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    SHELL_RC="$HOME/.zshrc"
    [ -n "${BASH_VERSION:-}" ] && [ -f "$HOME/.bashrc" ] && SHELL_RC="$HOME/.bashrc"
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_RC"
    echo "==> 已把 $BIN_DIR 加入 PATH（写入 $SHELL_RC），新终端生效；当前会话请执行:"
    echo "    export PATH=\"$BIN_DIR:\$PATH\""
    ;;
esac

# 检查 atomcode 本体
if ! command -v atomcode >/dev/null 2>&1; then
  echo "==> 提示: 未检测到 atomcode，请先安装: https://atomcode.atomgit.com/docs/zh/index.html"
fi

echo "==> 安装完成。首次使用: atomcode-auto login <账户名>"
"$BIN_DIR/atomcode-auto" status || true
