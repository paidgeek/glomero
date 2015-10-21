#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "GameComponent.h"
#import "Sprite.h"

@interface TextureAtlas : NSObject {
	Texture2D *texture;
	id atlas;
}

- (id) initWithAtlasPath:(NSString*) atlasPath texturePath: (NSString*) texturePath;
- (Sprite*) getSpriteWithName:(NSString*) name;

@end
