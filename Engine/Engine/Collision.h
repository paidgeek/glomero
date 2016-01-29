#import "Engine.Core.classes.h"

@interface Collision : NSObject

- (id) initWithNormal:(Vector3 *) theNormal
			thisCollider:(id<IColliderComponent>) a
		  otherCollider:(id<IColliderComponent>) b;

@property (nonatomic, strong) Vector3 *normal;
@property (nonatomic, strong) id<IColliderComponent> thisCollider;
@property (nonatomic, strong) id<IColliderComponent> otherCollider;

@end
