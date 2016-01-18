#import "Engine.Core.classes.h"

@interface Camera : NSObject<INodeComponent>

- (Vector3 *) viewportPointFromWorld:(Vector3 *) worldPosition;

@property (nonatomic, strong) Matrix *projection;
@property (readonly) Matrix *view;
@property (readonly) Matrix *viewProjection;
@property (nonatomic, strong) Color *clearColor;

@end
