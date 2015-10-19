#import <UIKit/UIKit.h>
#import "Retronator.Xni.Framework.h"

int main(int argc, char * argv[]) {
	[GameHost load];
	
	@autoreleasepool {
		return UIApplicationMain(argc, argv, @"GameHost", @"Glomero");
	}
}
