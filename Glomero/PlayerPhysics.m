#import "PlayerPhysics.h"
#import "TINR.Glomero.h"

@implementation PlayerPhysics

@synthesize node;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform rotateAround:[Vector3 unitY] by:5.0f * gameTime.elapsedGameTime];
}

@end
