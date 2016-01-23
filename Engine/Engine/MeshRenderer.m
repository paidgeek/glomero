#import "Engine.Graphics.h"
#import "MeshRenderer.h"

@implementation MeshRenderer

@synthesize node, effect, mesh;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

@end
