#import "CameraFollow.h"
#import "TINR.Glomero.h"

@implementation CameraFollow {
	Vector3 *offset;
}

@synthesize node, target;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		offset = [Vector3 vectorWithX:0 y:1 z:2.5];
		
		node.transform.position = offset;
		[node.transform rotateAround:[Vector3 left] by:-0.3f];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	Vector3 *t = [Vector3 add:offset to:target.position];
	Vector3 *pos = node.transform.position;
	
	pos.z = t.z;
	pos.y = t.y;
	//pos.y = lerpf(pos.y, t.y, 7.0f * gameTime.elapsedGameTime);
	pos.x = lerpf(pos.x, t.x, 7.0f * gameTime.elapsedGameTime);
	
	node.transform.position = pos;
}

@end
