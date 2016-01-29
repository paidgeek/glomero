#import "TINR.Glomero.classes.h"

@interface PlayerPhysics : NSObject<INodeComponent, ICollisionListener>

@property (nonatomic) BOOL onGround;

@end
