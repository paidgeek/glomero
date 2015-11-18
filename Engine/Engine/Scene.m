#import "Scene.h"
#import "Engine.h"

@implementation Scene {
	NSMutableArray *sceneObjects;
	NSMutableDictionary *sceneComponents;
}

static long nextSceneObjectId;

- (id) initWithGame:(Game *)theGame {
	self = [super initWithGame:theGame];

	if(self) {
		sceneObjects = [NSMutableArray array];
		sceneComponents = [NSMutableDictionary dictionary];
	}
	
	return self;
}

- (SceneObject *) createSceneObject {
	SceneObject *sceneObject = [[SceneObject alloc] initWithUId:++nextSceneObjectId];

	[sceneObjects addObject:@(sceneObject.uid)];
	
	return sceneObject;
}

- (void) addSceneComponent:(SceneComponent *)sceneComponent toSceneObject:(SceneObject *)sceneObject {
	NSMutableDictionary *components = sceneComponents[NSStringFromClass([sceneComponent class])];
	
	if(!components) {
		components = [[NSMutableDictionary alloc] init];
		
		sceneComponents[NSStringFromClass([sceneComponent class])] = components;
	}

	components[@(sceneObject.uid)] = sceneComponent;
}

- (SceneComponent *) getSceneComponentOfClass:(Class)sceneComponentClass forSceneObject:(SceneObject *)sceneObject {
	SceneComponent *sceneComponent = sceneComponents[NSStringFromClass(sceneComponentClass)][@(sceneObject.uid)];
	
	return sceneComponent;
}

- (void) destroySceneObject:(SceneObject *)sceneObject {
	id uid = @(sceneObject.uid);
	
	for (NSMutableDictionary *components in sceneComponents.allValues) {
		if(components[uid]) {
			[components removeObjectForKey:uid];
		}
	}
	
	[sceneObjects removeObject:uid];
}

- (NSArray *) getSceneObjectsByComponentClass:(Class)sceneComponentClass {
	NSMutableDictionary *components = sceneComponents[NSStringFromClass(sceneComponentClass)];
	
	if(components) {
		NSMutableArray *arr = [NSMutableArray arrayWithCapacity:components.allKeys.count];
		
		for(NSNumber *uid in components.allKeys) {
			[arr addObject:[SceneObject alloc] initWithUId:uid.integerValue] ];
		}
		
		return arr;
	}
	
	return [NSArray array];
}

@end
