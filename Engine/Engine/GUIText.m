#import "GUIText.h"
#import "Engine.UI.h"

@interface GUIText ()

- (void) updateOrigin;

@end

@implementation GUIText {
	Vector2 *origin;
}

@synthesize node, font, text, color, horizontalAlign, verticalAlign, scale;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		text = @"GUIText";
		color = [Color white];
		origin = [Vector2 zero];
		scale = [Vector2 vectorWithX:1.0f y:1.0f];
	}
	
	return self;
}

- (void)setFont:(SpriteFont *)theFont {
	font = theFont;
	[self updateOrigin];
}

- (void)setText:(NSString *)theText {
	text = theText;
	[self updateOrigin];
}

- (void)setHorizontalAlign:(HorizontalAlign)theHorizontalAlign {
	horizontalAlign = theHorizontalAlign;
	[self updateOrigin];
}

- (void)setVerticalAlign:(VerticalAlign)theVerticalAlign {
	verticalAlign = theVerticalAlign;
	[self updateOrigin];
}

- (void)drawWithGameTime:(GameTime *)gameTime spriteBatch:(SpriteBatch *)spriteBatch {
	Vector3 *tp = node.transform.position;
	
	Vector2 *pos = [Vector2 vectorWithX:tp.x y:tp.y];
	
	pos.x = (int) roundf(pos.x);
	pos.y = (int) roundf(pos.y);
	
	[spriteBatch drawStringWithSpriteFont:font
												text:text
												  to:pos
									tintWithColor:color
										  rotation:0.0f
											 origin:origin
											  scale:scale
											effects:SpriteEffectsNone
										layerDepth:0];
}

- (void) updateOrigin {
	Vector2 *size = [font measureString:text];
	
	switch (horizontalAlign) {
		case HorizontalAlignLeft:
			origin.x = 0;
			break;
		case HorizontalAlignCenter:
			origin.x = size.x / 2;
			break;
		case HorizontalAlignRight:
			origin.x = size.x;
			break;
	}
	
	switch (verticalAlign) {
		case VerticalAlignTop:
			origin.y = 0;
			break;
		case VerticalAlignMiddle:
			origin.y = size.y / 2;
			break;
		case VerticalAlignBottom:
			origin.y = size.y;
			break;
	}
}

@end
