#import "Engine.Core.classes.h"

@interface Scene : DrawableGameComponent

- (id) initWithGame:(Game *)theGame;
- (Node *) createNode;
- (Node *) createNodeWithParent:(Node *) parent;
- (void) destroyNode:(Node *) node;
- (void) addAction:(id<ISceneAction>) action;

@property (nonatomic, strong) Node *root;
@property (nonatomic, strong) NSMutableArray *sceneListeners;
@property (nonatomic, strong) CollisionMatrix *collisionMatrix;
@property (nonatomic, strong) Camera *mainCamera;

+ (Scene *) getInstance;

@end
