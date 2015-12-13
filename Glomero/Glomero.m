#import "Glomero.h"
#import "TINR.Glomero.h"

@implementation Glomero

- (id) init {
	self = [super init];
	
	if(self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];

		mainScene = [[MainScene alloc] initWithGame:self];
	}
	
	return self;
}

@end
