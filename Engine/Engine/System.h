#import "Engine.classes.h"
#import "DrawableGameComponent.h"

@interface System : DrawableGameComponent

- (id) initWithGame:(Game *)theGame scene:(Scene *)theScene;

@property (nonatomic) Scene *scene;

@end
