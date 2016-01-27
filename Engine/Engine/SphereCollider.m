#import "SphereCollider.h"
#import "Engine.Core.h"

@implementation SphereCollider

@synthesize node, radius, velocity;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		radius = 1.0f;
		velocity = [Vector3 zero];
	}
	
	return self;
}

@end
