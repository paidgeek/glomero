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
	[spriteBatch draw:sprite.texture
						to:[node.transform getWorldPosition]
		 fromRectangle:sprite.rectange
		 tintWithColor:[Color white]
				rotation:[QuaternionExtensions getEulerAngles:node.transform.rotation].z
				  origin:sprite.pivot
					scale:[Vector2 one]
				 effects:SpriteEffectsNone
			 layerDepth:0];
}

@end
