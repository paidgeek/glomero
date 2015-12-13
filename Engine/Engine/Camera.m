#import "Camera.h"
#import "Engine.Core.h"

@interface Camera ()

- (void) resize;

@end

@implementation Camera

@synthesize node, projection;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		projection = [Matrix identity];
		[self resize];
	}
	
	return self;
}

- (void) resize {
	float width = [Scene getInstance].game.gameWindow.clientBounds.width;
	float height = [Scene getInstance].game.gameWindow.clientBounds.height;

	[projection set:[Matrix createScaleX:1.0f y:1.0f z:1.0f]];
}

@end
