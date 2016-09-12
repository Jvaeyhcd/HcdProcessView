//
//  ____    ___   _        ___  _____  ____  ____  ____
// |    \  /   \ | T      /  _]/ ___/ /    T|    \|    \
// |  o  )Y     Y| |     /  [_(   \_ Y  o  ||  o  )  o  )
// |   _/ |  O  || l___ Y    _]\__  T|     ||   _/|   _/
// |  |   |     ||     T|   [_ /  \ ||  _  ||  |  |  |
// |  |   l     !|     ||     T\    ||  |  ||  |  |  |
// l__j    \___/ l_____jl_____j \___jl__j__jl__j  l__j
//
//
//	Powered by Polesapp.com
//
//
//  HcdProcessView.m
//  HcdProcessViewDemo
//
//  Created by polesapp-hcd on 16/9/10.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "HcdProcessView.h"

@implementation HcdProcessView
{
    CGRect fullRect;
    CGRect scaleRect;
    CGRect waveRect;
    
    UIColor *currentWaterColor;
    UIColor *waterBgColor;
    
    CGFloat currentLinePointY;
    CGFloat targetLinePointY;
    CGFloat amplitude;//振幅
    
    CGFloat currentPercent;//但前百分比，用于保存第一次显示时的动画效果
    
    CGFloat a;
    CGFloat b;
    
    BOOL increase;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        fullRect = frame;
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _innerRimWidth = 0.05;
    _innerRimBorderWidth = 0.005;
    _scaleDivisionsLength = 10;
    _scaleDivisionsWidth = 2;
    _scaleCount = 100;
    
    a = 1.5;
    b = 0;
    increase = NO;
    
    currentWaterColor = [UIColor colorWithRed:0.322 green:0.514 blue:0.831 alpha:1.00];
    waterBgColor = [UIColor colorWithRed:0.259 green:0.329 blue:0.506 alpha:1.00];
    _percent = 0.8;
    
    _scaleMargin = 20;
    _waveMargin = 18;
    
    [self initDrawingRects];
    
    currentLinePointY = waveRect.size.height;
    targetLinePointY = waveRect.size.height * (1 - _percent);
    amplitude = (waveRect.size.height / 320.0) * 10;
    
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
}

- (void)initDrawingRects
{
    CGFloat offset = _scaleMargin;
    scaleRect = CGRectMake(offset,
                           offset,
                           fullRect.size.width - 2 * offset,
                           fullRect.size.height - 2 * offset);
    
    offset = _scaleMargin + _waveMargin + _scaleDivisionsWidth;
    waveRect = CGRectMake(offset,
                          offset,
                          fullRect.size.width - 2 * offset,
                          fullRect.size.height - 2 * offset);
}

// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawBackground:context];
    [self drawWave:context];
    [self drawLabel:context];
    [self drawScale:context];
    [self drawProcessScale:context];
    
}

/**
 *  画比例尺
 *
 *  @param context 全局context
 */
- (void)drawScale:(CGContextRef)context {
    
    CGContextSetLineWidth(context, _scaleDivisionsWidth);//线的宽度
    //======================= 矩阵操作 ============================
    CGContextTranslateCTM(context, fullRect.size.width / 2, fullRect.size.width / 2);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.655 green:0.710 blue:0.859 alpha:1.00].CGColor);//线框颜色
    // 2. 绘制一些图形
    for (int i = 0; i < _scaleCount; i++) {
        CGContextMoveToPoint(context, scaleRect.size.width/2 - _scaleDivisionsLength, 0);
        CGContextAddLineToPoint(context, scaleRect.size.width/2, 0);
        //    CGContextScaleCTM(ctx, 0.5, 0.5);
        // 3. 渲染
        CGContextStrokePath(context);
        CGContextRotateCTM(context, 2 * M_PI / _scaleCount);
    }
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.694 green:0.745 blue:0.867 alpha:1.00].CGColor);//线框颜色
    CGContextSetLineWidth(context, 0.5);
    CGContextAddArc (context, 0, 0, scaleRect.size.width/2 - _scaleDivisionsLength - 3, 0, M_PI* 2 , 0);
    CGContextStrokePath(context);
    
    CGContextTranslateCTM(context, -fullRect.size.width / 2, -fullRect.size.width / 2);
}

/**
 *  画波浪
 *
 *  @param context 全局context
 */
