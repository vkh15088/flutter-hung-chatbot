#Command: ./scripts/setup/updateFlavorizr.sh
dart run flutter_flavorizr -f -p \
assets:download,\
assets:extract,\
android:flavorizrGradle,\
android:dummyAssets,\
android:icons,\
flutter:flavors,\
ios:podfile,\
ios:xcconfig,\
ios:buildTargets,\
ios:schema,\
ios:dummyAssets,\
ios:icons,\
assets:clean,\
ide:config