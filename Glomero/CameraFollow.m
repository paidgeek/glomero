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
		offset = [Vector3 vectorWithX:0 y:2 z:5];
		
		node.transform.position = offset;
		[node.transform rotateAround:[Vector3 left] by:-0.3f];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	node.transform.position = [Vector3 add:offset to:target.position];
}

@end
