#!/bin/bash
# kiro-goal-mode installer
# Usage: ./install.sh [target-workspace-path]
# If no path provided, installs to current directory

set -e

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🎯 Installing kiro-goal-mode..."
echo "   Target: $TARGET"

# Create .kiro directories if they don't exist
mkdir -p "$TARGET/.kiro/hooks"
mkdir -p "$TARGET/.kiro/steering"

# Copy hook file
if [ -f "$TARGET/.kiro/hooks/goal-evaluator.kiro.hook" ]; then
  echo "   ⚠️  goal-evaluator.kiro.hook already exists, backing up..."
  cp "$TARGET/.kiro/hooks/goal-evaluator.kiro.hook" "$TARGET/.kiro/hooks/goal-evaluator.kiro.hook.bak"
fi
cp "$SCRIPT_DIR/.kiro/hooks/goal-evaluator.kiro.hook" "$TARGET/.kiro/hooks/"

# Copy steering file
if [ -f "$TARGET/.kiro/steering/goal-mode.md" ]; then
  echo "   ⚠️  goal-mode.md already exists, backing up..."
  cp "$TARGET/.kiro/steering/goal-mode.md" "$TARGET/.kiro/steering/goal-mode.md.bak"
fi
cp "$SCRIPT_DIR/.kiro/steering/goal-mode.md" "$TARGET/.kiro/steering/"

echo ""
echo "✅ Done! Goal mode installed."
echo ""
echo "Usage: In Kiro chat, start with:"
echo '   "Goal: all tests pass and no lint errors"'
echo ""
echo "Kiro will keep working until your condition is met."
