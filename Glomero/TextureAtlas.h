#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"

#import "TINR.Glomero.classes.h"

@interface TextureAtlas : NSObject {
	Texture2D *texture;
	id atlas;
}

- (id) initWithTexture:(Texture2D*) atlasTexture
				  data:(NSString*) atlasData;

- (Sprite*) getSpriteWithName:(NSString*) name;

@property (nonatomic, retain) Texture2D *texture;

@end
