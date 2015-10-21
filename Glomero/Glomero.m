#import "Glomero.h"

@implementation Glomero

-(id)init {
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

-(void)loadContent {
	worldAtlas = [[TextureAtlas alloc] initWithAtlasPath:@"Images/ui_atlas"
											 texturePath:@""];
	buttonNormal = [worldAtlas getSpriteWithName:@"button_normal"];
}

-(void)drawWithGameTime:(GameTime *)gameTime {
	[self.graphicsDevice clearWithColor:[Color cornflowerBlue]];
	
    [spriteBatch begin];
    
    [spriteBatch draw:buttonNormal.texture
				   to:[Vector2 zero]
		fromRectangle:buttonNormal.rectange
		tintWithColor:[Color white]];
    
    [spriteBatch end];
    
	[super drawWithGameTime:gameTime];
}

@end
