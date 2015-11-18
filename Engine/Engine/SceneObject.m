#import "SceneObject.h"
#import "Engine.h"

@implementation SceneObject

- (id) initWithUId:(long)uid {
	self = [super init];
	
	if(self) {
		self.uid = uid;
	}
	
	return self;
}

@end
