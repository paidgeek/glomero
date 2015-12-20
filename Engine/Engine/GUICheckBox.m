#import "GUICheckBox.h"
#import "Engine.UI.h"
#import "Retronator.Xni.Framework.Input.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@implementation GUICheckBox {
	int pressedId;
	Sprite *sprite;
}

@synthesize node, normalSprite, checkedSprite, wasChanged, isChecked;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		isChecked = NO;
		wasChanged = NO;
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime inverseView:(Matrix *)inverseView touches:(TouchCollection *)touches {
	if(!touches) {
		return;
	}
	
	Transform *t = node.transform;
	Rectangle *inputArea = [Rectangle rectangleWithX:t.position.x - sprite.pivot.x * t.scale.x
																  y:t.position.y - sprite.pivot.y * t.scale.y
															 width:sprite.rectange.width * t.scale.x
															height:sprite.rectange.height * t.scale.y];
	
	wasChanged = NO;
	
	for(TouchLocation *touch in touches) {
		Vector2 *touchInScene = [Vector2 transform:touch.position with:inverseView];
		XniPoint *point = [XniPoint pointWithX:(int) touchInScene.x y:(int) touchInScene.y];
		
		if([inputArea containsPoint:point] && touch.state != TouchLocationStateInvalid) {
			if(touch.state == TouchLocationStatePressed) {
				pressedId = touch.identifier;
			}
			
			if(touch.identifier == pressedId) {
				if(touch.state == TouchLocationStateReleased) {
					wasChanged = YES;
					isChecked = !isChecked;
					
					sprite = isChecked ? checkedSprite : normalSprite;
				}
			}
		}
	}
}

- (void)drawWithGameTime:(GameTime *)gameTime spriteBatch:(SpriteBatch *)spriteBatch {
	[spriteBatch draw:sprite.texture
						to:[node.transform getWorldPosition]
		 fromRectangle:sprite.rectange
		 tintWithColor:[Color white]
				rotation:[QuaternionExtensions getEulerAngles:node.transform.rotation].z
				  origin:sprite.pivot
					scale:node.transform.scale
				 effects:SpriteEffectsNone
			 layerDepth:0];
}

- (void)setNormalSprite:(Sprite *)theNormalSprite {
	normalSprite = theNormalSprite;
	sprite = normalSprite;
}

@end
