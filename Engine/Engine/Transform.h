#import "Engine.Core.classes.h"

@interface Transform : NSObject<INodeComponent, IPosition>

@property (nonatomic, strong) Vector2 *position;
@property (nonatomic, strong) Quaternion *rotation;

@end
