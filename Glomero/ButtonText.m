#import "ButtonText.h"
#import "TINR.Glomero.h"

@implementation ButtonText {
	GUIButton *button;
}

@synthesize node;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

- (void)onAdd {
	button = [node.parent getComponentOfClass:[GUIButton class]];
}

- (void)updateWithGameTime:(GameTime *)gameTime inverseView:(Matrix *)inverseView touches:(TouchCollection *)touches {
	if(button.isDown) {
		node.transform.localPosition = [Vector3 vectorWithX:0.0f y:-1.5 z:0.0f];
	} else {
		node.transform.localPosition = [Vector3 vectorWithX:0.0f y:-3 z:0.0f];
	}
	
	if(button.wasReleased) {
		[[Glomero getInstance].blibSound play];
	}
}

@end
