#import "Collision.h"

@implementation Collision

@synthesize normal, thisCollider, otherCollider;

- (id)initWithNormal:(Vector3 *)theNormal
		  thisCollider:(id<IColliderComponent>)a
		 otherCollider:(id<IColliderComponent>)b {
	self = [super init];
	
	if(self) {
		normal = theNormal;
		thisCollider = a;
		otherCollider = b;
	}
	
	return self;
}

@end
