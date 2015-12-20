#import "Engine.Core.classes.h"
#import "Retronator.Xni.Framework.Input.Touch.classes.h"

@protocol IUIComponent <INodeComponent>

@optional
- (void) updateWithGameTime:(GameTime *)gameTime inverseView:(Matrix *) inverseView touches:(TouchCollection *) touches;
- (void) drawWithGameTime:(GameTime *) gameTime spriteBatch:(SpriteBatch *) spriteBatch;

@end
