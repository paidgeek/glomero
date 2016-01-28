#import "Engine.Core.classes.h"

@interface Collision : NSObject

+ (BOOL) detectCollisionBetween:(id<IColliderComponent>) a and:(id<IColliderComponent>) b;
+ (void) resolveCollisionBetween:(id<IColliderComponent>) a and:(id<IColliderComponent>) b;

@end
