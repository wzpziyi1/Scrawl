//
//  MyView.m
//  Scrawl
//
//  Created by 王志盼 on 15/5/3.
//  Copyright (c) 2015年 王志盼. All rights reserved.
//

#import "MyView.h"

@interface MyView ()
@property(nonatomic, strong) NSMutableArray *totalArray;
@end

@implementation MyView

- (NSMutableArray *)totalArray
{
    if (_totalArray == nil) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}

- (void)addPointToArrayWithTouch:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    NSMutableArray *tmpArray = [self.totalArray lastObject];
    
    [tmpArray addObject:[NSValue  valueWithCGPoint:[touch locationInView:self]]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    [tmpArray addObject:[NSValue  valueWithCGPoint:[touch locationInView:self]]];
    
    [self.totalArray addObject:tmpArray];
    
    [self setNeedsDisplay];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addPointToArrayWithTouch:touches];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addPointToArrayWithTouch:touches];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSArray *tmpArray in self.totalArray) {
        
        
        for (int i = 0;i < tmpArray.count;i++)
        {
            CGPoint point = [tmpArray[i] CGPointValue];
            if (i == 0) {
                
                CGContextMoveToPoint(context, point.x, point.y);
            }
            else
            {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
    }
    
    CGContextSetLineWidth(context, 4);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextStrokePath(context);
    
}

- (void)clear
{
    [self.totalArray removeAllObjects];
    [self setNeedsDisplay];
}
- (void)back
{
    [self.totalArray removeLastObject];
    [self setNeedsDisplay];
}

@end
