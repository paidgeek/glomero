#import "SphereCollider.h"
#import "Engine.Core.h"

@implementation SphereCollider

@synthesize node, radius, velocity, collisionListener, dynamic, trigger;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		velocity = [Vector3 zero];
	}
	
	return self;
}

@end
