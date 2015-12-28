#import "Engine.Core.classes.h"

@interface PlayerPrefs : NSObject

+ (void) load;
+ (void) deleteAll;
+ (void) deleteKey:(NSString *) key;
+ (void) save;
+ (float) getFloatByKey:(NSString *) key defaultValue:(float) value;
+ (int) getIntByKey:(NSString *) key defaultValue:(int) value;
+ (void) setFloatForKey:(NSString *) key value:(float) value;
+ (void) setIntForKey:(NSString *) key value:(int) value;

@end
