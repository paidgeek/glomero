#import "Engine.Core.classes.h"

@protocol ISceneAction <NSObject>

- (void) performOnScene:(Scene *) scene;

@end
