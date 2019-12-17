#import "RNNativeSceneController.h"
#import "RNNativeScene.h"
#import "RNNativeStackHeader.h"

@interface RNNativeSceneController ()

@end

@implementation RNNativeSceneController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.automaticallyAdjustsScrollViewInsets = NO;
        _statusBarStyle = UIStatusBarStyleDefault;
        _statusBarHidden = NO;
    }
    return self;
}

- (instancetype)initWithScene:(RNNativeScene *)scene {
    if (self = [self init]) {
        _scene = scene;
    }
    return self;
}

- (void)updateForStatus:(RNNativeSceneStatus)status {
    switch (status) {
        case RNNativeSceneStatusWillFocus:
            // attach header, self.navigationController may be nil
            [self updateHeader];
            break;
        case RNNativeSceneStatusDidFocus:
            // attach header
            [self updateHeader];
            [self setNeedsStatusBarAppearanceUpdate];
            break;
        default:
            break;
    }
}

#pragma mark - UIViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
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
    [_scene setStatus:parent ? RNNativeSceneStatusWillFocus : RNNativeSceneStatusWillBlur];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    [_scene setStatus:parent ? RNNativeSceneStatusDidFocus : RNNativeSceneStatusDidBlur];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scene setStatus:RNNativeSceneStatusWillFocus];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_scene setStatus:RNNativeSceneStatusDidFocus];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scene setStatus:RNNativeSceneStatusWillBlur];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_scene setStatus:RNNativeSceneStatusDidBlur];
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
