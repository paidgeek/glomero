#import "TINR.Glomero.classes.h"

@interface PlayerPhysics : NSObject<INodeComponent>

@property (nonatomic, strong) Vector3 *velocity;
@property (nonatomic, strong) BoundingSphere *sphere;

@end
