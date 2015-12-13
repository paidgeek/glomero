#import "Engine.Graphics.classes.h"

@interface TextureAtlas : NSObject

- (id) initWithTexture:(Texture2D *) theTexture sprites:(NSMutableDictionary *) theSprites;
- (Sprite *) getSpriteWithName:(NSString *) name;

@property (nonatomic, strong) Texture2D *texture;

+ (TextureAtlas *) loadWithContentManager:(ContentManager *) content atlasName:(NSString *) atlasName;

@end
