feature:
	mason make nk_riverpod_feature --feature_name $(name) --local_datasource true --fake_datasource false
	git add .

run:
	flutter run

run-release:
	flutter run --release

format:
	dart format . --set-exit-if-changed

format-fix:
	dart format .

lint:
	flutter analyze --fatal-infos --fatal-warnings

tests:
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html

packages-outdated:
	flutter pub outdated

packages-upgrade:
	flutter pub upgrade

build-runner:
	dart run build_runner build --delete-conflicting-outputs
	make l10n-gen

clean:
	flutter clean
	flutter pub get
	make build-runner
	make l10n-gen


watch-build-runner:
	flutter pub run build_runner watch --delete-conflicting-outputs

l10n:
	flutter gen-l10n --arb-dir lib/features/$(feature)/l10n/arb --template-arb-file $(feature)_de.arb \
		--output-dir lib/features/$(feature)/l10n --output-localization-file $(feature)_localization.dart \
		--no-synthetic-package --no-nullable-getter --format --no-suppress-warnings --output-class $(classname) \
		--required-resource-attributes --untranslated-messages-file=lib/features/$(feature)/l10n/$(feature)_l10n_untranslated.txt
ifneq ($(ci), yes)
	git add **/$(feature)_localization*.dart
endif

l10n-gen:
	make l10n feature=core classname=CoreLocalizations
	make l10n feature=trending classname=TrendingLocalizations

appicon-generate:
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons.yaml

splashscreen-generate:
	flutter pub run flutter_native_splash:create

build-ios:
	@echo "Build iOS"
	make clean
	flutter build ipa -t lib/main.dart --dart-define-from-file=app_config.json --obfuscate --split-debug-info=./dist/debug/ --tree-shake-icons --export-method development --suppress-analytics
	cp build/ios/ipa/tvbuddy.ipa dist/TVBuddy.ipa

build-android-apk:
	@echo "Build APK's"
	make clean
	# flutter build apk --target-platform=android-arm64 --analyze-size
	flutter build apk -t lib/main.dart --dart-define-from-file=app_config.json --target-platform=android-arm,android-arm64 --obfuscate --split-debug-info=./dist/debug/
	cp build/app/outputs/apk/release/app-release.apk dist/
	mv dist/app-release.apk dist/app.apk

build-android-appbundle:
	@echo "Build Store App Bundle"
	make clean
	# flutter build appbundle --analyze-size
	flutter build appbundle -t lib/main.dart --dart-define-from-file=app_config.json --obfuscate --split-debug-info=./dist/debug/
	cp build/app/outputs/bundle/release/app-release.aab dist/
	mv dist/app-release.aab dist/app.aab

release-ios:
	@echo "Release iOS"
	cd ios; bundle exec fastlane deploy

release-android:
	@echo "Release Android"
	cd android; bundle exec fastlane deploy