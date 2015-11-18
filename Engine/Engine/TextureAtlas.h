#import "Engine.classes.h"

@interface TextureAtlas : NSObject

- (id) initWithTexture:(Texture2D *) atlasTexture data:(NSString *) atlasData;
- (Sprite*) getSpriteWithName:(NSString*) name;

@property (nonatomic, retain) Texture2D *texture;

@end
