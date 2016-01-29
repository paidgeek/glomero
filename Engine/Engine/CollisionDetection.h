#import "Engine.Core.classes.h"

@interface CollisionDetection : NSObject

+ (void) init;

+ (BOOL) detectCollisionBetween:(id<IColliderComponent>) a and:(id<IColliderComponent>) b;
+ (void) resolveCollisionBetween:(id<IColliderComponent>) a and:(id<IColliderComponent>) b;

@end
