# CurRatesNetwork

PROJECT_NAME="CurRatesNetwork"

echo "========== iOS archive ========== "

xcodebuild archive \
-scheme ${PROJECT_NAME} \
-destination="iOS" \
-archivePath /tmp/xcf/ios.xcarchive \
-derivedDataPath /tmp/iphoneos \
-sdk iphoneos \
-SKIP_INSTALL=NO

echo "========== iOS Simulator archive ========== "

xcodebuild archive \
-scheme ${PROJECT_NAME} \
-destination="iOS Simulator" \
-archivePath /tmp/xcf/iossimulator.xcarchive \
-derivedDataPath /tmp/iphoneos \
-sdk iphonesimulator SKIP_INSTALL=NO

echo "========== build process... ==========="

xcodebuild build \
-scheme ${PROJECT_NAME} \
-derivedDataPath ./builds/simulator \
-arch x86_64 \
-sdk iphonesimulator

xcodebuild \
-create-xcframework \
-framework /tmp/xcf/ios.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework \
-framework /tmp/xcf/iossimulator.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework \
-output ${PROJECT_NAME}.xcframework