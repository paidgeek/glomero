#import "Space.h"
#import "MathUtil.h"
#import "Retronator.Xni.Framework.h"

@class PlayerPrefs;
@class Transform;
@class Node;
@class Scene;
@class Camera;

#import "INodeComponent.h"
#import "ISceneListener.h"
#import "IDrawableComponent.h"
#import "IUIComponent.h"

#import "Engine.UI.classes.h"

// Systems
@class LogicSystem;
@class RenderSystem;

// Actions
@class SceneAction;
@class RemoveComponentAction;
@class AddComponentAction;
@class CreateNodeAction;
@class DestroyNodeAction;

#import "ISceneAction.h"

@class Plane;
@class BoundingSphere;
@class BoundingBox;