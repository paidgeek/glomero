#import "TINR.Glomero.classes.h"

@interface Step : NSObject

@property (nonatomic, strong) Vector2 *position;
@property (nonatomic) float cost;
@property (nonatomic) float heuristic;
@property (nonatomic, strong) Step *parent;
@property (nonatomic) int depth;

- (int) assignParent:(Step *) theParent;

- (id) initWithX:(int) x y:(int) y;

@end
