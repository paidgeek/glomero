#import "TINR.Glomero.h"

@interface LevelGenerator : NSObject<INodeComponent>

@property (nonatomic) float far;

+ (LevelGenerator *) getInstance;

@end
