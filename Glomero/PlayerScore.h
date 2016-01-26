#import "TINR.Glomero.classes.h"

@interface PlayerScore : NSObject<INodeComponent>

@property (nonatomic) int score;
@property (nonatomic, strong) GUIText *scoreLabel;

@end
