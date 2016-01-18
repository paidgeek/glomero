#import "Engine.Core.classes.h"

@interface Transform : NSObject<INodeComponent>

- (void) translate:(Vector3 *) translation;
- (void) translate:(Vector3 *) translation relativeTo:(Space) relativeTo;
- (void) translateX:(float) x y:(float) y z:(float) z;
- (void) translateX:(float) x y:(float) y z:(float) z relativeTo:(Space) relativeTo;

- (void) rotateAround:(Vector3 *) axis by:(float) angle;
- (void) rotateAround:(Vector3 *) axis by:(float) angle relativeTo:(Space) relativeTo;
- (void) rotateWithQuaternion:(Quaternion *) rotation relativeTo:(Space) relativeTo;

- (void) setParent:(Transform *) parent worldPositionStays:(BOOL) worldPositionStays;

@property (nonatomic, strong) Transform *parent;
@property (nonatomic, strong) Vector3 *position;
@property (nonatomic, strong) Vector3 *localPosition;
@property (nonatomic, strong) Quaternion *rotation;
@property (nonatomic, strong) Quaternion *localRotation;
@property (nonatomic, strong) Vector3 *scale;
@property (nonatomic, strong) Vector3 *localScale;

@property (readonly) Matrix *localToWorld;

@end
