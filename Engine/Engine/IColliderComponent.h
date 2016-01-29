#import "Engine.Core.classes.h"

@protocol IColliderComponent <INodeComponent>

@property (nonatomic, strong) Vector3 *velocity;
@property (nonatomic, strong) id<ICollisionListener> collisionListener;

@end
