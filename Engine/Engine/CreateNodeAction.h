#import "Engine.Core.classes.h"

@interface CreateNodeAction : NSObject<ISceneAction>

@property (nonatomic, retain) Node *node;
@property (nonatomic, retain) Node *parent;

@end
