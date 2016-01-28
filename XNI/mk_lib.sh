rm libXNI-dev.a libXNI-sim.a libXNI.a
cp /Users/paidgeek/Library/Developer/Xcode/DerivedData/XNI-bykmhzghbhyayrhhwruvooctozlm/Build/Products/Debug-iphoneos/libXNI.a ./libXNI-dev.a
cp /Users/paidgeek/Library/Developer/Xcode/DerivedData/XNI-bykmhzghbhyayrhhwruvooctozlm/Build/Products/Debug-iphonesimulator/libXNI.a ./libXNI-sim.a
lipo -create libXNI-dev.a libXNI-sim.a -output libXNI.a
