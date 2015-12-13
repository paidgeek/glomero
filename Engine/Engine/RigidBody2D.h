#import "Engine.Core.classes.h"
#import "Express.Scene.Objects.h"

@interface RigidBody2D : NSObject<INodeComponent>

- (void) addCollisionListener:(id<ICollisionListener>) collisionListener;

@property (nonatomic, strong) Vector2 *velocity;
@property (nonatomic, strong) id<ICollider> collider;
@property (nonatomic, strong) NSMutableArray *collisionListeners;

@end
