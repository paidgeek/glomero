#import "TINR.Glomero.h"
#import "GamePlay.h"

@implementation GamePlay {
	float scoreTimer;
}

static GamePlay *instance;

@synthesize node, score, speed;

- (id)initWithNode:(Node *)theNode {
	self = [super init];
	
	if(self) {
		instance = self;
		node = theNode;
		score = 0;
		scoreTimer = 0.0f;
		speed = INITIAL_SPEED;
	}
	
	return self;
}

- (void)updateWithGameTime:(GameTime *)gameTime {
	scoreTimer += gameTime.elapsedGameTime;
	
	if(scoreTimer >= 1.0f) {
		scoreTimer = 0.0f;
		score++;
	}
}

- (void)endGame {
	[[Glomero getInstance] enterScene:[GameOver class]];
}

+ (GamePlay *)getInstance {
	return instance;
}

@end
