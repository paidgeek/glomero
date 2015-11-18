#import "System.h"
#import "Engine.h"

@implementation System

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene {
	self = [super initWithGame:theGame];
	
	if(self) {
		self.scene = theScene;
	}
	
	return self;
}

@end
