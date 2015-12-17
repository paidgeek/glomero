#import "Poly.h"

@implementation Poly

@synthesize velocity, mass, coefficientOfRestitution, position, height, width, rotationAngle;

- (id) init{
	self = [super init];
	
	if(self) {
		velocity = [Vector2 vectorWithX:0.0f y:0.0f];
		position = [Vector2 vectorWithX:0.0f y:0.0f];
	}
	
	return self;
}

@end
