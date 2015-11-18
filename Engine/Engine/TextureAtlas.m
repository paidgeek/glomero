#import "TextureAtlas.h"
#import "Engine.h"

@implementation TextureAtlas {
	id atlas;
}

- (id) initWithTexture:(Texture2D *)atlasTexture data:(NSString *)atlasData {
	self = [super init];
	
	if(self) {
		self.texture = atlasTexture;
		
		@try {
			atlas = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:atlasData]
																 options:0
																	error:nil];
		}
		@catch (NSException *exception) {
			NSLog(@"%@", exception);
		}
	}
	
	return self;
}

- (Sprite *) getSpriteWithName:(NSString *)name {
	if([atlas isKindOfClass:[NSDictionary class]]) {
		NSArray *sprites = [atlas objectForKey:@"sprites"];
		
		for (NSDictionary *spriteObj in sprites) {
			if([name isEqualToString:[spriteObj valueForKey:@"name"]]) {
				NSArray *rectArr = [spriteObj objectForKey:@"rectange"];
				
				int x = (int)[[rectArr objectAtIndex:0] integerValue];
				int y = (int)[[rectArr objectAtIndex:1] integerValue];
				int w = (int)[[rectArr objectAtIndex:2] integerValue];
				int h = (int)[[rectArr objectAtIndex:3] integerValue];
				
				Rectangle *rect = [Rectangle rectangleWithX:x
																		y:y
																  width:w
																 height:h];
				Sprite *sprite = [[Sprite alloc] init];
				
				sprite.texture = self.texture;
				sprite.rectangle = rect;
				
				return sprite;
			}
		}
	}
	
	return nil;
}

@end
