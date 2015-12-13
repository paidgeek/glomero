#import "Engine.Core.classes.h"

@protocol INodeComponent <NSObject>

- (id) initWithNode:(Node *) theNode;

@property (nonatomic, strong) Node *node;

@optional
- (void) updateWithGameTime:(GameTime *) gameTime;
- (void) onAdd;
- (void) onRemove;

@end
