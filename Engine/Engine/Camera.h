#import "Engine.Core.classes.h"

@interface Camera : NSObject<INodeComponent>

@property (nonatomic, strong) Matrix *projection;

@end
