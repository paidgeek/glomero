#import "Engine.Core.classes.h"

@interface QuaternionExtensions : NSObject

+ (int) getGimbalPole:(Quaternion *) q;
+ (Vector3 *) getEulerAngles:(Quaternion *) q;
+ (Quaternion *) slerp:(Quaternion *) a b:(Quaternion *) b t:(float) t;

@end
