//
//  ViewController.m
//  SegueTest
//
//  Created by Derrick Ho on 11/19/16.
//  Copyright © 2016 Derrick Ho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end

@implementation DHStoryboardSegue


@end

@implementation StoryboardSegueProxy

- (instancetype)init {
	if (self = [super init]) {
		_storyboardID = @"Main";
		_bundleID = nil;
	}
	return self;
}

- (UIViewController *)presentedViewController {
	NSBundle *bundle = [NSBundle bundleWithIdentifier:_bundleID] ?: [NSBundle mainBundle];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:_storyboardName ?: @"Main" bundle:bundle];
	UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:_storyboardID];
	[vc setTransitioningDelegate:self];
	[vc setModalPresentationStyle:UIModalPresentationCustom];
	return vc;
}

- (void)segueToPresentedViewcontroller {
	UIViewController *presentedVC = [self presentedViewController];
	UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:_storyboardID source:_presentingVC destination:presentedVC];
	[_presentingVC prepareForSegue:segue sender:self];
	[_presentingVC showViewController:presentedVC sender:self];
}

// MARK: - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
	return _presentingAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
	return _dismissingAnimator;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
	return _presentingInteractiveTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
	return _dismissingInteractiveTransition;
}

@end

@implementation StoryboardSegueProxyDelegate

- (StoryboardSegueProxy *)segueToBePerformedFromListOfSegue:(NSArray <StoryboardSegueProxy *> *)possibleSegues {
	return [possibleSegues firstObject];
}

@end

@implementation StoryboardSegueProxyRoot

- (NSArray<StoryboardSegueProxy *> *)possibleSegues {
	NSMutableArray <StoryboardSegueProxy *> *mut = [NSMutableArray arrayWithObject:self];
	StoryboardSegueProxy *seguePtr = self;
	while ((seguePtr = seguePtr.next)) {
		[mut addObject:seguePtr];
	}
	return mut;
}

- (void)segueToPresentedViewcontroller {
	StoryboardSegueProxy *segue = [[self segueLogicDelegate] segueToBePerformedFromListOfSegue:[self possibleSegues]];
	if (segue == self) {
		[super segueToPresentedViewcontroller];
	} else {
		[segue segueToPresentedViewcontroller];
	}
}

@end




///////////

@implementation Switch_StoryboardSegueProxyDelegate

- (StoryboardSegueProxy *)segueToBePerformedFromListOfSegue:(NSArray<StoryboardSegueProxy *> *)possibleSegues {
	return [[self aSwitch] isOn] ? [possibleSegues firstObject] : [possibleSegues lastObject];
}

@end

