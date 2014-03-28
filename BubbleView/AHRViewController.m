//
//  AHRViewController.m
//  BubbleView
//
//  Created by Anton Rivera on 2/28/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "AHRViewController.h"

@interface AHRViewController () //<UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet UIButton *bubble1;
@property (weak, nonatomic) IBOutlet UIButton *bubble2;
@property (weak, nonatomic) IBOutlet UIButton *bubble3;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) UIView *barrier;
@property (nonatomic) IBOutlet UIButton *brandNewBubble1;
@property (nonatomic) IBOutlet UIButton *brandNewBubble2;
@property (nonatomic) IBOutlet UIButton *brandNewBubble3;
@property (nonatomic) NSInteger bubbleCount;
@property (nonatomic) NSInteger clickCount;
@property (nonatomic) NSTimer *timer;
//@property (nonatomic) BOOL firstContact;

@end

@implementation AHRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _bubbleCount = 3;
    _clickCount = 0;
	
    _bubble1.layer.cornerRadius = self.bubble1.frame.size.width / 2;
    _bubble1.clipsToBounds = YES;
    _bubble2.layer.cornerRadius = self.bubble2.frame.size.width / 2;
    _bubble2.clipsToBounds = YES;
    _bubble3.layer.cornerRadius = self.bubble3.frame.size.width / 2;
    _bubble3.clipsToBounds = YES;
    
//    UIImageView *tinyBubble1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 20, 20)];
//    tinyBubble1.image = [UIImage imageNamed:@"tinyBubble1.jpg"];
//    [self.view addSubview:tinyBubble1];
//    
//    UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:_bubble1
//                                                               attachedToItem:tinyBubble1];
//    [_animator addBehavior:attach];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[_bubble1, _bubble2, _bubble3]];
    [_animator addBehavior:_gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[_bubble1, _bubble2, _bubble3]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collision];
    
    _itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_bubble1, _bubble2, _bubble3]];
    _itemBehavior.elasticity = 1.0;
    [_animator addBehavior:_itemBehavior];
    
//    _collision.collisionDelegate = self;
    
    _barrier = [[UIView alloc] initWithFrame:CGRectMake(180, 493, 140, 75)];
    _barrier.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_barrier];
    
    UILabel *barrierLabel = [[UILabel alloc] initWithFrame:CGRectMake(183, 493, 134, 75)];
    barrierLabel.text = @"Hudson's Bubble Game";
    barrierLabel.textAlignment = NSTextAlignmentCenter;
    barrierLabel.textColor = [UIColor whiteColor];
    barrierLabel.numberOfLines = 0;
    barrierLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:barrierLabel];
    
    CGPoint rightEdge = CGPointMake(_barrier.frame.origin.x + _barrier.frame.size.width, _barrier.frame.origin.y);
    CGPoint bottomEdge = CGPointMake(_barrier.frame.origin.x, _barrier.frame.origin.y + _barrier.frame.size.height);
    [_collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:_barrier.frame.origin
                                  toPoint:rightEdge];
    [_collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:_barrier.frame.origin
                                  toPoint:bottomEdge];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(addThreeBubbles) userInfo:nil repeats:YES];
}

- (IBAction)bubbleClicked:(id)sender
{
    [sender removeFromSuperview];
    [_collision removeItem:sender];
    [_gravity removeItem:sender];
    [_itemBehavior removeItem:sender];
    _bubbleCount--;
    
    _clickCount++;
    
    if (_clickCount % 2 == 0) {
        //        [_gravity setMagnitude:0.1];
        CGVector gravityDirection = {1.0, 1.0};
        [_gravity setGravityDirection:gravityDirection];
        [_animator addBehavior:_gravity];
    } else if (_clickCount % 2 == 1) {
        //        [_gravity setMagnitude:1.0];
        CGVector gravityDirection = {-1.0, 1.0};
        [_gravity setGravityDirection:gravityDirection];
        [_animator addBehavior:_gravity];
    }
    
    if (_bubbleCount == 0) {
        [_timer invalidate];
        _timer = nil;
        
        _barrier.backgroundColor = [UIColor redColor];
    }
}

