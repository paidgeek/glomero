#import "PlayerPrefs.h"
#import "Engine.Core.h"

#define FILE_NAME @"PLAYER_PREFS"

@implementation PlayerPrefs

static NSString *saveFile;
static NSMutableDictionary *data;

+ (void) load {
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
									 objectAtIndex:0];
	saveFile = [rootPath stringByAppendingPathComponent:FILE_NAME];
	data = [NSKeyedUnarchiver unarchiveObjectWithFile:saveFile];
	
	if(!data) {
		data = [NSMutableDictionary dictionary];
	}
}

+ (void) deleteAll {
	data = [NSMutableDictionary dictionary];
}

+ (void) deleteKey:(NSString *) key {
	[data removeObjectForKey:key];
}

+ (void) save {
	[NSKeyedArchiver archiveRootObject:data
										 toFile:saveFile];
}

+ (float) getFloatByKey:(NSString *) key defaultValue:(float)value {
	id item = [data objectForKey:key];
	
	return item ? [item floatValue] : value;
}

+ (int) getIntByKey:(NSString *) key defaultValue:(int)value {
	id item = [data objectForKey:key];
	
	return item ? [item intValue] : value;
}

+ (void) setFloatForKey:(NSString *) key value:(float) value {
	[data setObject:[NSNumber numberWithFloat:value] forKey:key];
}

+ (void) setIntForKey:(NSString *) key value:(int) value {
	[data setObject:[NSNumber numberWithInt:value] forKey:key];
}

@end
