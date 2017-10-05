//
//  DrawView.m
//  TouchTracker
//
//  Created by Thiago Centurion on 01/10/2017.
//  Copyright © 2017 Thiago Centurion. All rights reserved.
//

#import "DrawView.h"
#import "Line.h"

@interface DrawView()

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        
        // Habilita multiplos dedos na tela
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Desenho das linhas terminadas em preto
    [[UIColor blackColor] set];
    
    for (Line *line in self.finishedLines)
    {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    
    for (NSValue *key in self.linesInProgress)
    {
        [self strokeLine:self.linesInProgress[key]];
    }
}

- (void)strokeLine:(Line *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        CGPoint location = [t locationInView:self];
        
        Line *line = [[Line alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.linesInProgress[key];
        
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

@end
