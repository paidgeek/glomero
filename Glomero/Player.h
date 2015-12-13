#import "TINR.Glomero.classes.h"

@interface Player : NSObject<INodeComponent, ICollisionListener>

@property (nonatomic, strong) RigidBody2D *rigidBody;

@end
