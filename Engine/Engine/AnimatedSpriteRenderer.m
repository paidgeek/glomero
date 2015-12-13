#import "AnimatedSpriteRenderer.h"
#import "Engine.Graphics.h"

// Begin AnimatedSpriteFrame
@interface AnimatedSpriteFrame : NSObject

@property (nonatomic, strong) Sprite *sprite;
@property (nonatomic) NSTimeInterval duration;

@end

@implementation AnimatedSpriteFrame

@synthesize sprite, duration;

@end
// End AnimatedSpriteFrame

@implementation AnimatedSpriteRenderer {
	NSMutableArray *frames;
	int currentFrameIndex;
	AnimatedSpriteFrame *currentFrame;
	float timer;
}

@synthesize node;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		frames = [NSMutableArray array];
		currentFrameIndex = arc4random_uniform(6);
	}
	
	return self;
}

- (void) addFrame:(Sprite *)theSprite duration:(NSTimeInterval)theDuration {
	AnimatedSpriteFrame *frame = [[AnimatedSpriteFrame alloc] init];
	
	frame.sprite = theSprite;
	frame.duration = theDuration;
	
	[frames addObject:frame];
	
	if(currentFrame == nil) {
		currentFrame = frame;
	}
}

- (void) updateWithGameTime:(GameTime *)gameTime {
	timer += gameTime.elapsedGameTime;
	
	if(timer >= currentFrame.duration) {
		timer = 0.0f;
		currentFrameIndex = (currentFrameIndex + 1) % [frames count];
		currentFrame = [frames objectAtIndex:currentFrameIndex];
	}
}

- (void) drawWithGameTime:(GameTime *)gameTime spriteBatch:(SpriteBatch *)spriteBatch {
	Sprite *sprite = currentFrame.sprite;
	Vector2 *position = [Vector2 subtract:node.transform.position
												  by:[Vector2 vectorWithX:sprite.rectange.width / 2.0f
																				y:sprite.rectange.height / 2.0f]];
	
	[spriteBatch draw:sprite.texture
						to:position
		 fromRectangle:sprite.rectange
		 tintWithColor:[Color white]
				rotation:0.0f
				  origin:nil
					scaleUniform:1.0f
				 effects:sprite.effects
			 layerDepth:0.0f];
}

@end
