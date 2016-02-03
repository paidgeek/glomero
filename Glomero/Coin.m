#import "Coin.h"
#import "TINR.Glomero.h"

@implementation Coin

@synthesize node;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		node.tag = @"Coin";
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	[node.transform rotateAround:[Vector3 unitY] by:8.0f * gameTime.elapsedGameTime];
}

@end
