#import "Engine.Graphics.classes.h"

@interface AnimatedSpriteRenderer : NSObject<IDrawableComponent>

- (void) addFrame:(Sprite *) theSprite duration:(NSTimeInterval) theDuration;

@property (nonatomic) BOOL looping;

@end
