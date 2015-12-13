#import "RigidBody2D.h"
#import "Engine.Core.h"
#import "Express.Physics.h"

@implementation RigidBody2D

@synthesize node, velocity, collisionListeners;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		velocity = [Vector2 vectorWithX:0.0f y:0.0f];
		collisionListeners = [NSMutableArray array];
	}
	
	return self;
}

- (void) addCollisionListener:(id<ICollisionListener>)collisionListener {
	[collisionListeners addObject:collisionListener];
}

@end
