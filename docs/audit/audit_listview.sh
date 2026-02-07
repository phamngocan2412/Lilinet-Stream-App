#!/bin/bash

# 🔍 LILINET ListView Performance Auditor
# Checks for inefficient ListView usage

echo "════════════════════════════════════════════════════════════"
echo "🔍 ListView Performance Audit"
echo "════════════════════════════════════════════════════════════"
echo ""

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# 1. Check for ListView without .builder
echo "1️⃣ Checking for ListView() without .builder..."
echo ""

listview_violations=$(grep -rn "ListView(" lib/ --include="*.dart" | \
  grep -v "ListView.builder" | \
  grep -v "ListView.separated" | \
  grep -v "ListView.custom" | \
  grep -v "//" | \
  grep -v "^\s*//" | \
  wc -l)

if [ $listview_violations -eq 0 ]; then
    echo -e "${GREEN}✅ All ListViews use .builder! Good job!${NC}"
else
    echo -e "${RED}❌ Found $listview_violations ListView() without .builder:${NC}"
    echo ""
    grep -rn "ListView(" lib/ --include="*.dart" | \
      grep -v "ListView.builder" | \
      grep -v "ListView.separated" | \
      grep -v "ListView.custom" | \
      grep -v "//" | \
      grep -v "^\s*//" | \
      while read -r line; do
          file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
          line_no=$(echo "$line" | cut -d: -f2)
          echo -e "   ${YELLOW}$file:$line_no${NC}"
      done
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# 2. Check for missing RepaintBoundary
echo ""
echo "2️⃣ Checking for missing RepaintBoundary in lists..."
echo ""

total_builders=$(grep -r "ListView.builder" lib/ --include="*.dart" | wc -l)
repaint_count=$(grep -r "RepaintBoundary" lib/ --include="*.dart" | wc -l)

echo -e "${BLUE}ListView.builder count: $total_builders${NC}"
echo -e "${BLUE}RepaintBoundary count: $repaint_count${NC}"

if [ $total_builders -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No ListView.builder found${NC}"
elif [ $repaint_count -lt $((total_builders / 2)) ]; then
    echo -e "${RED}⚠️  Low RepaintBoundary usage!${NC}"
    echo "   Consider adding RepaintBoundary to complex list items"
else
    echo -e "${GREEN}✅ Good RepaintBoundary usage!${NC}"
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# 3. Check for GridView optimization
echo ""
echo "3️⃣ Checking GridView usage..."
echo ""

gridview_count=$(grep -r "GridView(" lib/ --include="*.dart" | \
  grep -v "GridView.builder" | \
  grep -v "GridView.count" | \
  grep -v "GridView.extent" | \
  grep -v "//" | \
  grep -v "^\s*//" | \
  wc -l)

if [ $gridview_count -eq 0 ]; then
    echo -e "${GREEN}✅ All GridViews use efficient constructors!${NC}"
else
    echo -e "${YELLOW}Found $gridview_count GridView() without .builder/count/extent:${NC}"
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# 4. Check for missing keys
echo ""
echo "4️⃣ Checking for keys in list items..."
echo ""

echo -e "${YELLOW}💡 Manual check required:${NC}"
echo "   Ensure list items have ValueKey() for efficient updates"
echo ""
echo "   Example:"
echo "   ✅ ListView.builder("
echo "         itemBuilder: (ctx, i) => ItemWidget("
echo "           key: ValueKey(items[i].id),"
echo "           item: items[i],"
echo "         ),"
echo "       )"

echo ""
echo "════════════════════════════════════════════════════════════"

# 5. Check for itemExtent
echo ""
echo "5️⃣ Checking for itemExtent usage..."
echo ""

item_extent_count=$(grep -r "itemExtent:" lib/ --include="*.dart" | wc -l)
echo -e "${BLUE}ListView with itemExtent: $item_extent_count${NC}"
echo -e "${YELLOW}💡 itemExtent improves performance for fixed-height items${NC}"

echo ""
echo "════════════════════════════════════════════════════════════"

# Summary
echo ""
echo "📊 SUMMARY"
echo "════════════════════════════════════════════════════════════"
echo ""
total_issues=$((listview_violations + gridview_count))

echo -e "ListView violations:        ${RED}$listview_violations${NC}"
echo -e "ListView.builder count:     ${BLUE}$total_builders${NC}"
echo -e "RepaintBoundary usage:      ${BLUE}$repaint_count${NC}"
echo -e "GridView violations:        ${YELLOW}$gridview_count${NC}"
echo ""

if [ $total_issues -eq 0 ]; then
    echo -e "${GREEN}🎉 EXCELLENT! No list performance issues found!${NC}"
elif [ $total_issues -lt 5 ]; then
    echo -e "${GREEN}⚠️  GOOD: Only minor issues found${NC}"
else
    echo -e "${RED}❌ NEEDS IMPROVEMENT: Multiple issues found${NC}"
fi

echo ""
echo "💡 RECOMMENDATIONS:"
echo ""
cat << 'EOF'
1. Always use ListView.builder for dynamic lists:
   ✅ ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) => ItemWidget(items[i]),
      )

2. Add RepaintBoundary to complex list items:
   ✅ ListView.builder(
        itemBuilder: (ctx, i) => RepaintBoundary(
          child: ComplexItem(items[i]),
        ),
      )

3. Use keys for efficient updates:
   ✅ ListView.builder(
        itemBuilder: (ctx, i) => ItemWidget(
          key: ValueKey(items[i].id),
          item: items[i],
        ),
      )

4. Specify cacheExtent for smoother scrolling:
   ✅ ListView.builder(
        cacheExtent: 100.0,  // Pre-load items
        itemBuilder: ...,
      )

5. Use itemExtent for fixed-height lists:
   ✅ ListView.builder(
        itemExtent: 80.0,  // Fixed height improves performance
        itemBuilder: ...,
      )
EOF

echo ""
echo "════════════════════════════════════════════════════════════"
echo "✅ Audit Complete!"
echo "════════════════════════════════════════════════════════════"
echo ""
