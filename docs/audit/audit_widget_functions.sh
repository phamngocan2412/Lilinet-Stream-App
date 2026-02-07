#!/bin/bash

# 🔍 LILINET Widget Function Anti-Pattern Detector
# Finds functions that return widgets instead of using StatelessWidget

echo "════════════════════════════════════════════════════════════"
echo "🔍 Scanning for Widget-Returning Functions (Anti-Pattern)"
echo "════════════════════════════════════════════════════════════"
echo ""

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Find private functions that return Widget
violations=$(grep -rn "Widget _build" lib/ --include="*.dart" | wc -l)

echo "Found $violations Widget-returning functions:"
echo ""

if [ $violations -eq 0 ]; then
    echo -e "${GREEN}✅ No Widget-returning functions found! Great job!${NC}"
else
    # Show all violations with file and line number
    grep -rn "Widget _build" lib/ --include="*.dart" | while read -r line; do
        file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
        line_no=$(echo "$line" | cut -d: -f2)
        func_name=$(echo "$line" | grep -o "_build[A-Za-z0-9_]*" | head -1)

        echo -e "📄 ${YELLOW}$file:$line_no${NC}"
        echo -e "   Function: ${RED}$func_name${NC}"
        echo ""
    done

    echo "════════════════════════════════════════════════════════════"
    echo -e "${RED}❌ TOTAL: $violations widget-returning functions${NC}"
    echo "════════════════════════════════════════════════════════════"
fi

echo ""
echo "💡 Why is this bad?"
echo "   • Functions returning widgets rebuild every time parent rebuilds"
echo "   • Cannot use const constructors"
echo "   • No lifecycle methods (initState, dispose)"
echo "   • Harder to test"
echo "   • Poor separation of concerns"
echo ""
echo "✅ Better Approach:"
echo ""
cat << 'EOF'
// ❌ BAD - Function returning widget
Widget _buildHeader() {
  return Container(child: Text('Header'));
}

// ✅ GOOD - Separate StatelessWidget
class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return const Container(child: Text('Header'));
  }
}
EOF

echo ""
echo "════════════════════════════════════════════════════════════"
echo "✅ Scan Complete!"
echo "════════════════════════════════════════════════════════════"
echo ""
