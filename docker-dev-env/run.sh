#!/usr/bin/env bash
source /etc/os-release 2>/dev/null || true
set -eu

curl -fsSL https://opencode.ai/install | bash -s -- --version "${OPENCODE_VERSION}"

mkdir -p "$HOME/.config/opencode"
cat > "$HOME/.config/opencode/opencode.jsonc" <<EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "mcp": {
    "supabase": {
      "type": "remote",
      "url": "${SUPABASE_MCP_URL}",
      "enabled": true
    }
  }
}
EOF

if ! grep -qs '.opencode/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/.opencode/bin:$PATH"' >> "$HOME/.bashrc"
fi
export PATH="$HOME/.opencode/bin:$PATH"

cd "$HOME"
npx --yes skills add supabase/agent-skills || echo "Warning: failed to install supabase/agent-skills"
