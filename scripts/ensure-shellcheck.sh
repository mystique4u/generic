#!/usr/bin/env bash
# Ensure shellcheck is on PATH (CI parity for local validation).
# Installs a pinned binary to ~/.local/bin when missing (no root required).
set -euo pipefail

if command -v shellcheck &>/dev/null; then
  echo "shellcheck already available: $(command -v shellcheck)"
  shellcheck --version | head -1
  exit 0
fi

VERSION="v0.10.0"
DEST="${HOME}/.local/bin"
mkdir -p "$DEST"

os="$(uname -s | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m)"
case "$arch" in
  x86_64|amd64) arch="x86_64" ;;
  aarch64|arm64) arch="aarch64" ;;
  *)
    echo "Unsupported arch: $arch — install shellcheck manually" >&2
    exit 1
    ;;
esac

case "$os" in
  linux)  asset="shellcheck-${VERSION}.linux.${arch}.tar.xz" ;;
  darwin) asset="shellcheck-${VERSION}.darwin.${arch}.tar.xz" ;;
  *)
    echo "Unsupported OS: $os — install shellcheck manually" >&2
    exit 1
    ;;
esac

url="https://github.com/koalaman/shellcheck/releases/download/${VERSION}/${asset}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Downloading shellcheck ${VERSION}..."
curl -fsSL "$url" -o "$tmp/sc.tgz"
tar -xJf "$tmp/sc.tgz" -C "$tmp"
install -m 755 "$tmp"/shellcheck-*/shellcheck "$DEST/shellcheck"

if ! command -v shellcheck &>/dev/null; then
  echo "Installed to $DEST/shellcheck — add $DEST to PATH" >&2
  echo "export PATH=\"$DEST:\$PATH\"" >&2
  exit 1
fi

echo "shellcheck ready: $(command -v shellcheck)"
