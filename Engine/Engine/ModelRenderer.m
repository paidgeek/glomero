#import "ModelRenderer.h"
#import "Engine.Graphics.h"

@implementation ModelRenderer

@synthesize node, model;

- (id) initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
	}
	
	return self;
}

@end
