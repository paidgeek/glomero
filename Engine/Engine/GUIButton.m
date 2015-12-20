#import "GUIButton.h"
#import "Engine.UI.h"
#import "Retronator.Xni.Framework.Input.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@implementation GUIButton {
	int pressedId;
	Sprite *sprite;
}

@synthesize node, normalSprite, pressedSprite, isDown, wasPressed, wasReleased;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime inverseView:(Matrix *)inverseView touches:(TouchCollection *)touches {
	if(!touches) {
		return;
	}

	BOOL wasDown = isDown;
	
	isDown = NO;
	wasPressed = NO;
	wasReleased = NO;

	Transform *t = node.transform;
	Rectangle *inputArea = [Rectangle rectangleWithX:t.position.x - sprite.pivot.x * t.scale.x
																  y:t.position.y - sprite.pivot.y * t.scale.y
															 width:sprite.rectange.width * t.scale.x
															height:sprite.rectange.height * t.scale.y];
	
	for(TouchLocation *touch in touches) {
		Vector2 *touchInScene = [Vector2 transform:touch.position with:inverseView];
		XniPoint *point = [XniPoint pointWithX:(int) touchInScene.x y:(int) touchInScene.y];
		
		if([inputArea containsPoint:point] && touch.state != TouchLocationStateInvalid) {
			if(touch.state == TouchLocationStatePressed) {
				pressedId = touch.identifier;
				wasPressed = YES;
			}
			
			if(touch.identifier == pressedId) {
				if(touch.state == TouchLocationStateReleased) {
					wasReleased = YES;
				} else {
					isDown = YES;
				}
			}
		}
	}

	if(isDown) {
		sprite = pressedSprite;
	} else {
		sprite = normalSprite;
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
