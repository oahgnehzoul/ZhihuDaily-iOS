//
//  ZDFPSLabel.m
//  MyZhihuDaily
//
//  Created by oahgnehzoul on 16/10/7.
//  Copyright © 2016年 oahgnehzoul. All rights reserved.
//

#import "ZDFPSLabel.h"
#import "YYWeakProxy.h"
#define kZDFPSLabelSize CGSizeMake(55, 20)

@implementation ZDFPSLabel
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        frame.size = kZDFPSLabelSize;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        
//        _font = [UIFont fontWithName:@"Menlo" size:1];
//        if (_font) {
//            _subFont = [UIFont fontWithName:@"Menlo" size:4];
//        } else {
//            _font = [UIFont fontWithName:@"Courier" size:1];
//            _subFont = [UIFont fontWithName:@"Courier" size:4];
//        }
    
        _link = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) {
        return;
    }
    _lastTime = link.timestamp;
    CGFloat fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.f;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.f FPS", fps]];
//    [text setAttributes:@{NSFontAttributeName:_font} range:NSMakeRange(0,text.length)];
//    [text setAttributes:@{NSFontAttributeName:_subFont} range:NSMakeRange(text.length - 4, 1)];
    [text setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, text.length - 3)];
    [text setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(text.length - 3, 3)];
    self.attributedText = text;
}

- (void)dealloc {
    [_link invalidate];
    NSLog(@"ZDFPSLabel dealloc");
}

@end
