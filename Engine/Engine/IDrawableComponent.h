#import "Engine.Core.classes.h"

@protocol IDrawableComponent <INodeComponent>

- (void) drawWithGameTime:(GameTime *) gameTime spriteBatch:(SpriteBatch *) spriteBatch;

@end
