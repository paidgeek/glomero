#import "Engine.Core.classes.h"

@interface Manifold : NSObject

@property (nonatomic, strong) id<IColliderComponent> colliderA, colliderB;
@property (nonatomic, strong) Vector3 *normal;
@property (nonatomic) float penetration;

@end
