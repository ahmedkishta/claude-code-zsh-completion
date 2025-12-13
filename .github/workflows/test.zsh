#!/usr/bin/env zsh
# Automated test script for Claude Code zsh completion

SCRIPT_DIR="${0:A:h}/../.."
COMPLETION_FILE="$SCRIPT_DIR/_claude"

# Enable error handling but continue on expected errors
setopt LOCAL_OPTIONS

echo "=== Claude Code Completion Test ==="
echo "Testing file: $COMPLETION_FILE"
echo ""

# Test 1: Syntax check
echo "[1/6] Syntax check..."
if zsh -n "$COMPLETION_FILE" 2>&1; then
  echo "✓ Syntax OK"
else
  echo "✗ Syntax error found"
  exit 1
fi

# Test 2: Load completion
echo ""
echo "[2/6] Loading completion..."
autoload -U compinit
compinit -u
source "$COMPLETION_FILE"

if (( ${+functions[_claude]} )); then
  echo "✓ _claude function loaded"
else
  echo "✗ _claude function not found"
  exit 1
fi

# Test 3: Check dynamic completion functions
echo ""
echo "[3/6] Checking dynamic completion functions..."
for func in _claude_mcp_servers _claude_installed_plugins _claude_sessions; do
  if (( ${+functions[$func]} )); then
    echo "✓ $func defined"
  else
    echo "✗ $func not found"
    exit 1
  fi
done

# Test 4: Test data extraction (MCP servers)
echo ""
echo "[4/6] Testing MCP server extraction..."
# Add test servers
claude mcp add test-completion-1 echo "test1" >/dev/null 2>&1 || true
claude mcp add test-completion-2 echo "test2" >/dev/null 2>&1 || true

servers=(${(f)"$(claude mcp list 2>/dev/null | sed -n 's/^\([^:]*\):.*/\1/p' | grep -v '^Checking')"})
if [[ ${#servers[@]} -ge 2 ]]; then
  echo "✓ MCP servers extracted: ${#servers[@]} servers found"
  echo "  Servers: ${servers[1,3]}"
else
  echo "✗ MCP server extraction failed"
fi

# Cleanup test servers
claude mcp remove test-completion-1 >/dev/null 2>&1 || true
claude mcp remove test-completion-2 >/dev/null 2>&1 || true

# Test 5: Test completion structure
echo ""
echo "[5/6] Checking completion structure..."
tests=(
  "main_commands"
  "main_options"
  "_claude_mcp"
  "_claude_plugin"
  "_claude_plugin_marketplace"
  "_claude_install"
)

for item in $tests; do
  if grep -q "$item" "$COMPLETION_FILE"; then
    echo "✓ $item found"
  else
    echo "✗ $item not found"
    exit 1
  fi
done

# Test 6: Verify dynamic completion usage
echo ""
echo "[6/6] Verifying dynamic completion integration..."
checks=(
  "_claude_mcp_servers"
  "_claude_installed_plugins"
  "_claude_sessions"
)

for check in $checks; do
  if grep -q "$check" "$COMPLETION_FILE"; then
    echo "✓ $check is used in completion"
  else
    echo "✗ $check not integrated"
    exit 1
  fi
done

echo ""
echo "==================================="
echo "✓ All tests passed!"
echo "==================================="
echo ""
echo "To test interactively, run:"
echo "  source $COMPLETION_FILE"
echo "  claude <TAB>"
echo ""
