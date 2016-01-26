#import "Engine.Core.classes.h"

@interface Scene : DrawableGameComponent

- (id) initWithGame:(Game *)theGame;
- (Node *) createNode;
- (Node *) createNodeWithParent:(Node *) parent;
- (void) destroyNode:(Node *) node;
- (void) addAction:(id<ISceneAction>) action;
- (void) onExit;

@property (nonatomic, strong) Node *root;
@property (nonatomic, strong) NSMutableArray *sceneListeners;
@property (nonatomic, strong) Camera *mainCamera;
@property (nonatomic, readonly) int drawCount;

+ (Scene *) getInstance;

@end
