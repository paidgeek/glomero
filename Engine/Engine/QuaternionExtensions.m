#import "Engine.Core.h"
#import "QuaternionExtensions.h"

@implementation QuaternionExtensions

+ (int)getGimbalPole:(Quaternion *) q {
	float t = q.y * q.x + q.z * q.w;
	
	return t > 0.5 ? 1 : (t < -0.5f ? -1 : 0);
}

+ (Vector3 *)getEulerAngles:(Quaternion *) q {
	q = [q normalize];
	int pole = [QuaternionExtensions getGimbalPole:q];
	
	float pitch = pole == 0 ? asinf(clampf(2.0f * (q.w * q.x - q.z * q.y), -1.0f, 1.0f)) : (float)pole * M_PI * 0.5f;
	float yaw = pole == 0 ? atan2f(2.0f * (q.y * q.w + q.x * q.z), 1.0f - 2.0f * (q.y * q.y + q.x * q.x)) : 0.0f;
	float roll = pole == 0 ? atan2f(2.0f * (q.w * q.z + q.y * q.x), 1.0f - 2.0f * (q.x * q.x + q.z * q.z)) : (float)pole * 2.0f * atan2f(q.y, q.w);
	
	return [Vector3 vectorWithX:pitch y:yaw z:roll];
}

+ (Quaternion *)slerp:(Quaternion *)a b:(Quaternion *)b t:(float)t {
	float d = a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
	float absDot = fabsf(d);
	
	float scale0 = 1.0f - t;
	float scale1 = t;
	
	if ((1 - absDot) > 0.1) {
		float angle = acosf(absDot);
		float invSinTheta = 1.0f / sinf(angle);
		
		scale0 = (sinf((1.0f - t) * angle) * invSinTheta);
		scale1 = (sinf((t * angle)) * invSinTheta);
	}
	
	if(d < 0.0f) {
		scale1 = -scale1;
	}
	
	return [Quaternion quaternionWithX:(scale0 * a.x) + (scale1 * b.x)
												y:(scale0 * a.y) + (scale1 * b.y)
												z:(scale0 * a.z) + (scale1 * b.z)
												w:(scale0 * a.w) + (scale1 * b.w)];
}

@end
