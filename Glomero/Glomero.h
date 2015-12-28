#import "TINR.Glomero.classes.h"

@interface Glomero : Game

- (void) enterScene:(Class) sceneClass;

@property (nonatomic, strong) Scene *currentScene;
@property (nonatomic, strong) TextureAtlas *worldAtlas;
@property (nonatomic, strong) TextureAtlas *entitiesAtlas;
@property (nonatomic, strong) TextureAtlas *uiAtlas;
@property (nonatomic, strong) SpriteFont *font;

+ (Glomero *) getInstance;

@end
