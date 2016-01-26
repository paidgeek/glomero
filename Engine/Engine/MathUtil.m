#import "MathUtil.h"

float clampf(float value, float min, float max) {
	return value < min ? min : (value > max ? max : value);
}

float lerpf(float a, float b, float t) {
	return a + (b - a) * t;
}
