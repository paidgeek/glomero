#import "Transform.h"
#import "Engine.Core.h"

@implementation Transform

@synthesize node, position, rotation;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		position = [Vector2 vectorWithX:0.0f y:0.0f];
		rotation = [Quaternion identity];
	}
	
	return self;
}

@end
