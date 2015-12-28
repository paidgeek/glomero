#import "Engine.Core.classes.h"

@interface Camera : NSObject<INodeComponent>

- (Matrix *) getViewProjection;

@property (nonatomic, strong) Matrix *projection;
@property (nonatomic, strong) Color *color;

@end
