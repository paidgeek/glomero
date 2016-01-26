#import "Engine.Core.classes.h"

@interface Plane : NSObject

- (id) initWithNormal:(Vector3 *) theNormal d:(float) theD;
- (Plane *) normalize;

@property (nonatomic) float d;
@property (nonatomic, strong) Vector3 *normal;

+ (Plane *)planeWithNormalX:(float)x y:(float)y z:(float)z d:(float) d;

@end
