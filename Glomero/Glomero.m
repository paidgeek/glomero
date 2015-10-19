#import "Glomero.h"

@implementation Glomero

-(id) init {
	self = [super init];
	
	if(self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
	}
	
	return self;
}

-(void)drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color cornflowerBlue]];
	
	[super drawWithGameTime:gameTime];
}

@end
