#import "Engine.Core.classes.h"

@protocol IColliderComponent <INodeComponent>

@property (nonatomic, strong) Vector3 *velocity;
@property (nonatomic, strong) id<ICollisionListener> collisionListener;
@property (nonatomic) BOOL dynamic;
@property (nonatomic) BOOL trigger;

@end
