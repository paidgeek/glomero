#import "Turret.h"
#import "TINR.Glomero.h"

@implementation Turret

@synthesize node;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

@end
