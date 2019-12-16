#import "RNNativeStackController.h"
#import "RNNativeStackScene.h"
#import "RNNativeStackHeader.h"

@interface RNNativeStackController ()

@end

@implementation RNNativeStackController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        _statusBarStyle = -1;
        _statusBarHidden = -1;
    }
    return self;
}

- (instancetype)initWithScene:(RNNativeStackScene *)scene {
    if (self = [self init]) {
        _scene = scene;
    }
    return self;
}

- (void)updateForStatus:(RNNativeStackSceneStatus)status {
    switch (status) {
        case RNNativeStackSceneStatusWillFocus:
            // attach header
            [self updateHeader];
            break;
        default:
            break;
    }
}

#pragma mark - UIViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (_statusBarStyle >= 0) {
        return _statusBarStyle;
    } else {
        return [super preferredStatusBarStyle];
    }
}

- (BOOL)prefersStatusBarHidden {
    if (_statusBarHidden >= 0) {
        return _statusBarHidden > 0;
    } else {
        return [super prefersStatusBarHidden];
    }
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.childViewControllers.count > 0 ? self.childViewControllers.lastObject : nil;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
    return self.childViewControllers.count > 0 ? self.childViewControllers.lastObject : nil;
}

- (void)loadView {
    if (_scene != nil) {
        self.view = _scene;
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    [_scene setStatus:parent ? RNNativeStackSceneStatusWillFocus : RNNativeStackSceneStatusWillBlur];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    [_scene setStatus:parent ? RNNativeStackSceneStatusDidFocus : RNNativeStackSceneStatusDidBlur];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scene setStatus:RNNativeStackSceneStatusWillFocus];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_scene setStatus:RNNativeStackSceneStatusDidFocus];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scene setStatus:RNNativeStackSceneStatusWillBlur];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_scene setStatus:RNNativeStackSceneStatusDidBlur];
}

#pragma mark - Setter

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    if (_statusBarStyle == statusBarStyle) {
        return;
    }
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarHidden:(NSInteger)statusBarHidden {
    if (_statusBarHidden == statusBarHidden) {
        return;
    }
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Header

- (void)updateHeader {
    RNNativeStackHeader *header = [self findHeader];
    if (header) {
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO];
        }
        self.navigationController.navigationBar.translucent = _scene.translucent;
        [header attachViewController:self];
    } else {
        if (!self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:YES];
        }
    }
}

- (RNNativeStackHeader *)findHeader {
    for (UIView *subview in _scene.reactSubviews) {
        if ([subview isKindOfClass:[RNNativeStackHeader class]]) {
            return (RNNativeStackHeader *)subview;
        }
    }
    return nil;
}

@end
