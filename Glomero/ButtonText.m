#import "ButtonText.h"

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
		node.transform.position = [Vector2 vectorWithX:0.0f y:-1.5];
	} else {
		node.transform.position = [Vector2 vectorWithX:0.0f y:-3];
	}
}

@end
