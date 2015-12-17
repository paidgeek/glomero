#import "Transform.h"
#import "Engine.Core.h"

@implementation Transform

@synthesize node, position, rotationAngle, rotation;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		position = [Vector2 vectorWithX:0.0f y:0.0f];
		rotationAngle = 0.0f;
		rotation = [Quaternion identity];
	}
	
	return self;
}

- (Vector2 *) getWorldPosition {
	if(node.parent == nil) {
		return position;
	} else {
		return [Vector2 add:position to:[node.parent.transform getWorldPosition]];
	}
}

- (void)translate:(Vector2 *)translation {
	[position add:translation];
}

- (void)translateX:(float)x y:(float)y {
	position.x += x;
	position.y += y;
}

- (void) rotateZ:(float)z {
	[rotation multiplyBy:[Quaternion axis:[Vector3 backward] angle:z]];
}

@end
