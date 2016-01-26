#import "Engine.Core.classes.h"

@interface BoundingBox : NSObject

- (BOOL) intersectsSphere:(BoundingSphere *) sphere;

@property (nonatomic, strong) Vector3 *min;
@property (nonatomic, strong) Vector3 *max;

+ (BoundingBox *) boxWithMin:(Vector3 *) min max:(Vector3 *) max;
+ (BoundingBox *) boxWithSize:(Vector3 *) size;
+ (BoundingBox *) boxWithSize:(Vector3 *) size center:(Vector3 *) center;

@end
