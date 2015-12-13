#import "Engine.Core.classes.h"

@interface SceneAction : NSObject

+ (id<ISceneAction>) createNode:(Node *) node parent:(Node *) parent;
+ (id<ISceneAction>) destroyNode:(Node *) node;
+ (id<ISceneAction>) addComponent:(id<INodeComponent>) component node:(Node *) node;
+ (id<ISceneAction>) removeComponent:(id<INodeComponent>) component node:(Node *) node;

@end
