#import "CircleCollider2D.h"
#import "Engine.Core.h"

@implementation CircleCollider2D

@synthesize position, velocity, mass, radius, coefficientOfRestitution, rigidBody, isTrigger;

- (id) initWithRigidBody:(RigidBody2D *)theRigidBody {
	self = [super init];
	
	if(self) {
		rigidBody = theRigidBody;
		position = [[Vector2 alloc] init];
		velocity = [[Vector2 alloc] initWithX:0.0f y:0.0f];
		mass = 1.0f;
		radius = 20.0f;
		coefficientOfRestitution = 0.5f;
	}
	
	return self;
}

- (void) collidedWithItem:(id)item {
	RigidBody2D *otherBody = ((id<ICollider>) item).rigidBody;
	
	for(id<ICollisionListener> collisionListener in rigidBody.collisionListeners) {
		if([collisionListener respondsToSelector:@selector(onCollideWith:)]) {
			[collisionListener onCollideWith:otherBody];
		}
	}
}

@end
