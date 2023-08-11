generate:
	@echo "Generating Dart classes and backend endpoint methods..."
	python ./openapi-to-dart.py
	@echo "Running build_runner to generate json-serialization code..."
	dart run build_runner build --delete-conflicting-outputs
	@echo "Formatting all generated files..."
	dart format ./lib/model/generated/ ./lib/provider/generated/
