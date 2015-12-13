#import "Engine.Core.classes.h"

@interface PhysicsSystem : GameComponent<ISceneListener>

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene;

@end
