#import "TextureAtlas.h"
#import "Engine.Graphics.h"
#import "Retronator.Xni.Framework.Content.h"
#import "StringLineReader.h"

@implementation TextureAtlas {
	NSMutableDictionary *sprites;
}

@synthesize texture;

- (id) initWithTexture:(Texture2D *)theTexture sprites:(NSMutableDictionary *)theSprites {
	self = [super init];
	
	if(self) {
		texture = theTexture;
		sprites = theSprites;
	}
	
	return self;
}

- (Sprite *) getSpriteWithName:(NSString *)name {
	Sprite *sprite = [[Sprite alloc] init];
	
	sprite.texture = texture;
	sprite.rectange = [Rectangle rectangleWithRectangle:[sprites objectForKey:name]];
	sprite.pivot = [Vector2 vectorWithX:sprite.rectange.width / 2.0f
												 y:sprite.rectange.height / 2.0f];
	
	return sprite;
}

+ (TextureAtlas *)loadWithContentManager:(ContentManager *)content atlasName:(NSString *) atlasName {
	Texture2D *texture = [content load:atlasName
									  fromFile:[NSString stringWithFormat:@"%@.png", atlasName]];
	NSString *atlasPath = [[NSBundle mainBundle] pathForResource:atlasName
																  ofType:@"atlas"];
	NSString *atlas = [NSString stringWithContentsOfFile:atlasPath
															  encoding:NSUTF8StringEncoding
																  error:nil];
	NSMutableDictionary *sprites = [NSMutableDictionary dictionary];
	StringLineReader *slr = [StringLineReader createWithString:atlas];
	
	for (int i = 0; [slr hasNext]; i++) {
		NSString *name = [[slr next] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		[slr next];
		NSString *xy = [[slr next] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		NSString *size = [[slr next] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		[slr next];
		[slr next];
		[slr next];

		int x, y, width, height;
		
		sscanf([xy cStringUsingEncoding:NSUTF8StringEncoding], "xy: %d, %d", &x, &y);
		sscanf([size cStringUsingEncoding:NSUTF8StringEncoding], "size: %d, %d", &width, &height);
		
		Rectangle *sprite = [Rectangle rectangleWithX:x y:y width:width height:height];
		
		[sprites setObject:sprite forKey:name];
	}
	
	return [[TextureAtlas alloc] initWithTexture:texture sprites:sprites];
}

@end
