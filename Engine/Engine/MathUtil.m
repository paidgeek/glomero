#import "MathUtil.h"

float clampf(float value, float min, float max) {
	return value < min ? min : (value > max ? max : value);
}
