#import "Engine.Core.classes.h"

@interface RenderSystem : DrawableGameComponent

- (id) initWithGame:(Game *) theGame scene:(Scene *) theScene;
- (void) drawNode:(Node *) node gameTime:(GameTime *) gameTime;

@end
