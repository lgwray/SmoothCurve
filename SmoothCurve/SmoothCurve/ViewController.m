//
//  ViewController.m
//  SmoothCurve
//
//  Created by Jax on 2017/11/30.
//  Copyright © 2017年 Jax. All rights reserved.
//

#define kMinCurveAngle 45

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *layers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self reset:nil];
}

- (IBAction)reset:(UIButton *)sender {
    
    for (CAShapeLayer *layer in _layers) {
        [layer removeFromSuperlayer];
    }
    _layers = [NSMutableArray array];
    
    ///>生成随机点
    NSMutableArray *points = [NSMutableArray array];
    NSInteger NUM_POINTS = 10;
    for (int i = 0; i <= NUM_POINTS; i ++) {
        CGPoint point = CGPointMake(i * 375.0 / NUM_POINTS,  arc4random() % 667);
        [points addObject:NSStringFromCGPoint(point)];
    }
    ///>绘制直线
    for (int i = 0; i < points.count; i++) {
        if (i == points.count - 1) break;
        CGPoint point1 = CGPointFromString(points[i]);
        CGPoint point2 = CGPointFromString(points[i+1]);
        
        UIBezierPath *bez = [UIBezierPath bezierPath];
        [bez moveToPoint:point1];
        [bez addLineToPoint:point2];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 2.0;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.path = bez.CGPath;
        [self.view.layer addSublayer:layer];
        
        [_layers addObject:layer];
    }
    ///>绘制曲线
    for (int i = 0; i < points.count; i++) {
        NSArray *line;
        if (i == 0) {
            CGPoint point1 = CGPointFromString(points[0]);
            CGPoint point2 = CGPointFromString(points[0]);
            CGPoint point3 = CGPointFromString(points[1]);
            CGPoint point4 = CGPointFromString(points[2]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        } else if (i < points.count - 2) {
            CGPoint point1 = CGPointFromString(points[i - 1]);
            CGPoint point2 = CGPointFromString(points[i]);
            CGPoint point3 = CGPointFromString(points[i + 1]);
            CGPoint point4 = CGPointFromString(points[i + 2]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        } if (i == points.count - 2) {
            CGPoint point1 = CGPointFromString(points[i - 1]);
            CGPoint point2 = CGPointFromString(points[i]);
            CGPoint point3 = CGPointFromString(points[i + 1]);
            CGPoint point4 = CGPointFromString(points[i + 1]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        }
        
        NSArray *control = [self controlPointWithPoints:line smoothValue:1.0];
        
        UIBezierPath *bez = [UIBezierPath bezierPath];
        [bez moveToPoint:CGPointFromString(line[1])];
        [bez addCurveToPoint:CGPointFromString(line[2]) controlPoint1:CGPointFromString(control[0]) controlPoint2:CGPointFromString(control[1])];
        
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 1.0;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor greenColor].CGColor;
        layer.path = bez.CGPath;
        [self.view.layer addSublayer:layer];
        
        [_layers addObject:layer];
        
    }
    
    ///>绘制修正后的曲线
    
    NSMutableArray *normal_points = [points mutableCopy];
    
    for (int i = 0; i < normal_points.count; i ++) {
        if (i == normal_points.count - 2) break;
        
        CGPoint point1 = CGPointFromString(normal_points[i]);
        CGPoint point2 = CGPointFromString(normal_points[i+1]);
        CGPoint point3 = CGPointFromString(normal_points[i+2]);
        ///>向量p[i+1]p[i]
        CGPoint n1 = CGPointMake(point1.x - point2.x, point1.y - point2.y);
        ///>向量p[i+1]p[i+2]
        CGPoint n2 = CGPointMake(point3.x - point2.x, point3.y - point2.y);
        CGFloat cos = (n1.x * n2.x + n1.y * n2.y) / (fabs(sqrt(pow(n1.x, 2) + pow(n1.y, 2))) * fabs((sqrt(pow(n2.x, 2) + pow(n2.y, 2)))));
        ///>向量n_center = n1 + n2
        CGPoint n_center = CGPointMake(n1.x + n2.x, n1.y + n2.y);
        CGPoint n_center_point = CGPointMake(point2.x + n_center.x, point2.y + n_center.y);
        
        CGFloat radian2 = acos(cos);
        CGFloat angle = 180 / M_PI * radian2;
        
        CGPoint change_point = point2;
        while (angle < kMinCurveAngle) {
            if (n_center_point.y == point2.y) {
                //n_center 水平
                if (n_center_point.x < point2.x) {
                    //形状是这样的>
                    change_point = CGPointMake(change_point.x - 1, change_point.y);
                } else {
                    //形状是这样的<
                    change_point = CGPointMake(change_point.x + 1, change_point.y);
                }
            } else if (n_center_point.y > point2.y) {
                //形状是这样的v
                change_point.y += 1;
                change_point.x = (change_point.y - point2.y) * (n_center_point.x - point2.x) / (n_center_point.y - point2.y) +  point2.x;
            } else {
                //形状是这样的^
                change_point.y -= 1;
                change_point.x = (change_point.y - point2.y) * (n_center_point.x - point2.x) / (n_center_point.y - point2.y) +  point2.x;
            }
            angle = [self angleWithPoint1:point1 point2:change_point point3:point3];
            normal_points[i+1] = NSStringFromCGPoint(change_point);
        }
    }
    
    for (int i = 0; i < normal_points.count; i++) {
        NSArray *line;
        if (i == 0) {
            CGPoint point1 = CGPointFromString(normal_points[0]);
            CGPoint point2 = CGPointFromString(normal_points[0]);
            CGPoint point3 = CGPointFromString(normal_points[1]);
            CGPoint point4 = CGPointFromString(normal_points[2]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        } else if (i < points.count - 2) {
            CGPoint point1 = CGPointFromString(normal_points[i - 1]);
            CGPoint point2 = CGPointFromString(normal_points[i]);
            CGPoint point3 = CGPointFromString(normal_points[i + 1]);
            CGPoint point4 = CGPointFromString(normal_points[i + 2]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        } if (i == points.count - 2) {
            CGPoint point1 = CGPointFromString(normal_points[i - 1]);
            CGPoint point2 = CGPointFromString(normal_points[i]);
            CGPoint point3 = CGPointFromString(normal_points[i + 1]);
            CGPoint point4 = CGPointFromString(normal_points[i + 1]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        }
        
        NSArray *control = [self controlPointWithPoints:line smoothValue:1.0];
        
        UIBezierPath *bez = [UIBezierPath bezierPath];
        [bez moveToPoint:CGPointFromString(line[1])];
        [bez addCurveToPoint:CGPointFromString(line[2]) controlPoint1:CGPointFromString(control[0]) controlPoint2:CGPointFromString(control[1])];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 1.0;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor yellowColor].CGColor;
        layer.path = bez.CGPath;
        [self.view.layer addSublayer:layer];
        
        [_layers addObject:layer];
        
    }
}


///p[i+1]p[i]和p[i+1]p[i+2]之间的夹角
- (CGFloat)angleWithPoint1:(CGPoint)point1 point2:(CGPoint)point2 point3:(CGPoint)point3 {
    
    CGPoint n1 = CGPointMake(point2.x - point1.x, point2.y - point1.y);
    CGPoint n2 = CGPointMake(point2.x - point3.x, point2.y - point3.y);
    CGFloat cos = (n1.x * n2.x + n1.y * n2.y) / (fabs(sqrt(pow(n1.x, 2) + pow(n1.y, 2))) * fabs((sqrt(pow(n2.x, 2) + pow(n2.y, 2)))));
    
    CGFloat radian2 = acos(cos);
    return 180 / M_PI * radian2;
}


///>求point[i]和point[i + 1]之间的两个控制点
- (NSArray *)controlPointWithPoints:(NSArray *)points smoothValue:(CGFloat)smooth_value {
    CGPoint point0 = CGPointFromString(points[0]);
    CGPoint point1 = CGPointFromString(points[1]);
    CGPoint point2 = CGPointFromString(points[2]);
    CGPoint point3 = CGPointFromString(points[3]);
    
    CGFloat x0 = point0.x;
    CGFloat y0 = point0.y;
    
    CGFloat x1 = point1.x;
    CGFloat y1 = point1.y;
    
    CGFloat x2 = point2.x;
    CGFloat y2 = point2.y;
    
    CGFloat x3 = point3.x;
    CGFloat y3 = point3.y;
    
    CGFloat xc1 = (x0 + x1) / 2.0;
    CGFloat yc1 = (y0 + y1) / 2.0;
    CGFloat xc2 = (x1 + x2) / 2.0;
    CGFloat yc2 = (y1 + y2) / 2.0;
    CGFloat xc3 = (x2 + x3) / 2.0;
    CGFloat yc3 = (y2 + y3) / 2.0;
    
    
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    
    CGFloat ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    CGFloat ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    
    CGFloat ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    CGFloat ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    
    return @[NSStringFromCGPoint(CGPointMake(ctrl1_x, ctrl1_y)),
             NSStringFromCGPoint(CGPointMake(ctrl2_x, ctrl2_y))];
}

@end
