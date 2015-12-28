#import "GUISlider.h"
#import "Engine.UI.h"
#import "Retronator.Xni.Framework.Input.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@implementation GUISlider {
	int pressedId;
}

@synthesize node, background, thumb, value, wasChanged;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		value = 0.5f;
		wasChanged = NO;
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime inverseView:(Matrix *)inverseView touches:(TouchCollection *)touches {
	if(!touches) {
		return;
	}
	
	Transform *t = node.transform;
	Rectangle *inputArea = [Rectangle rectangleWithX:t.position.x - background.pivot.x * t.scale.x
																  y:t.position.y - background.pivot.y * t.scale.y
															 width:background.rectange.width * t.scale.x
															height:background.rectange.height * t.scale.y];
	
	wasChanged = NO;
	
	for(TouchLocation *touch in touches) {
		Vector2 *touchInScene = [Vector2 transform:touch.position with:inverseView];
		XniPoint *point = [XniPoint pointWithX:(int) touchInScene.x y:(int) touchInScene.y];
		
		if([inputArea containsPoint:point] && touch.state != TouchLocationStateInvalid) {
			if(touch.state == TouchLocationStatePressed) {
				pressedId = touch.identifier;
			}
			
			if(touch.identifier == pressedId) {
				if(touch.state == TouchLocationStateMoved) {
					value = (point.x - inputArea.x) / (float) inputArea.width;
				} else if(touch.state == TouchLocationStateReleased) {
					wasChanged = YES;
				}
			}
		}
	}
}

- (void)drawWithGameTime:(GameTime *)gameTime spriteBatch:(SpriteBatch *)spriteBatch {
	Vector2 *pos = [node.transform getWorldPosition];
	Vector2 *thumbPos = [pos copy];
	
	float dx = (value - 0.5f) * background.rectange.width;
	thumbPos.x += dx * node.transform.scale.x;
	
	[spriteBatch draw:background.texture
						to:pos
		 fromRectangle:background.rectange
		 tintWithColor:[Color white]
				rotation:[QuaternionExtensions getEulerAngles:node.transform.rotation].z
				  origin:background.pivot
					scale:node.transform.scale
				 effects:SpriteEffectsNone
			 layerDepth:0];
	[spriteBatch draw:thumb.texture
						to:thumbPos
		 fromRectangle:thumb.rectange
		 tintWithColor:[Color white]
				rotation:[QuaternionExtensions getEulerAngles:node.transform.rotation].z
				  origin:thumb.pivot
					scale:node.transform.scale
				 effects:SpriteEffectsNone
			 layerDepth:1];
}

@end
