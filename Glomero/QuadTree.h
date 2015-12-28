#import "Engine.Core.classes.h"
#import "PrimitiveBatch.h"

@interface QuadTree : NSObject

- (id) initWithLevel:(int) theLevel bounds:(Rectangle *) theBounds;

- (void) clear;
- (void) split;
- (int) findNode:(id<IParticle>) circle;
- (void) insertNode:(id<IParticle>) circle;
- (NSMutableArray *) retrieveForNode:(id<IParticle>) circle;
- (void) drawWithPrimitiveBatch:(PrimitiveBatch *) primitiveBatch;

@property (nonatomic, strong) Rectangle *bounds;
@property (nonatomic) int level;
@property (nonatomic, strong) NSMutableArray *objects;

@end
