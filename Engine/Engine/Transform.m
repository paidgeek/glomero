#import "Transform.h"

@implementation Transform {
	Vector2 *position;
}

@synthesize position;

- (id) init {
	self = [super init];
	
	if(self) {
		position = [Vector2 vectorWithX:0.0f y:0.0f];
	}
	
	return self;
}

@end
