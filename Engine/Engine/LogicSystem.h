#import "Engine.Core.classes.h"

@interface LogicSystem : GameComponent

- (id) initWithGame:(Game *) theGame scene:(Scene *) theScene;
- (void) updateNode:(Node *) node gameTime:(GameTime *) gameTime;

@end
