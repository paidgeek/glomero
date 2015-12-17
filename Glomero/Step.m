#import "Step.h"
#import "TINR.Glomero.h"

@implementation Step

@synthesize cost, heuristic, parent, depth, position;

- (id) init{
	self = [super init];
	
	if(self) {
		position = [Vector2 vectorWithX:0.0f y:0.0f];
	}
	
	return self;
}

- (id) initWithX:(int)x y:(int)y {
	self = [super init];
	
	if(self) {
		position = [Vector2 vectorWithX:x y:y];
	}
	
	return self;
}

- (int)assignParent:(Step *)theParent {
	self.parent = theParent;
	self.depth = self.parent.depth + 1;
	
	return self.depth;
}

- (NSComparisonResult) compare:(Step *) otherStep {
	float f = heuristic + cost;
	float of = otherStep.heuristic + otherStep.cost;
	
	if(f < of) {
		return -1;
	}
	
	if(f > of) {
		return 1;
	}
	
	return 0;
}

@end
