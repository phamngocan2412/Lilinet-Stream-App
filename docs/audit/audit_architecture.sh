#!/bin/bash

# 🔍 LILINET Clean Architecture Auditor
# Checks for layer dependency violations

echo "════════════════════════════════════════════════════════════"
echo "🏗️  Clean Architecture Layer Audit"
echo "════════════════════════════════════════════════════════════"
echo ""

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

total_violations=0

# RULE 1: Domain layer should NOT import Flutter
echo "1️⃣ Checking: Domain layer should NOT import Flutter"
echo "   (domain/ should be pure Dart)"
echo ""

domain_flutter=$(grep -r "import 'package:flutter" lib/features/*/domain/ --include="*.dart" 2>/dev/null | wc -l)

if [ $domain_flutter -eq 0 ]; then
    echo -e "${GREEN}✅ Domain layer is pure Dart (no Flutter imports)${NC}"
else
    echo -e "${RED}❌ Found $domain_flutter Flutter imports in domain layer:${NC}"
    echo ""
    grep -rn "import 'package:flutter" lib/features/*/domain/ --include="*.dart"  | head -5 | while read -r2>/dev/null line; do
        file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
        echo -e "   ${YELLOW}$file${NC}"
    done
    total_violations=$((total_violations + domain_flutter))
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# RULE 2: Domain should NOT import Data
echo ""
echo "2️⃣ Checking: Domain layer should NOT import Data layer"
echo "   (domain/ should not know about implementation)"
echo ""

domain_data=$(grep -r "import.*data/" lib/features/*/domain/ --include="*.dart" 2>/dev/null | \
  grep -v "freezed" | \
  grep -v ".g.dart" | \
  wc -l)

if [ $domain_data -eq 0 ]; then
    echo -e "${GREEN}✅ Domain layer independent from Data layer${NC}"
else
    echo -e "${RED}❌ Found $domain_data Data imports in domain layer:${NC}"
    echo ""
    grep -rn "import.*data/" lib/features/*/domain/ --include="*.dart" 2>/dev/null | \
      grep -v "freezed" | \
      grep -v ".g.dart" | \
      head -5 | while read -r line; do
          file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
          echo -e "   ${YELLOW}$file${NC}"
      done
    total_violations=$((total_violations + domain_data))
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# RULE 3: Presentation should NOT import Data models
echo ""
echo "3️⃣ Checking: Presentation should NOT import Data models"
echo "   (should use domain entities instead)"
echo ""

presentation_models=$(grep -r "import.*models/" lib/features/*/presentation/ --include="*.dart" 2>/dev/null | \
  grep -v "bloc" | \
  grep -v ".g.dart" | \
  wc -l)

if [ $presentation_models -eq 0 ]; then
    echo -e "${GREEN}✅ Presentation uses domain entities only${NC}"
else
    echo -e "${YELLOW}⚠️  Found $presentation_models model imports in presentation:${NC}"
    echo ""
    grep -rn "import.*models/" lib/features/*/presentation/ --include="*.dart" 2>/dev/null | \
      grep -v "bloc" | \
      grep -v ".g.dart" | \
      head -5 | while read -r line; do
          file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
          echo -e "   ${YELLOW}$file${NC}"
      done
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# RULE 4: Data should NOT import Presentation
echo ""
echo "4️⃣ Checking: Data layer should NOT import Presentation"
echo ""

data_presentation=$(grep -r "import.*presentation/" lib/features/*/data/ --include="*.dart" 2>/dev/null | wc -l)

if [ $data_presentation -eq 0 ]; then
    echo -e "${GREEN}✅ Data layer independent from Presentation${NC}"
else
    echo -e "${RED}❌ Found $data_presentation Presentation imports in data layer:${NC}"
    echo ""
    grep -rn "import.*presentation/" lib/features/*/data/ --include="*.dart" 2>/dev/null | head -5 | while read -r line; do
        file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
        echo -e "   ${YELLOW}$file${NC}"
      done
    total_violations=$((total_violations + data_presentation))
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# RULE 5: Check for BLoC in domain (anti-pattern)
echo ""
echo "5️⃣ Checking: Domain should NOT contain BLoC/UI logic"
echo ""

domain_bloc=$(grep -r "BlocProvider\|BlocBuilder\|BlocListener" lib/features/*/domain/ --include="*.dart" 2>/dev/null | wc -l)

if [ $domain_bloc -eq 0 ]; then
    echo -e "${GREEN}✅ Domain layer is UI-framework agnostic${NC}"
else
    echo -e "${RED}❌ Found $domain_bloc BLoC references in domain:${NC}"
    echo ""
    grep -rn "BlocProvider\|BlocBuilder\|BlocListener" lib/features/*/domain/ --include="*.dart" 2>/dev/null | head -5 | while read -r line; do
        file=$(echo "$line" | cut -d: -f1 | sed 's|lib/||')
        echo -e "   ${YELLOW}$file${NC}"
      done
    total_violations=$((total_violations + domain_bloc))
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# RULE 6: Check for proper folder structure
echo ""
echo "6️⃣ Checking: Folder structure compliance"
echo ""

features_path="lib/features"
if [ -d "$features_path" ]; then
    feature_count=$(find "$features_path" -maxdepth 1 -type d 2>/dev/null | wc -l)
    echo -e "${BLUE}Found $((feature_count - 1)) features${NC}"

    missing_domain=0
    missing_data=0
    missing_presentation=0

    for feature in "$features_path"/*/; do
        feature_name=$(basename "$feature")

        if [ ! -d "$feature/domain" ]; then
            missing_domain=$((missing_domain + 1))
        fi

        if [ ! -d "$feature/data" ]; then
            missing_data=$((missing_data + 1))
        fi

        if [ ! -d "$feature/presentation" ]; then
            missing_presentation=$((missing_presentation + 1))
        fi
    done

    if [ $missing_domain -eq 0 ] && [ $missing_data -eq 0 ] && [ $missing_presentation -eq 0 ]; then
        echo -e "${GREEN}✅ All features have proper layer structure${NC}"
    else
        echo -e "${YELLOW}Found structural issues:${NC}"
        [ $missing_domain -gt 0 ] && echo -e "   ${YELLOW}Missing domain/: $missing_domain${NC}"
        [ $missing_data -gt 0 ] && echo -e "   ${YELLOW}Missing data/: $missing_data${NC}"
        [ $missing_presentation -gt 0 ] && echo -e "   ${YELLOW}Missing presentation/: $missing_presentation${NC}"
    fi
fi

echo ""
echo "════════════════════════════════════════════════════════════"

# Summary
echo ""
echo "📊 CLEAN ARCHITECTURE SCORE"
echo "════════════════════════════════════════════════════════════"
echo ""

if [ $total_violations -eq 0 ]; then
    score=100
    grade="A+"
    message="🎉 EXCELLENT! Perfect Clean Architecture!"
    color=$GREEN
elif [ $total_violations -le 3 ]; then
    score=90
    grade="A"
    message="👍 VERY GOOD! Minor violations found"
    color=$GREEN
elif [ $total_violations -le 10 ]; then
    score=70
    grade="B"
    message="⚠️  GOOD: Some refactoring needed"
    color=$YELLOW
else
    score=50
    grade="C"
    message="❌ NEEDS IMPROVEMENT: Major refactoring required"
    color=$RED
fi

echo -e "Total Violations: ${RED}$total_violations${NC}"
echo -e "Score: ${color}$score/100${NC}"
echo -e "Grade: ${color}$grade${NC}"
echo ""
echo -e "${color}$message${NC}"
echo ""

# Recommendations
echo "════════════════════════════════════════════════════════════"
echo "💡 RECOMMENDATIONS"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Clean Architecture Rules:"
echo ""
cat << 'EOF'
1. Domain Layer (Pure Business Logic)
   ✅ Only pure Dart code
   ✅ No Flutter imports
   ✅ No external framework dependencies
   ✅ Contains: entities, repositories (contracts), use cases

2. Data Layer (Implementation Details)
   ✅ Implements domain repositories
   ✅ Contains: models, datasources, repository implementations
   ✅ Can import domain layer
   ❌ Cannot import presentation layer

3. Presentation Layer (UI)
   ✅ Contains: pages, widgets, BLoC/Cubit
   ✅ Can import domain layer (entities, use cases)
   ❌ Should not import data models directly
   ❌ Use mappers if needed to convert models to entities

Dependency Flow:
   Presentation → Domain ← Data

   ✅ Presentation depends on Domain
   ✅ Data depends on Domain
   ❌ Domain depends on nothing (except core utilities)
EOF

echo ""
echo "════════════════════════════════════════════════════════════"
echo "✅ Architecture Audit Complete!"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "💡 Next Steps:"
echo "   1. Fix critical violations (domain importing Flutter)"
echo "   2. Refactor presentation to use domain entities"
echo "   3. Ensure data layer is isolated"
echo "   4. Write unit tests for domain layer"
echo ""
