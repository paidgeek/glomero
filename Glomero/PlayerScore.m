#import "PlayerScore.h"
#import "TINR.Glomero.h"

@implementation PlayerScore {
	float timer;
}

@synthesize node, score, scoreLabel;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		node = theNode;
		score = 0;
		timer = 0.0f;
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	timer += gameTime.elapsedGameTime;
	
	if(timer >= 1.0f) {
		timer = 0.0f;
		score++;
		
		scoreLabel.text = [NSString stringWithFormat:@"%d", score];
	}
}

@end