- (void)drawWave:(CGContextRef)context {
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [currentWaterColor CGColor]);
    
    CGFloat offset = _scaleMargin + _waveMargin + _scaleDivisionsWidth;
    
    float y = currentLinePointY;
    
    CGFloat radius = waveRect.size.width / 2;
    
    CGPoint startPoint = CGPointMake(offset, y + offset);
    CGPoint endPoint = CGPointMake(offset, y + offset);
    
    for(float x = 0; x <= waveRect.size.width; x++){
        y = a * sin( x / 180 * M_PI + 4 * b / M_PI ) * amplitude + currentLinePointY;
        
        CGFloat circleY = y;
        if (currentLinePointY < radius) {
            circleY = radius - sqrt(pow(radius, 2) - pow((radius - x), 2));
            if (y < circleY) {
                y = circleY;
            }
        } else if (currentLinePointY > radius) {
            circleY = radius + sqrt(pow(radius, 2) - pow((radius - x), 2));
            if (y > circleY) {
                y = circleY;
            }
        }
        
        if (fabs(0 - x) < 0.001) {
            startPoint = CGPointMake(x + offset, y + offset);
            CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        }
        
        endPoint = CGPointMake(x + offset, y + offset);
        CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y);
    }
    
    CGPoint centerPoint = CGPointMake(fullRect.size.width / 2, fullRect.size.height / 2);
    
    CGFloat start = [self calculateRotateDegree:centerPoint point:startPoint];
    CGFloat end = [self calculateRotateDegree:centerPoint point:endPoint];
    
    CGPathAddArc(path, nil, centerPoint.x, centerPoint.y, waveRect.size.width / 2, end, start, 0);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}

/**
 *  画背景界面
 *
 *  @param context 全局context
 */
- (void)drawBackground:(CGContextRef)context {
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [waterBgColor CGColor]);
    
    CGPoint centerPoint = CGPointMake(fullRect.size.width / 2, fullRect.size.height / 2);
    CGPathAddArc(path, nil, centerPoint.x, centerPoint.y, waveRect.size.width / 2, 0, 2 * M_PI, 0);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}

/**
 *  比例次进度
 *
 *  @param context 全局context
 */
- (void)drawProcessScale:(CGContextRef)context {
    
    CGContextSetLineWidth(context, _scaleDivisionsWidth);//线的宽度
    //======================= 矩阵操作 ============================
    CGContextTranslateCTM(context, fullRect.size.width / 2, fullRect.size.width / 2);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.969 green:0.937 blue:0.227 alpha:1.00].CGColor);//线框颜色
    
    int count = (_scaleCount / 2 + 1) * currentPercent;
    CGFloat scaleAngle = 2 * M_PI / _scaleCount;
    
    // 2. 绘制一些图形
    for (int i = 0; i < count; i++) {
        CGContextMoveToPoint(context, 0, scaleRect.size.width/2 - _scaleDivisionsLength);
        CGContextAddLineToPoint(context, 0, scaleRect.size.width/2);
        //    CGContextScaleCTM(ctx, 0.5, 0.5);
        // 3. 渲染
        CGContextStrokePath(context);
        CGContextRotateCTM(context, scaleAngle);
    }
    
    CGContextRotateCTM(context, -count * scaleAngle);
    
    for (int i = 0; i < count; i++) {
        CGContextMoveToPoint(context, 0, scaleRect.size.width/2 - _scaleDivisionsLength);
        CGContextAddLineToPoint(context, 0, scaleRect.size.width/2);
        //    CGContextScaleCTM(ctx, 0.5, 0.5);
        // 3. 渲染
        CGContextStrokePath(context);
        CGContextRotateCTM(context, -scaleAngle);
    }
    
    
    CGContextTranslateCTM(context, -fullRect.size.width / 2, -fullRect.size.width / 2);
}

