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

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *layers;
@property (nonatomic, strong) NSArray *drawPoints;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;

@property (nonatomic, strong) NSMutableArray *line1Points;
@property (nonatomic, strong) NSMutableArray *line2Points;
@property (nonatomic, strong) NSMutableArray *line3Points;

@property (nonatomic, assign) CGFloat minX1;
@property (nonatomic, assign) CGFloat maxX1;
@property (nonatomic, assign) CGFloat minY1;
@property (nonatomic, assign) CGFloat maxY1;

@property (nonatomic, assign) CGFloat minX2;
@property (nonatomic, assign) CGFloat maxX2;
@property (nonatomic, assign) CGFloat minY2;
@property (nonatomic, assign) CGFloat maxY2;

@property (nonatomic, assign) CGFloat minX3;
@property (nonatomic, assign) CGFloat maxX3;
@property (nonatomic, assign) CGFloat minY3;
@property (nonatomic, assign) CGFloat maxY3;

@end

@implementation ViewController

- (void)setLine1 {
    
    NSString *pointString1 = @"3000,45704;3250,45565;3290,45500;3365,45250;3500,45101;3750,45080;3962,45250;3956,45500;4000,45558;4079,45500;4051,45250;4250,45082;4500,45169;4636,45000;4524,44750;4500,44736;4250,44560;4201,44500;4000,44300;3851,44250;3750,44170;3610,44250;3500,44484;3485,44500;3250,44543;3045,44750;3000,44801;2801,45000;2826,45250;2873,45500;3000,45704";
    
    NSArray *points = [pointString1 componentsSeparatedByString:@";"];
    _line1Points = [NSMutableArray array];

    NSInteger scale = 5.0;
    
    NSArray *point0 = [points[0] componentsSeparatedByString:@","];
    _maxX1 = _minX1 = [point0[0] doubleValue] / scale;
    _maxY1 = _minY1 = [point0[1] doubleValue] / scale;
    
    for (NSString *point in points) {
        NSArray *xys = [point componentsSeparatedByString:@","];
        CGFloat x = ([xys[0] doubleValue] / scale);
        CGFloat y = ([xys[1] doubleValue] / scale);
        _minX1 = MIN(x, _minX1);
        _minY1 = MIN(y, _minY1);
        _maxX1 = MAX(x, _maxX1);
        _maxY1 = MAX(y, _maxY1);
        CGPoint xy = CGPointMake(x, y);
        [_line1Points addObject:NSStringFromCGPoint(xy)];
    }
}

- (void)setLine2 {

    NSString *pointString2 = @"5250,50028;5500,50130;5709,50250;5750,50276;6000,50462;6036,50500;6250,50649;6500,50711;6750,50656;7000,50587;7250,50528;7320,50500;7469,50250;7500,50154;7750,50141;8000,50093;8041,50000;8000,49946;7751,49750;7750,49747;7605,49500;7500,49431;7250,49437;7045,49500;7000,49629;6978,49750;6750,49897;6500,49829;6250,49763;6221,49750;6000,49517;5750,49640;5500,49725;5452,49750;5250,49955;5149,50000;5250,50028";
    
    NSArray *points = [pointString2 componentsSeparatedByString:@";"];
    _line2Points = [NSMutableArray array];
    
    NSInteger scale = 5.0;
    
    NSArray *point0 = [points[0] componentsSeparatedByString:@","];
    _maxX2 = _minX2 = [point0[0] doubleValue] / scale;
    _maxY2 = _minY2 = [point0[1] doubleValue] / scale;
    
    for (NSString *point in points) {
        NSArray *xys = [point componentsSeparatedByString:@","];
        CGFloat x = ([xys[0] doubleValue] / scale);
        CGFloat y = ([xys[1] doubleValue] / scale);
        _minX2 = MIN(x, _minX2);
        _minY2 = MIN(y, _minY2);
        _maxX2 = MAX(x, _maxX2);
        _maxY2 = MAX(y, _maxY2);
        CGPoint xy = CGPointMake(x, y);
        [_line2Points addObject:NSStringFromCGPoint(xy)];
    }
}

