#import "TINR.Glomero.classes.h"

@interface Player : NSObject<INodeComponent>

@property (nonatomic, strong) NSMutableArray *path;

+ (Player *) getInstance;

@end
