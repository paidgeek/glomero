#import "TINR.Glomero.classes.h"

#define INITIAL_SPEED 6.0f

@interface GamePlay : NSObject<INodeComponent>

- (void) endGame;

@property (nonatomic) int score;
@property (nonatomic) float speed;

+ (GamePlay *) getInstance;

@end
