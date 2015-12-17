#import "Box.h"
#import "TINR.Glomero.h"

@implementation Box

@synthesize width, height, position, mass, velocity;

- (id) init {
	self = [super init];
	
	if(self) {
		position = [Vector2 vectorWithX:0.0f y:0.0f];
		velocity = [Vector2 vectorWithX:0.0f y:0.0f];
	}
	
	return self;
}

@end
