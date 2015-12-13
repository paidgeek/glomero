#import "SpriteRenderer.h"
#import "Engine.Graphics.h"

@implementation SpriteRenderer

@synthesize node, sprite;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

- (void) drawWithGameTime:(GameTime *)gameTime spriteBatch:(SpriteBatch *)spriteBatch {
	Vector2 *position = [Vector2 subtract:node.transform.position
												  by:[Vector2 vectorWithX:sprite.rectange.width / 2.0f
																				y:sprite.rectange.height / 2.0f]];
	
	[spriteBatch draw:sprite.texture
							to:position
			 fromRectangle:sprite.rectange
			 tintWithColor:[Color white]];
}

@end
