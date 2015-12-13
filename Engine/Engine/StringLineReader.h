#import <Foundation/Foundation.h>

@interface StringLineReader : NSObject

- (id) initWithString:(NSString *) theString;
- (BOOL) hasNext;
- (NSString *) next;

+ (StringLineReader *) createWithString:(NSString *) theString;

@end
