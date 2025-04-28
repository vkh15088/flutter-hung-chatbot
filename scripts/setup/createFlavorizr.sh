#Command: ./scripts/setup/createFlavorizr.sh
dart run flutter_flavorizr -f -p \
assets:download,\
assets:extract,\
android:androidManifest,\
android:flavorizrGradle,\
android:buildGradle,\
android:dummyAssets,\
android:icons,\
flutter:flavors,\
ios:podfile,\
ios:xcconfig,\
ios:buildTargets,\
ios:schema,\
ios:dummyAssets,\
ios:icons,\
ios:plist,\
assets:clean,\
ide:config