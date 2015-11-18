#import "Engine.classes.h"

@interface Scene : GameComponent

- (id) initWithGame:(Game *)theGame;

- (SceneObject *) createSceneObject;
- (void) addSceneComponent:(SceneComponent *)sceneComponent toSceneObject:(SceneObject *) sceneObject;
- (SceneComponent *) getSceneComponentOfClass:(Class)sceneComponentClass forSceneObject:(SceneObject *) sceneObject;
- (void) destroySceneObject:(SceneObject *) sceneObject;
- (NSArray *) getSceneObjectsByComponentClass:(Class)sceneComponentClass;

@end
