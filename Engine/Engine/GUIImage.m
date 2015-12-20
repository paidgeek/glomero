#import "GUIImage.h"
#import "Engine.UI.h"

@implementation GUIImage

@synthesize node, sprite, color;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		color = [Color white];
	}
	
	return self;
}

- (void)drawWithGameTime:(GameTime *)gameTime spriteBatch:(SpriteBatch *)spriteBatch {
	[spriteBatch draw:sprite.texture
						to:node.transform.position
		 fromRectangle:sprite.rectange
		 tintWithColor:color];
}

@end
