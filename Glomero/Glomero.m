#import "Glomero.h"

@implementation Glomero

-(id) init {
	self = [super init];
	
	if(self) {
		graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
	}
	
	return self;
}

-(void)initialize {
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
    
    [super initialize];
}

-(void) loadContent {
    texture = [self.content load:@"PNG/background.png"];
}

-(void)drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color cornflowerBlue]];
	
    [spriteBatch begin];
    
    [spriteBatch draw:texture to:[Vector2 zero] fromRectangle:nil tintWithColor:[Color white]];
    
    [spriteBatch end];
    
	[super drawWithGameTime:gameTime];
}

@end
