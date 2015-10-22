#import "Sprite.h"

@implementation Sprite

@synthesize texture;
@synthesize rectange;


- (id) initWithRectange: (Rectangle*) rect texture : (Texture2D*) tex {
	self = [super init];
	
	if(self) {
		self.rectange = rect;
		self.texture = tex;
	}
	
	return self;
}

@end
