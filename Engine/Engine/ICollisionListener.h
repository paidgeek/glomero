#import "Engine.Core.classes.h"
#import "IColliderComponent.h"

@protocol ICollisionListener <NSObject>

@optional
- (void) onCollisionEnter:(id<IColliderComponent>) collider normal:(Vector3 *) normal;
- (void) onCollisionStay:(id<IColliderComponent>) collider;
- (void) onCollisionExit:(id<IColliderComponent>) collider;

@end
