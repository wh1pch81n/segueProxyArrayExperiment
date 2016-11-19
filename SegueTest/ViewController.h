//
//  ViewController.h
//  SegueTest
//
//  Created by Derrick Ho on 11/19/16.
//  Copyright © 2016 Derrick Ho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface DHStoryboardSegue : UIStoryboardSegue

@end

@import UIKit;

/**
 This object is meant to be used in a storyboard.  Add it to the scene dock of your presenting view controller.
 Connect the presenting view controller to the presentingVC property.
 */
@interface StoryboardSegueProxy : NSObject <UIViewControllerTransitioningDelegate>

/** name of storyboard that presented view controller lives in. default value is "Main".   */
@property (strong, nonatomic) IBInspectable NSString *storyboardName;

/** name of the bundle that presented view controller lives in.  default value is Main bundle */
@property (strong, nonatomic) IBInspectable NSString *bundleID;

/** Storyboard Identifier of the view controller that will be presented */
@property (strong, nonatomic) IBInspectable NSString *storyboardID;

/** The view controller that is presenting the presented view controller */
@property (weak, nonatomic) IBOutlet UIViewController *presentingVC;

/** New instance of presented view controller*/
- (UIViewController *)presentedViewController;

/** segue to presented view controller.
 
 You may connect this to a Button's action or any object capable of triggering actions in interface builder
 */
- (IBAction)segueToPresentedViewcontroller;

// MARK: - Modal Animations

@property (weak, nonatomic) IBOutlet id<UIViewControllerAnimatedTransitioning> presentingAnimator;
@property (weak, nonatomic) IBOutlet id<UIViewControllerAnimatedTransitioning> dismissingAnimator;

@property (weak, nonatomic) UIPercentDrivenInteractiveTransition *presentingInteractiveTransition;
@property (weak, nonatomic) UIPercentDrivenInteractiveTransition *dismissingInteractiveTransition;

@property (strong, nonatomic) IBOutlet StoryboardSegueProxy *next;

@end

/**
 Subclass this object if you want StoryboardSegueProxyRoot to exhibit custom behavior
 */
@interface StoryboardSegueProxyDelegate: NSObject

/**
 A linked list of StoryboardSegueProxy are converted into an array and sent by StoryboardSegueProxyRoot instance.
 The default behavior of this method is to return the first object.
 Override this method if you want to to use a different one.
 */
- (StoryboardSegueProxy *)segueToBePerformedFromListOfSegue:(NSArray <StoryboardSegueProxy *> *)possibleSegues;

@end

/**
 A root segue with some logic
 */
@interface StoryboardSegueProxyRoot : StoryboardSegueProxy

@property (weak, nonatomic) IBOutlet StoryboardSegueProxyDelegate *segueLogicDelegate;

@end



@interface Switch_StoryboardSegueProxyDelegate : StoryboardSegueProxyDelegate

@property (weak, nonatomic) IBOutlet UISwitch *aSwitch;


@end