- (void)drawLabel:(CGContextRef)context {
    
    NSMutableAttributedString *attriButedText = [self formatBatteryLevel:_percent * 100];
    CGRect textSize = [attriButedText boundingRectWithSize:CGSizeMake(400, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    NSMutableAttributedString *attriLabelText = [self formatLabel:@"汽车当前电量"];
    CGRect labelSize = [attriLabelText boundingRectWithSize:CGSizeMake(400, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    CGPoint textPoint = CGPointMake(fullRect.size.width / 2 - textSize.size.width / 2, fullRect.size.height / 2 - textSize.size.height / 2 - labelSize.size.height / 2);
    CGPoint labelPoint = CGPointMake(fullRect.size.width / 2 - labelSize.size.width / 2, textPoint.y + textSize.size.height);
    
    [attriButedText drawAtPoint:textPoint];
    [attriLabelText drawAtPoint:labelPoint];
    
    //推入
    CGContextSaveGState(context);
}

-(void)animateWave
{
    
    if (targetLinePointY == self.frame.size.height ||
        currentLinePointY == 0) {
        return;
    }
    
    if (targetLinePointY < currentLinePointY) {
        currentLinePointY -= 1;
        currentPercent = (waveRect.size.height - currentLinePointY) / waveRect.size.height;
    }
    
    if (increase) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        increase = YES;
    }
    
    if (a>=1.5) {
        increase = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}

/**
 * Core Graphics rotation in context
 */
- (void)rotateContext:(CGContextRef)context fromCenter:(CGPoint)center_ withAngle:(CGFloat)angle
{
    CGContextTranslateCTM(context, center_.x, center_.y);
    CGContextRotateCTM(context, angle);
    CGContextTranslateCTM(context, -center_.x, -center_.y);
}

/**
 *  根据圆心点和圆上一个点计算角度
 *
 *  @param centerPoint 圆心点
 *  @param point       圆上的一个点
 *
 *  @return 角度
 */
- (CGFloat)calculateRotateDegree:(CGPoint)centerPoint point:(CGPoint)point {
    
    CGFloat rotateDegree = asin(fabs(point.y - centerPoint.y) / (sqrt(pow(point.x - centerPoint.x, 2) + pow(point.y - centerPoint.y, 2))));
    
    //如果point纵坐标大于原点centerPoint纵坐标(在第一和第二象限)
    if (point.y > centerPoint.y) {
        //第一象限
        if (point.x >= centerPoint.x) {
            rotateDegree = rotateDegree;
        }
        //第二象限
        else {
            rotateDegree = M_PI - rotateDegree;
        }
    } else //第三和第四象限
    {
        if (point.x <= centerPoint.x) //第三象限，不做任何处理
        {
            rotateDegree = M_PI + rotateDegree;
        }
        else //第四象限
        {
            rotateDegree = 2 * M_PI - rotateDegree;
        }
    }
    return rotateDegree;
}

-(NSMutableAttributedString *) formatBatteryLevel:(NSInteger)percent
{
    UIColor *textColor = [UIColor whiteColor];
    NSMutableAttributedString *attrText;
    
    NSString *percentText=[NSString stringWithFormat:@"%ld%%",(long)percent];
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setAlignment:NSTextAlignmentCenter];
    if (percent<10) {
        attrText=[[NSMutableAttributedString alloc] initWithString:percentText];
        UIFont *capacityNumberFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:60];
        UIFont *capacityPercentFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
        [attrText addAttribute:NSFontAttributeName value:capacityNumberFont range:NSMakeRange(0, 1)];
        [attrText addAttribute:NSFontAttributeName value:capacityPercentFont range:NSMakeRange(1, 1)];
        [attrText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, 2)];
        [attrText  addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, 2)];
        
    } else {
        attrText=[[NSMutableAttributedString alloc] initWithString:percentText];
        UIFont *capacityNumberFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:60];
        UIFont *capacityPercentFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
        
        
        if (percent>=100) {
            
            [attrText addAttribute:NSFontAttributeName value:capacityNumberFont range:NSMakeRange(0, 3)];
            [attrText addAttribute:NSFontAttributeName value:capacityPercentFont range:NSMakeRange(3, 1)];
            [attrText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, 4)];
            [attrText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, 4)];
        } else {
            [attrText addAttribute:NSFontAttributeName value:capacityNumberFont range:NSMakeRange(0, 2)];
            [attrText addAttribute:NSFontAttributeName value:capacityPercentFont range:NSMakeRange(2, 1)];
            [attrText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, 3)];
            [attrText  addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, 3)];
        }
        
    }
    
    
    return attrText;
}

-(NSMutableAttributedString *) formatLabel:(NSString*)text
{
    UIColor *textColor = [UIColor whiteColor];
    NSMutableAttributedString *attrText;
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setAlignment:NSTextAlignmentCenter];
 
    UIFont *font = [UIFont systemFontOfSize:14];
    
    attrText=[[NSMutableAttributedString alloc] initWithString:text];
    [attrText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    [attrText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, text.length)];
    [attrText  addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, text.length)];
    
    return attrText;
}

#pragma mark - Setter

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    [self setNeedsDisplay];
}

@end
