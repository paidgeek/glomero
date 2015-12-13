#import "StringLineReader.h"

@implementation StringLineReader {
	NSString *string;
	NSString *line;
	
	unsigned length, paraStart, paraEnd, contentsEnd;
	NSRange currentRange;
}

- (id) initWithString:(NSString *)theString {
	self = [super init];
	
	if(self) {
		string = theString;
		length = [string length];
		paraStart = 0, paraEnd = 0, contentsEnd = 0;
	}
	
	return self;
}

- (BOOL) hasNext {
	return paraEnd < length;
}

- (NSString *) next {
	[string getParagraphStart:&paraStart end:&paraEnd
					  contentsEnd:&contentsEnd forRange:NSMakeRange(paraEnd, 0)];
	currentRange = NSMakeRange(paraStart, contentsEnd - paraStart);
	
	return [string substringWithRange:currentRange];
}

+ (StringLineReader *)createWithString:(NSString *)theString {
	return [[StringLineReader alloc] initWithString:theString];
}

@end
