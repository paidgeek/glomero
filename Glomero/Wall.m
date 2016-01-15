#import "Wall.h"

@implementation Wall

@synthesize position, bounds;

- (id) initWithBounds:(ConvexPolygon *)theBounds
{
	self = [super init];
	
	if (self != nil) {
		position = [Vector2 vectorWithX:0.0f y:0.0f];
		bounds = theBounds;
	}
	
	return self;
}

@end
