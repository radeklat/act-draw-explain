#!/bin/bash
PACKAGE_NAME="act_draw_explain"
OUTPUT_FILE=test/all_imports_test.dart

echo "// Helper file to report uncovered files\n" > $OUTPUT_FILE
echo "// ignore_for_file: unused_import" >> $OUTPUT_FILE

find lib -not -name '*.g.dart' -and -name '*.dart' | \
  cut -c4- | \
  awk -v package=$PACKAGE_NAME '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $OUTPUT_FILE

echo "void main(){}" >> $OUTPUT_FILE

if [[ $1 == "--coverage" ]]; then
  flutter test --coverage
  bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info
else
  flutter test
fi