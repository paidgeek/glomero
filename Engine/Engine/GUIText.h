#import "Engine.UI.classes.h"

@interface GUIText : NSObject<IUIComponent>

@property (nonatomic, strong) SpriteFont *font;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) Color *color;
@property (nonatomic, strong) Vector2 *scale;
@property (nonatomic) HorizontalAlign horizontalAlign;
@property (nonatomic) VerticalAlign verticalAlign;

@end
