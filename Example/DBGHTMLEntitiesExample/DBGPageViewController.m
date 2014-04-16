//
//  DBGPageViewController.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/15/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGPageViewController.h"

#import "DBGDecodeExampleViewController.h"
#import "DBGEncodeExampleViewController.h"

@interface DBGPageViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) DBGDecodeExampleViewController *example1;
@property (nonatomic, strong) DBGEncodeExampleViewController *example2;

@end

@implementation DBGPageViewController

- (id)init {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                  options:@{UIPageViewControllerOptionInterPageSpacingKey:@6.0}];
    
    if (self) {
        self.dataSource = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    self.example1 = [[DBGDecodeExampleViewController alloc] init];
    self.example2 = [[DBGEncodeExampleViewController alloc] init];
    
    [self setViewControllers:@[self.example1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return (viewController == self.example1) ? nil : self.example1;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return (viewController == self.example2) ? nil : self.example2;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return ([self.viewControllers objectAtIndex:0] == self.example1) ? 0 : 1;
}

@end
