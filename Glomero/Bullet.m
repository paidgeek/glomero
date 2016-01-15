#import "Bullet.h"
#import "TINR.Glomero.h"

@implementation Bullet {
	RigidBody2D *body;
}

@synthesize node, direction;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if (self) {
		node = theNode;
	}
	
	return self;
}

- (void)onAdd {
	body = [node getComponentOfClass:[RigidBody2D class]];
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	body.velocity = [Vector2 multiply:direction by:300.0f];
}

- (void)onTriggerEnter:(RigidBody2D *)otherRigidBody {
	[[Scene getInstance] destroyNode:node];
	[[Glomero getInstance].hitSound play];
}

@end
