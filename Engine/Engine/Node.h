#import "Engine.Core.h"

@interface Node : NSObject

- (id) addComponentOfClass:(Class) componentClass;
- (id) getComponentOfClass:(Class) componentClass;
- (void) removeComponentOfClass:(Class) componentClass;
- (void) removeComponent:(id<INodeComponent>) component;

@property (nonatomic, strong) NSMutableArray *components;
@property (nonatomic, strong) Node *parent;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, strong) Transform *transform;
@property (nonatomic) int layer;
@property (nonatomic) BOOL willBeDestroyed;
@property (nonatomic, strong) NSString *tag;

@end
