#import <UIKit/UIKit.h>
#import "Retronator.Xni.Framework.h"
#import "TINR.Glomero.h"

int main(int argc, char * argv[]) {
	[GameHost load];
	
	int retVal = 1;

	@autoreleasepool {
		@try {
			retVal = UIApplicationMain(argc, argv, @"GameHost", @"Glomero");
		}
		@catch (NSException *exception) {
			NSLog(@"%@", exception);
		}
	}
	
	return retVal;
}
