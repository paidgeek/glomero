#import "TINR.Glomero.classes.h"

@interface Bullet : NSObject<INodeComponent, ICollisionListener>

@property (nonatomic, strong) Vector2 *direction;

@end
