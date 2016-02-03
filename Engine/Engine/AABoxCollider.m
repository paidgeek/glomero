#import "AABoxCollider.h"
#import "Engine.Core.h"

@implementation AABoxCollider

@synthesize node, min, max, velocity, collisionListener, dynamic, trigger;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		velocity = [Vector3 zero];
	}
	
	return self;
}

- (Vector3 *)closestPointTo:(Vector3 *)point {
	Vector3 *closest = [Vector3 vectorWithVector:point];

	Vector3 *pos = node.transform.position;
	Vector3 *minp = [Vector3 add:pos to:min];
	Vector3 *maxp = [Vector3 add:pos to:max];
	
	if(closest.x < minp.x) {
		closest.x = minp.x;
	} else if(closest.x > maxp.x) {
		closest.x = maxp.x;
	}
	
	if(closest.y < minp.y) {
		closest.y = minp.y;
	} else if(closest.y > maxp.y) {
		closest.y = maxp.y;
	}
	
	if(closest.z < minp.z) {
		closest.z = minp.z;
	} else if(closest.z > maxp.z) {
		closest.z = maxp.z;
	}
	
	return closest;
}

@end
