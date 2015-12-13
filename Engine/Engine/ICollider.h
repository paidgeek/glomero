#import "Engine.Core.classes.h"

@protocol ICollider <ICoefficientOfRestitution, ICustomCollider>

- (id) initWithRigidBody:(RigidBody2D *) theRigidBody;

@property (nonatomic, strong) RigidBody2D *rigidBody;
@property (nonatomic) BOOL isTrigger;

@end
