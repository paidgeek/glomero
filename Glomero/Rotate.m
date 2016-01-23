#import "TINR.Glomero.h"
#import "Rotate.h"

@implementation Rotate {
	Vector3 *axis;
}

@synthesize node;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		axis = [[Vector3 vectorWithX:[Random float]-0.5f y:[Random float]-0.5f z:[Random float]-0.5f] normalize];
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	node.transform.localRotation = [[Quaternion axis:axis angle:gameTime.totalGameTime] normalize];
}

@end
