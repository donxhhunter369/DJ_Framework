//
//  AwesomeMenu.h
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 Levey & Other Contributors. All rights reserved.
//


/*
    主键，点击可以出现一圈附键
    用法如下:
 UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
 UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
 
 UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
 
 //... Default Menu
 
 AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem6 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem7 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem8 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 AwesomeMenuItem *starMenuItem9 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
 highlightedImage:storyMenuItemImagePressed
 ContentImage:starImage
 highlightedContentImage:nil];
 
 NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, starMenuItem7,starMenuItem8,starMenuItem9, nil];
 
 AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
 highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
 ContentImage:[UIImage imageNamed:@"icon-plus.png"]
 highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
 
 AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.window.bounds startItem:startItem menuItems:menuItems];
 menu.delegate = self;
 [self.window addSubview:menu];
 
 ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ 
 ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ 
 ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇
//- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
//{
//    NSLog(@"Select the index : %d",idx);
//}
//- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
//    NSLog(@"Menu was closed!");
//}
//- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
//    NSLog(@"Menu is open!");
//}
 */

#import <UIKit/UIKit.h>
#import "AwesomeMenuItem.h"

@protocol AwesomeMenuDelegate;

@interface AwesomeMenu : UIView <AwesomeMenuItemDelegate>

@property (nonatomic, copy) NSArray *menuItems;
@property (nonatomic, strong) AwesomeMenuItem *startButton;

@property (nonatomic, getter = isExpanded) BOOL expanded;
@property (nonatomic, weak) id<AwesomeMenuDelegate> delegate;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, strong) UIImage *contentImage;
@property (nonatomic, strong) UIImage *highlightedContentImage;

@property (nonatomic, assign) CGFloat nearRadius;
@property (nonatomic, assign) CGFloat endRadius;
@property (nonatomic, assign) CGFloat farRadius;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat timeOffset;
@property (nonatomic, assign) CGFloat rotateAngle;
@property (nonatomic, assign) CGFloat menuWholeAngle;
@property (nonatomic, assign) CGFloat expandRotation;
@property (nonatomic, assign) CGFloat closeRotation;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) BOOL    rotateAddButton;

- (id)initWithFrame:(CGRect)frame startItem:(AwesomeMenuItem*)startItem menuItems:(NSArray *)menuItems;

- (id)initWithFrame:(CGRect)frame startItem:(AwesomeMenuItem*)startItem optionMenus:(NSArray *)aMenusArray DEPRECATED_MSG_ATTRIBUTE("use -initWithFrame:startItem:menuItems: instead.");

- (AwesomeMenuItem *)menuItemAtIndex:(NSUInteger)index;

- (void)open;

- (void)close;

@end

@protocol AwesomeMenuDelegate <NSObject>
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx;
@optional
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu;
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu;
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu;
- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu;
@end