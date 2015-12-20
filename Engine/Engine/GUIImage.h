#import "Engine.UI.classes.h"
#import "Sprite.h"

@interface GUIImage : NSObject<IUIComponent>

@property (nonatomic, strong) Sprite *sprite;
@property (nonatomic, strong) Color *color;
@property (nonatomic) HorizontalAlign horizontalAlign;
@property (nonatomic) VerticalAlign verticalAlign;

@end
