#import "Engine.Core.classes.h"

@interface RemoveComponentAction : NSObject<ISceneAction>

@property (nonatomic, retain) Node *node;
@property (nonatomic, retain) id<INodeComponent> component;

@end