- (IBAction)brandNewBubbleClicked:(id)sender
{
    [sender removeFromSuperview];
    [_collision removeItem:sender];
    [_gravity removeItem:sender];
    [_itemBehavior removeItem:sender];
    _bubbleCount--;
    
    _clickCount++;
    
    if (_clickCount % 2 == 0) {
        //        [_gravity setMagnitude:0.1];
        CGVector gravityDirection = {1.0, 1.0};
        [_gravity setGravityDirection:gravityDirection];
        [_animator addBehavior:_gravity];
    } else if (_clickCount % 2 == 1) {
        //        [_gravity setMagnitude:1.0];
        CGVector gravityDirection = {-1.0, 1.0};
        [_gravity setGravityDirection:gravityDirection];
        [_animator addBehavior:_gravity];
    }
    
    if (_bubbleCount == 0) {
        [_timer invalidate];
        _timer = nil;
        
        _barrier.backgroundColor = [UIColor redColor];
    }
}

- (void)addThreeBubbles
{
    if (_bubbleCount < 30) {
        _brandNewBubble1 = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, 60, 60)];
        UIImage *bubbleImage1 = [UIImage imageNamed:@"bubble1.jpg"];
        [_brandNewBubble1 setImage:bubbleImage1 forState:UIControlStateNormal];
        _brandNewBubble1.layer.cornerRadius = _brandNewBubble1.frame.size.width / 2;
        _brandNewBubble1.clipsToBounds = YES;
        [self.view addSubview:_brandNewBubble1];
        
        [_collision addItem:_brandNewBubble1];
        [_gravity addItem:_brandNewBubble1];
        [_itemBehavior addItem:_brandNewBubble1];
        
        [_brandNewBubble1 addTarget:self
                             action:@selector(brandNewBubbleClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
        _bubbleCount++;
        
        
        _brandNewBubble2 = [[UIButton alloc] initWithFrame:CGRectMake(110, 0, 60, 60)];
        UIImage *bubbleImage2 = [UIImage imageNamed:@"bubble2.jpg"];
        [_brandNewBubble2 setImage:bubbleImage2 forState:UIControlStateNormal];
        _brandNewBubble2.layer.cornerRadius = _brandNewBubble2.frame.size.width / 2;
        _brandNewBubble2.clipsToBounds = YES;
        [self.view addSubview:_brandNewBubble2];
        
        [_collision addItem:_brandNewBubble2];
        [_gravity addItem:_brandNewBubble2];
        [_itemBehavior addItem:_brandNewBubble2];
        
        [_brandNewBubble2 addTarget:self
                             action:@selector(brandNewBubbleClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
        _bubbleCount++;
        
        
        _brandNewBubble3 = [[UIButton alloc] initWithFrame:CGRectMake(220, 0, 60, 60)];
        UIImage *bubbleImage3 = [UIImage imageNamed:@"bubble3.jpg"];
        [_brandNewBubble3 setImage:bubbleImage3 forState:UIControlStateNormal];
        _brandNewBubble3.layer.cornerRadius = _brandNewBubble3.frame.size.width / 2;
        _brandNewBubble3.clipsToBounds = YES;
        [self.view addSubview:_brandNewBubble3];
        
        [_collision addItem:_brandNewBubble3];
        [_gravity addItem:_brandNewBubble3];
        [_itemBehavior addItem:_brandNewBubble3];
        
        [_brandNewBubble3 addTarget:self
                             action:@selector(brandNewBubbleClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
        _bubbleCount++;
    }
}

//- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
//   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
//{
//    UIView* view = (UIView*)item;
//    view.backgroundColor = [UIColor yellowColor];
//    [UIView animateWithDuration:0.3 animations:^{
//        view.backgroundColor = [UIColor whiteColor];
//    }];
//
//
//    if (!_firstContact)
//    {
//        _firstContact = YES;
//
//        [self addThreeBubbles];
//    }
//}

@end
