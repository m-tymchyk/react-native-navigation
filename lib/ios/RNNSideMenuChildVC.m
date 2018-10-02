#import "RNNSideMenuChildVC.h"

@interface RNNSideMenuChildVC ()

@property (readwrite) RNNSideMenuChildType type;
@property (nonatomic, retain) UIViewController<RNNParentProtocol> *child;

@end

@implementation RNNSideMenuChildVC

- (instancetype)initWithLayoutInfo:(RNNLayoutInfo *)layoutInfo options:(RNNNavigationOptions *)options presenter:(RNNBasePresenter *)presenter type:(RNNSideMenuChildType)type {
	self = [self initWithLayoutInfo:layoutInfo options:options presenter:presenter];
	
	self.type = type;

	return self;
}

- (instancetype)initWithLayoutInfo:(RNNLayoutInfo *)layoutInfo options:(RNNNavigationOptions *)options presenter:(RNNBasePresenter *)presenter {
	self = [super init];
	
	self.presenter = presenter;
	self.options = options;
	self.layoutInfo = layoutInfo;
	
	
	return self;
}

- (void)bindChildrenViewControllers:(NSArray<UIViewController<RNNParentProtocol> *> *)viewControllers {
	UIViewController<RNNParentProtocol>* child = viewControllers[0];
	[self.options mergeOptions:child.options overrideOptions:YES];
	
	self.child = child;
	[self addChildViewController:self.child];
	[self.child.view setFrame:self.view.bounds];
	[self.view addSubview:self.child.view];
	[self.view bringSubviewToFront:self.child.view];
}

- (UIViewController *)getLeafViewController {
	return [self.child getLeafViewController];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[_presenter present:self.options onViewControllerDidLoad:self];
}

- (void)mergeOptions:(RNNNavigationOptions *)options {
	[self.presenter present:options onViewControllerWillAppear:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return self.child.preferredStatusBarStyle;
}

@end
