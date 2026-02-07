#!/bin/bash

# 🔍 LILINET Const Constructor Audit Script
# Finds missing const constructors

echo "════════════════════════════════════════════════════════════"
echo "🔍 Scanning for Missing Const Constructors"
echo "════════════════════════════════════════════════════════════"
echo ""

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Count violations
container_missing=$(grep -r "Container(" lib/ --include="*.dart" | grep -v "const Container" | grep -v "//" | grep -v "^\s*//" | wc -l)
sizedbox_missing=$(grep -r "SizedBox(" lib/ --include="*.dart" | grep -v "const SizedBox" | grep -v "//" | grep -v "^\s*//" | wc -l)
padding_missing=$(grep -r "Padding(" lib/ --include="*.dart" | grep -v "const Padding" | grep -v "//" | grep -v "^\s*//" | wc -l)
text_missing=$(grep -r "Text(" lib/ --include="*.dart" | grep -v "const Text" | grep -v "//" | grep -v "^\s*//" | grep -v "Text.rich" | wc -l)
center_missing=$(grep -r "Center(" lib/ --include="*.dart" | grep -v "const Center" | grep -v "//" | grep -v "^\s*//" | wc -l)
row_missing=$(grep -r "Row(" lib/ --include="*.dart" | grep -v "const Row" | grep -v "//" | grep -v "^\s*//" | wc -l)
column_missing=$(grep -r "Column(" lib/ --include="*.dart" | grep -v "const Column" | grep -v "//" | grep -v "^\s*//" | wc -l)
icon_missing=$(grep -r "Icon(" lib/ --include="*.dart" | grep -v "const Icon" | grep -v "//" | grep -v "^\s*//" | wc -l)
align_missing=$(grep -r "Align(" lib/ --include="*.dart" | grep -v "const Align" | grep -v "//" | grep -v "^\s*//" | wc -l)
flex_missing=$(grep -r "Flex(" lib/ --include="*.dart" | grep -v "const Flex" | grep -v "//" | grep -v "^\s*//" | wc -l)
stack_missing=$(grep -r "Stack(" lib/ --include="*.dart" | grep -v "const Stack" | grep -v "//" | grep -v "^\s*//" | wc -l)
positioned_missing=$(grep -r "Positioned(" lib/ --include="*.dart" | grep -v "const Positioned" | grep -v "//" | grep -v "^\s*//" | wc -l)

total=$((container_missing + sizedbox_missing + padding_missing + text_missing + center_missing + row_missing + column_missing + icon_missing + align_missing + flex_missing + stack_missing + positioned_missing))

echo "📦 Container:        $container_missing"
echo "📏 SizedBox:          $sizedbox_missing"
echo "📐 Padding:          $padding_missing"
echo "📝 Text:              $text_missing"
echo "🎯 Center:            $center_missing"
echo "↔️  Row:               $row_missing"
echo "↕️  Column:            $column_missing"
echo "🖼️  Icon:              $icon_missing"
echo "📍 Align:             $align_missing"
echo "➕ Flex:              $flex_missing"
echo "📚 Stack:             $stack_missing"
echo "📌 Positioned:        $positioned_missing"
echo ""
echo "────────────────────────────────────────────────────────────"
echo "TOTAL: $total potential violations"
echo ""

# Show sample violations
echo "📄 Sample violations (first 15):"
echo ""
grep -r "Container(\|SizedBox(\|Padding(\|Text(\|Center(\|Row(\|Column(\|Icon(" lib/ --include="*.dart" | \
    grep -v "const " | \
    grep -v "//" | \
    head -15 | \
    while read -r line; do
        file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
        line_no=$(echo "$line" | cut -d: -f2)
        echo -e "   ${YELLOW}$file:$line_no${NC}"
        echo "   $line" | head -c 100
        echo ""
    done

echo ""
echo "💡 Why const is important:"
echo "   • Prevents unnecessary widget rebuilds"
echo "   • Reduces memory allocations"
echo "   • Improves scrolling performance"
echo ""
echo "✅ How to fix:"
echo "   • Add 'const' before widget constructors"
echo "   • Exception: Dynamic values (e.g., Text(user.name))"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "✅ Scan Complete!"
echo "════════════════════════════════════════════════════════════"
echo ""
