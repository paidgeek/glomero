#import "Engine.Core.classes.h"

@interface AddComponentAction : NSObject<ISceneAction>

@property (nonatomic, retain) Node *node;
@property (nonatomic, retain) id<INodeComponent> component;

@end