- (void)setLine3 {
    NSString *pointString3 = @"7750,48334;7855,48500;7848,48750;8000,48835;8220,49000;8250,49018;8432,49250;8452,49500;8453,49750;8489,50000;8500,50004;8750,50065;8991,50250;9000,50279;9250,50254;9253,50250;9285,50000;9250,49962;9000,49906;8855,49750;8851,49500;9000,49273;9048,49250;9000,49221;8759,49000;8750,48998;8500,48935;8299,48750;8250,48672;8086,48500;8000,48328;7862,48250;7786,48000;7750,47958;7732,48000;7734,48250;7750,48334";
    
    NSArray *points = [pointString3 componentsSeparatedByString:@";"];
    _line3Points = [NSMutableArray array];
    
    NSInteger scale = 5.0;
    
    NSArray *point0 = [points[0] componentsSeparatedByString:@","];
    _maxX3 = _minX3 = [point0[0] doubleValue] / scale;
    _maxY3 = _minY3 = [point0[1] doubleValue] / scale;
    
    for (NSString *point in points) {
        NSArray *xys = [point componentsSeparatedByString:@","];
        CGFloat x = ([xys[0] doubleValue] / scale);
        CGFloat y = ([xys[1] doubleValue] / scale);
        _minX3 = MIN(x, _minX3);
        _minY3 = MIN(y, _minY3);
        _maxX3 = MAX(x, _maxX3);
        _maxY3 = MAX(y, _maxY3);
        CGPoint xy = CGPointMake(x, y);
        [_line3Points addObject:NSStringFromCGPoint(xy)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _layers = [NSMutableArray array];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    [self.view bringSubviewToFront:_lineBtn];
    [self.view bringSubviewToFront:_resetBtn];

    _lineBtn.tag = 0;
    [_lineBtn setTitle:@"line1" forState:UIControlStateNormal];
    _resetBtn.tag = 0;
    [_resetBtn setTitle:@"直线" forState:UIControlStateNormal];
    
    [self setLine1];
    [self setLine2];
    [self setLine3];
    
    _scrollView.contentSize = CGSizeMake(_maxX1, _maxY1);
    _scrollView.contentOffset = CGPointMake(_minX1, _minY1);
    [self resetDrawPoints];
    
    [self drawSLineWithPoints];
}

- (void)resetDrawPoints {
    if (_lineBtn.tag == 0) {
        [_lineBtn setTitle:@"line1" forState:UIControlStateNormal];
        _drawPoints = _line1Points.copy;
        _scrollView.contentSize = CGSizeMake(_maxX1 + 100, _maxY1 + 100);
        _scrollView.contentOffset = CGPointMake(_minX1, _minY1);
    } else if (_lineBtn.tag == 1) {
        [_lineBtn setTitle:@"line2" forState:UIControlStateNormal];
        _drawPoints = _line2Points.copy;
        _scrollView.contentSize = CGSizeMake(_maxX2 + 100, _maxY2 + 100);
        _scrollView.contentOffset = CGPointMake(_minX2, _minY2);
    } else {
        [_lineBtn setTitle:@"line3" forState:UIControlStateNormal];
        _drawPoints = _line3Points.copy;
        _scrollView.contentSize = CGSizeMake(_maxX3 + 100 , _maxY3 + 100);
        _scrollView.contentOffset = CGPointMake(_minX3, _minY3);
    }
}

- (IBAction)lineBtnClicked:(UIButton *)sender {
    
    for (CAShapeLayer *layer in _layers) {
        [layer removeFromSuperlayer];
    }
    [_layers removeAllObjects];
    
    sender.tag ++;
    if (sender.tag == 3) {
        sender.tag = 0;
    }
    _resetBtn.tag = 0;
    
    [self resetDrawPoints];
    
    if (_resetBtn.tag == 0) {
        [self drawSLineWithPoints];
    } else if (_resetBtn.tag == 0) {
        [self drawCurve];
    } else {
        [self drawSLineWithPoints];
        [self drawCurve];
    }
}

- (IBAction)reset:(UIButton *)sender {
    
    for (CAShapeLayer *layer in _layers) {
        [layer removeFromSuperlayer];
    }
    [_layers removeAllObjects];
    
    sender.tag ++;
    if (sender.tag == 3) {
        sender.tag = 0;
    }
    
    if (_resetBtn.tag == 0) {
        [self drawSLineWithPoints];
    } else if (_resetBtn.tag == 1) {
        [self drawCurve];
         [_resetBtn setTitle:@"曲线" forState:UIControlStateNormal];
    } else {
        [self drawSLineWithPoints];
        [self drawCurve];
        [_resetBtn setTitle:@"混合" forState:UIControlStateNormal];
    }
}

- (void)drawSLineWithPoints {
    [_resetBtn setTitle:@"直线" forState:UIControlStateNormal];
    for (int i = 0; i < _drawPoints.count; i++) {
        if (i == _drawPoints.count - 1) break;
        CGPoint point1 = CGPointFromString(_drawPoints[i]);
        CGPoint point2 = CGPointFromString(_drawPoints[i+1]);
        
        UIBezierPath *bez = [UIBezierPath bezierPath];
        [bez moveToPoint:point1];
        [bez addLineToPoint:point2];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 0.5;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.path = bez.CGPath;
        [_scrollView.layer addSublayer:layer];
        [_layers addObject:layer];
        
        UIBezierPath *bez2 = [UIBezierPath bezierPath];
        [bez2 addArcWithCenter:point1 radius:2 startAngle:0 endAngle:M_2_PI clockwise:0];
        
        CAShapeLayer *layer2 = [CAShapeLayer layer];
        layer2.lineWidth = 0.5;
        layer2.fillColor = [UIColor clearColor].CGColor;
        layer2.strokeColor = [UIColor blueColor].CGColor;
        layer2.path = bez2.CGPath;
        [_scrollView.layer addSublayer:layer2];
        [_layers addObject:layer2];
    }
}

- (NSMutableArray *)removeBadPointsWithPoints:(NSMutableArray *)points {
    NSInteger count = points.count;
    NSInteger i = 0;
    NSInteger j = 1;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    for (i = 0; i < count; ) {
        if (i == count - 2) break;
        CGPoint prePoint = CGPointFromString(points[i]);
        CGPoint point = CGPointFromString(points[j]);
        if (sqrt(pow(point.x - prePoint.x, 2) + pow(point.y - prePoint.y, 2)) < 10) {
            [indexSet addIndex:j];
            j ++;
        } else {
            i = j;
            j = i + 1;
        }
    }
    
    [points removeObjectsAtIndexes:indexSet.copy];
    return points;
}

- (void)drawCurve {
   
    NSMutableArray *normal_points = [self removeBadPointsWithPoints:[_drawPoints mutableCopy]];
    
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
        CGFloat delta = MIN(fabs(point1.y - point2.y), fabs(point3.y - point2.y));
        if (delta < 1) continue;
        CGFloat correctUnitValue = MAX(delta * 0.2, 1);
        while (angle < kMinCurveAngle) {
            if (n_center_point.y == point2.y) {
                //n_center 水平
                if (n_center_point.x < point2.x) {
                    //形状是这样的>
                    change_point = CGPointMake(change_point.x - correctUnitValue, change_point.y);
                } else {
                    //形状是这样的<
                    change_point = CGPointMake(change_point.x + correctUnitValue, change_point.y);
                }
            } else if (n_center_point.y > point2.y) {
                //形状是这样的v
                change_point.y += correctUnitValue;
                change_point.x = (change_point.y - point2.y) * (n_center_point.x - point2.x) / (n_center_point.y - point2.y) +  point2.x;
            } else {
                //形状是这样的^
                change_point.y -= correctUnitValue                                                                                                                                 ;
                change_point.x = (change_point.y - point2.y) * (n_center_point.x - point2.x) / (n_center_point.y - point2.y) +  point2.x;
            }
            if (change_point.x < MIN(point1.x, point2.x) || change_point.x > MAX(point1.x, point2.x)) break;
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
        } else if (i < normal_points.count - 2) {
            CGPoint point1 = CGPointFromString(normal_points[i - 1]);
            CGPoint point2 = CGPointFromString(normal_points[i]);
            CGPoint point3 = CGPointFromString(normal_points[i + 1]);
            CGPoint point4 = CGPointFromString(normal_points[i + 2]);
            line = @[NSStringFromCGPoint(point1),
                     NSStringFromCGPoint(point2),
                     NSStringFromCGPoint(point3),
                     NSStringFromCGPoint(point4)];
        } if (i == normal_points.count - 2) {
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
        layer.lineWidth = 0.5;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.path = bez.CGPath;
        [_scrollView.layer addSublayer:layer];
        
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

///>绘制曲线
//    for (int i = 0; i < points.count; i++) {
//        NSArray *line;
//        if (i == 0) {
//            CGPoint point1 = CGPointFromString(points[0]);
//            CGPoint point2 = CGPointFromString(points[0]);
//            CGPoint point3 = CGPointFromString(points[1]);
//            CGPoint point4 = CGPointFromString(points[2]);
//            line = @[NSStringFromCGPoint(point1),
//                     NSStringFromCGPoint(point2),
//                     NSStringFromCGPoint(point3),
//                     NSStringFromCGPoint(point4)];
//        } else if (i < points.count - 2) {
//            CGPoint point1 = CGPointFromString(points[i - 1]);
//            CGPoint point2 = CGPointFromString(points[i]);
//            CGPoint point3 = CGPointFromString(points[i + 1]);
//            CGPoint point4 = CGPointFromString(points[i + 2]);
//            line = @[NSStringFromCGPoint(point1),
//                     NSStringFromCGPoint(point2),
//                     NSStringFromCGPoint(point3),
//                     NSStringFromCGPoint(point4)];
//        } if (i == points.count - 2) {
//            CGPoint point1 = CGPointFromString(points[i - 1]);
//            CGPoint point2 = CGPointFromString(points[i]);
//            CGPoint point3 = CGPointFromString(points[i + 1]);
//            CGPoint point4 = CGPointFromString(points[i + 1]);
//            line = @[NSStringFromCGPoint(point1),
//                     NSStringFromCGPoint(point2),
//                     NSStringFromCGPoint(point3),
//                     NSStringFromCGPoint(point4)];
//        }
//
//        NSArray *control = [self controlPointWithPoints:line smoothValue:1.0];
//
//        UIBezierPath *bez = [UIBezierPath bezierPath];
//        [bez moveToPoint:CGPointFromString(line[1])];
//        [bez addCurveToPoint:CGPointFromString(line[2]) controlPoint1:CGPointFromString(control[0]) controlPoint2:CGPointFromString(control[1])];
//
//
//        CAShapeLayer *layer = [CAShapeLayer layer];
//        layer.lineWidth = 1.0;
//        layer.fillColor = [UIColor clearColor].CGColor;
//        layer.strokeColor = [UIColor greenColor].CGColor;
//        layer.path = bez.CGPath;
//        [self.view.layer addSublayer:layer];
//
//        [_layers addObject:layer];
//
//    }

@end
