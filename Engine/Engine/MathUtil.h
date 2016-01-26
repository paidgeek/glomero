#import <Foundation/Foundation.h>

float clampf(float value, float min, float max);
float lerpf(float a, float b, float t);

#define TO_RAD(x) ((x) * M_PI / 180.0f)
#define TO_DEG(x) ((x) * 180.0f / M_PI)
