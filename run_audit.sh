#!/bin/bash

# 🔍 LILINET Master Audit Script
# Runs all code quality and performance audits

clear

echo "
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║          🔍 LILINET COMPREHENSIVE CODE AUDIT 🔍            ║
║                                                            ║
║                    Flutter App Analysis                     ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Check if we're in the right directory
if [ ! -d "lib" ]; then
    echo -e "${RED}❌ Error: 'lib' directory not found!${NC}"
    echo "   Please run this script from your Flutter project root."
    exit 1
fi

# Create output directory for reports
REPORT_DIR="docs/audit/reports"
mkdir -p "$REPORT_DIR"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_FILE="$REPORT_DIR/audit_report_$TIMESTAMP.txt"

echo "" | tee "$REPORT_FILE"
echo "📅 Audit Date: $(date)" | tee -a "$REPORT_FILE"
echo "📁 Project: $(basename $(pwd))" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

# Progress indicator
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local completed=$((width * current / total))
    local remaining=$((width - completed))

    printf "\r["
    printf "%${completed}s" | tr ' ' '█'
    printf "%${remaining}s" | tr ' ' '░'
    printf "] %d%%" $percentage
}

echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Starting comprehensive audit...${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""

# Total steps
TOTAL_STEPS=7
CURRENT_STEP=0

# Step 1: Project Overview
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 1/$TOTAL_STEPS: Project Overview${NC}" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

dart_files=$(find lib -name "*.dart" -type f | wc -l)
total_lines=$(find lib -name "*.dart" -type f -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')
features=$(find lib/features -maxdepth 1 -type d 2>/dev/null | wc -l)

echo "Total Dart Files: $dart_files" | tee -a "$REPORT_FILE"
echo "Total Lines of Code: $total_lines" | tee -a "$REPORT_FILE"
echo "Features Count: $((features - 1))" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

# Step 2: Const Constructor Audit
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 2/$TOTAL_STEPS: Const Constructor Audit${NC}" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

container_missing=$(grep -r "Container(" lib/ --include="*.dart" | grep -v "const Container" | grep -v "//" | grep -v "^\s*//" | wc -l)
sizedbox_missing=$(grep -r "SizedBox(" lib/ --include="*.dart" | grep -v "const SizedBox" | grep -v "//" | grep -v "^\s*//" | wc -l)
padding_missing=$(grep -r "Padding(" lib/ --include="*.dart" | grep -v "const Padding" | grep -v "//" | grep -v "^\s*//" | wc -l)
text_missing=$(grep -r "Text(" lib/ --include="*.dart" | grep -v "const Text" | grep -v "//" | grep -v "^\s*//" | grep -v "Text.rich" | wc -l)
center_missing=$(grep -r "Center(" lib/ --include="*.dart" | grep -v "const Center" | grep -v "//" | grep -v "^\s*//" | wc -l)
row_missing=$(grep -r "Row(" lib/ --include="*.dart" | grep -v "const Row" | grep -v "//" | grep -v "^\s*//" | wc -l)
column_missing=$(grep -r "Column(" lib/ --include="*.dart" | grep -v "const Column" | grep -v "//" | grep -v "^\s*//" | wc -l)
icon_missing=$(grep -r "Icon(" lib/ --include="*.dart" | grep -v "const Icon" | grep -v "//" | grep -v "^\s*//" | wc -l)

const_total=$((container_missing + sizedbox_missing + padding_missing + text_missing + center_missing + row_missing + column_missing + icon_missing))

echo "Missing const Container: $container_missing" | tee -a "$REPORT_FILE"
echo "Missing const SizedBox: $sizedbox_missing" | tee -a "$REPORT_FILE"
echo "Missing const Padding: $padding_missing" | tee -a "$REPORT_FILE"
echo "Missing const Text: $text_missing" | tee -a "$REPORT_FILE"
echo "Missing const Center: $center_missing" | tee -a "$REPORT_FILE"
echo "Missing const Row: $row_missing" | tee -a "$REPORT_FILE"
echo "Missing const Column: $column_missing" | tee -a "$REPORT_FILE"
echo "Missing const Icon: $icon_missing" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"
echo "TOTAL: $const_total potential violations" | tee -a "$REPORT_FILE"

if [ $const_total -lt 50 ]; then
    const_score=90
    echo -e "${GREEN}✅ Good const usage!${NC}" | tee -a "$REPORT_FILE"
elif [ $const_total -lt 100 ]; then
    const_score=70
    echo -e "${YELLOW}⚠️  Moderate const violations${NC}" | tee -a "$REPORT_FILE"
else
    const_score=50
    echo -e "${RED}❌ High const violations - needs improvement${NC}" | tee -a "$REPORT_FILE"
fi

echo "" | tee -a "$REPORT_FILE"

# Step 3: Widget Function Anti-Pattern
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 3/$TOTAL_STEPS: Widget Function Anti-Pattern${NC}" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

widget_functions=$(grep -rn "Widget _build" lib/ --include="*.dart" | wc -l)

echo "Widget-returning functions: $widget_functions" | tee -a "$REPORT_FILE"

if [ $widget_functions -eq 0 ]; then
    widget_score=100
    echo -e "${GREEN}✅ No widget-returning functions!${NC}" | tee -a "$REPORT_FILE"
elif [ $widget_functions -lt 5 ]; then
    widget_score=85
    echo -e "${YELLOW}⚠️  Few widget functions found${NC}" | tee -a "$REPORT_FILE"
else
    widget_score=60
    echo -e "${RED}❌ Too many widget functions - refactor to StatelessWidget${NC}" | tee -a "$REPORT_FILE"
fi

echo "" | tee -a "$REPORT_FILE"

# Step 4: ListView Performance
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 4/$TOTAL_STEPS: ListView Performance${NC}" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

listview_bad=$(grep -rn "ListView(" lib/ --include="*.dart" | grep -v "ListView.builder" | grep -v "ListView.separated" | grep -v "ListView.custom" | grep -v "//" | grep -v "^\s*//" | wc -l)
listview_good=$(grep -r "ListView.builder" lib/ --include="*.dart" | wc -l)
repaint_boundary=$(grep -r "RepaintBoundary" lib/ --include="*.dart" | wc -l)
gridview_bad=$(grep -rn "GridView(" lib/ --include="*.dart" | grep -v "GridView.builder" | grep -v "GridView.count" | grep -v "GridView.extent" | grep -v "//" | grep -v "^\s*//" | wc -l)

echo "ListView (inefficient): $listview_bad" | tee -a "$REPORT_FILE"
echo "ListView.builder: $listview_good" | tee -a "$REPORT_FILE"
echo "RepaintBoundary usage: $repaint_boundary" | tee -a "$REPORT_FILE"
echo "GridView (inefficient): $gridview_bad" | tee -a "$REPORT_FILE"

if [ $listview_bad -eq 0 ] && [ $gridview_bad -eq 0 ]; then
    list_score=100
    echo -e "${GREEN}✅ All lists use .builder!${NC}" | tee -a "$REPORT_FILE"
else
    list_score=$((100 - (listview_bad + gridview_bad) * 5))
    if [ $list_score -lt 50 ]; then list_score=50; fi
    echo -e "${YELLOW}⚠️  $(($listview_bad + $gridview_bad)) lists should use .builder${NC}" | tee -a "$REPORT_FILE"
fi

echo "" | tee -a "$REPORT_FILE"

# Step 5: Clean Architecture
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 5/$TOTAL_STEPS: Clean Architecture${NC}" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

domain_flutter=$(grep -r "import 'package:flutter" lib/features/*/domain/ --include="*.dart" 2>/dev/null | wc -l)
domain_data=$(grep -r "import.*data/" lib/features/*/domain/ --include="*.dart" 2>/dev/null | grep -v "freezed" | grep -v ".g.dart" | wc -l)
data_presentation=$(grep -r "import.*presentation/" lib/features/*/data/ --include="*.dart" 2>/dev/null | wc -l)
domain_bloc=$(grep -r "BlocProvider\|BlocBuilder" lib/features/*/domain/ --include="*.dart" 2>/dev/null | wc -l)

arch_violations=$((domain_flutter + domain_data + data_presentation + domain_bloc))

echo "Domain importing Flutter: $domain_flutter" | tee -a "$REPORT_FILE"
echo "Domain importing Data: $domain_data" | tee -a "$REPORT_FILE"
echo "Data importing Presentation: $data_presentation" | tee -a "$REPORT_FILE"
echo "Domain importing BLoC: $domain_bloc" | tee -a "$REPORT_FILE"
echo "TOTAL violations: $arch_violations" | tee -a "$REPORT_FILE"

if [ $arch_violations -eq 0 ]; then
    arch_score=100
    echo -e "${GREEN}✅ Perfect Clean Architecture!${NC}" | tee -a "$REPORT_FILE"
elif [ $arch_violations -lt 5 ]; then
    arch_score=85
    echo -e "${YELLOW}⚠️  Minor architecture violations${NC}" | tee -a "$REPORT_FILE"
else
    arch_score=60
    echo -e "${RED}❌ Architecture needs refactoring${NC}" | tee -a "$REPORT_FILE"
fi

echo "" | tee -a "$REPORT_FILE"

# Step 6: Code Quality Metrics
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 6/$TOTAL_STEPS: Code Quality Metrics${NC}" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

# Find large files (potential complexity issues)
large_files=$(find lib -name "*.dart" -type f -exec wc -l {} + 2>/dev/null | awk '$1 > 300 {print $2}' | wc -l)

# Find TODO/FIXME
todos=$(grep -r "TODO\|FIXME" lib/ --include="*.dart" | wc -l)

# Find deprecated
deprecated=$(grep -r "deprecated" lib/ --include="*.dart" | wc -l)

# Find async* generators (anti-pattern)
async_star=$(grep -r "async\*" lib/ --include="*.dart" | wc -l)

echo "Files > 300 lines: $large_files" | tee -a "$REPORT_FILE"
echo "TODO/FIXME comments: $todos" | tee -a "$REPORT_FILE"
echo "Deprecated usage: $deprecated" | tee -a "$REPORT_FILE"
echo "async* generators: $async_star" | tee -a "$REPORT_FILE"

echo "" | tee -a "$REPORT_FILE"

# Step 7: Generate Overall Score
CURRENT_STEP=$((CURRENT_STEP + 1))
show_progress $CURRENT_STEP $TOTAL_STEPS
sleep 0.5

echo ""
echo ""
echo -e "${BLUE}📊 Step 7/$TOTAL_STEPS: Calculating Overall Score${NC}"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"

# Calculate overall score (weighted average)
overall_score=$(( (const_score * 20 + widget_score * 25 + list_score * 25 + arch_score * 30) / 100 ))

echo "" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"
echo "                    📊 AUDIT SCORES                          " | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"
echo "Const Usage:          $const_score/100" | tee -a "$REPORT_FILE"
echo "Widget Patterns:      $widget_score/100" | tee -a "$REPORT_FILE"
echo "List Performance:     $list_score/100" | tee -a "$REPORT_FILE"
echo "Architecture:         $arch_score/100" | tee -a "$REPORT_FILE"
echo "────────────────────────────────────────────────────────────" | tee -a "$REPORT_FILE"

if [ $overall_score -ge 90 ]; then
    grade="A+"
    color=$GREEN
    emoji="🎉"
elif [ $overall_score -ge 80 ]; then
    grade="A"
    color=$GREEN
    emoji="👍"
elif [ $overall_score -ge 70 ]; then
    grade="B"
    color=$YELLOW
    emoji="⚠️"
elif [ $overall_score -ge 60 ]; then
    grade="C"
    color=$YELLOW
    emoji="⚠️"
else
    grade="D"
    color=$RED
    emoji="❌"
fi

echo -e "${color}OVERALL SCORE:        $overall_score/100 ($grade) $emoji${NC}" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

# Priority recommendations
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"
echo "                 🎯 PRIORITY ACTIONS                         " | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

priority_count=1

if [ $const_total -gt 50 ]; then
    echo "$priority_count. 🔴 HIGH: Add const to $const_total widgets" | tee -a "$REPORT_FILE"
    priority_count=$((priority_count + 1))
fi

if [ $widget_functions -gt 0 ]; then
    echo "$priority_count. 🔴 HIGH: Convert $widget_functions functions to StatelessWidget" | tee -a "$REPORT_FILE"
    priority_count=$((priority_count + 1))
fi

if [ $listview_bad -gt 0 ] || [ $gridview_bad -gt 0 ]; then
    total_lists=$(($listview_bad + $gridview_bad))
    echo "$priority_count. 🟡 MED: Convert $total_lists lists to .builder" | tee -a "$REPORT_FILE"
    priority_count=$((priority_count + 1))
fi

if [ $arch_violations -gt 0 ]; then
    echo "$priority_count. 🔴 HIGH: Fix $arch_violations architecture violations" | tee -a "$REPORT_FILE"
    priority_count=$((priority_count + 1))
fi

if [ $repaint_boundary -eq 0 ] && [ $listview_good -gt 0 ]; then
    echo "$priority_count. 🟡 MED: Add RepaintBoundary to list items" | tee -a "$REPORT_FILE"
    priority_count=$((priority_count + 1))
fi

if [ $large_files -gt 5 ]; then
    echo "$priority_count. 🟢 LOW: Refactor $large_files large files (>300 lines)" | tee -a "$REPORT_FILE"
    priority_count=$((priority_count + 1))
fi

if [ $todos -gt 20 ]; then
    echo "$priority_count. 🟢 LOW: Address $todos TODO/FIXME comments" | tee -a "$REPORT_FILE"
fi

if [ $async_star -gt 0 ]; then
    echo "$priority_count. 🔴 HIGH: Replace $async_star async* with async" | tee -a "$REPORT_FILE"
fi

echo "" | tee -a "$REPORT_FILE"
echo "════════════════════════════════════════════════════════════" | tee -a "$REPORT_FILE"
echo ""

# Save detailed reports
echo -e "${CYAN}💾 Saving detailed reports...${NC}"

# Create detailed breakdown
{
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "              DETAILED BREAKDOWN"
    echo "════════════════════════════════════════════════════════════"
    echo ""

    echo "Top 10 files with missing const:"
    grep -r "Container(\|SizedBox(\|Padding(\|Text(\|Center(\|Row(\|Column(\|Icon(" lib/ --include="*.dart" | \
      grep -v "const " | \
      grep -v "//" | \
      cut -d: -f1 | \
      sort | \
      uniq -c | \
      sort -rn | \
      head -10

    echo ""
    echo "Widget-returning functions:"
    grep -rn "Widget _build" lib/ --include="*.dart" | head -20

    echo ""
    echo "Inefficient ListViews:"
    grep -rn "ListView(" lib/ --include="*.dart" | \
      grep -v "ListView.builder" | \
      grep -v "//" | \
      head -20

    echo ""
    echo "Inefficient GridViews:"
    grep -rn "GridView(" lib/ --include="*.dart" | \
      grep -v "GridView.builder" | \
      grep -v "GridView.count" | \
      grep -v "GridView.extent" | \
      grep -v "//" | \
      head -20

    echo ""
    echo "Architecture violations:"
    echo "Domain importing Flutter:"
    grep -rn "import 'package:flutter" lib/features/*/domain/ --include="*.dart" 2>/dev/null | head -10

    echo ""
    echo "Domain importing Data:"
    grep -rn "import.*data/" lib/features/*/domain/ --include="*.dart" 2>/dev/null | grep -v "freezed" | grep -v ".g.dart" | head -10

    echo ""
    echo "Large files (>400 lines):"
    find lib -name "*.dart" -type f -exec wc -l {} + 2>/dev/null | awk '$1 > 400 {print $2, $1}' | sort -k2 -rn | head -10

} >> "$REPORT_FILE"

echo ""
echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Audit Complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "📄 Full report saved to: ${CYAN}$REPORT_FILE${NC}"
echo ""
echo "📊 Next steps:"
echo "   1. Review the detailed report"
echo "   2. Address high-priority issues first"
echo "   3. Run individual audit scripts for more details:"
echo "      - ./docs/audit/audit_const.sh"
echo "      - ./docs/audit/audit_widget_functions.sh"
echo "      - ./docs/audit/audit_listview.sh"
echo "      - ./docs/audit/audit_architecture.sh"
echo ""
echo "💡 Run 'flutter analyze' for static analysis"
echo "💡 Run 'flutter test' to ensure no regressions"
echo ""
