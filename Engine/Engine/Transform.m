#import "Transform.h"
#import "Engine.Core.h"

@implementation Transform

@synthesize node, position, rotationAngle, rotation, scale;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		position = [Vector2 vectorWithX:0.0f y:0.0f];
		rotationAngle = 0.0f;
		rotation = [Quaternion identity];
		scale = [Vector2 vectorWithX:1.0f y:1.0f];
	}
	
	return self;
}

- (Vector2 *) getWorldPosition {
	if(node.parent == nil) {
		return position;
	} else {
		Vector2 *pos = [position copy];
		
		pos.x *= node.parent.transform.scale.x;
		pos.y *= node.parent.transform.scale.y;
		
		return [Vector2 add:pos
							  to:[node.parent.transform getWorldPosition]];
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

- (Vector2 *)transformPoint:(Vector2 *)point {
	Vector2 *tp = [Vector2 zero];

	tp.x = position.x + point.x * scale.x;
	tp.y = position.y + point.y * scale.y;
	
	return tp;
}

@end
