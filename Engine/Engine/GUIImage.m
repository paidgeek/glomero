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
	Vector3 *tp = node.transform.position;
	
	[spriteBatch draw:sprite.texture
						to:[Vector2 vectorWithX:tp.x y:tp.y]
		 fromRectangle:sprite.rectange
		 tintWithColor:color];
}

@end
