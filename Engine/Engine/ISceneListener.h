#import "Engine.Core.classes.h"

@protocol ISceneListener <NSObject>

@optional
- (void) onCreateNode:(Node *) node;
- (void) onDestroyNode:(Node *) node;
- (void) onAddComponent:(id<INodeComponent>) component to:(Node *) node;
- (void) onRemoveComponent:(id<INodeComponent>) component from:(Node *) node;

@end
