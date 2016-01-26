#import "TINR.Glomero.classes.h"

@interface CameraFollow : NSObject<INodeComponent>

@property (nonatomic, strong) Transform *target;

@end
