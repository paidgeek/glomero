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
	Vector3 *tp = node.transform.position;
	Vector2 *pos = [Vector2 vectorWithX:tp.x y:tp.y];
	
	[spriteBatch draw:sprite.texture
						to:pos
		 fromRectangle:sprite.rectange
		 tintWithColor:[Color white]
				rotation:[QuaternionExtensions getEulerAngles:node.transform.rotation].z
				  origin:sprite.pivot
					scale:[Vector2 one]
				 effects:SpriteEffectsNone
			 layerDepth:0];
}

@end
