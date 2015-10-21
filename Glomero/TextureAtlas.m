#import "TextureAtlas.h"

@implementation TextureAtlas

-(id)initWithAtlasPath: (NSString*) atlasPath texturePath: (NSString*) texturePath {
	self = [super init];
	
	if(self) {
		@try {
			NSString *json = [[NSBundle mainBundle] pathForResource:atlasPath ofType:@"json"];
			NSData *atlasData = [NSData dataWithContentsOfFile:json];
			
			atlas = [NSJSONSerialization
					 JSONObjectWithData:atlasData
					 options:0 error:nil];
		}
		@catch (NSException *exception) {
			NSLog(@"%@", exception);
		}
	}
	
	return self;
}

-(Sprite*)getSpriteWithName: (NSString*) name {
	Sprite *sprite = [[Sprite alloc] init];
	
	
	
	return sprite;
}

@end
