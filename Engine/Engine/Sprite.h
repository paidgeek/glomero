#import "Engine.Graphics.classes.h"

@interface Sprite : NSObject

@property (nonatomic, strong) Texture2D *texture;
@property (nonatomic, strong) Rectangle *rectange;
@property (nonatomic) SpriteEffects effects;

@end
