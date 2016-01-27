#import "Engine.Core.classes.h"

@interface Collision : NSObject

+ (BOOL) detectCollisionBetween:(id) a and:(id) b;
+ (void) resolveCollisionBetween:(id) a and:(id) b;

@end
