#import "Engine.Core.classes.h"

@protocol ICollisionListener <NSObject>

@optional
- (void) onCollideWith:(RigidBody2D *) otherRigidBody;
- (void) onTriggerEnter:(RigidBody2D *) otherRigidBody;

@end
