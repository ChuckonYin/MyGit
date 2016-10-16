//
//  WealthHealthCell.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "WealthHealthCell.h"
#import "WealthAcceleratorView.h"

@interface WealthHealthCell()

@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) CAGradientLayer *lineLayer;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIView *startView;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UIButton *moreButtun;
@property (nonatomic, strong) UIImageView *stateImageView;

@end

@implementation WealthHealthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.layer addSublayer:self.lineLayer];
        [self addSubview:self.typeLabel];
        [self addSubview:self.moreButtun];
        [self addSubview:self.stateImageView];
        [self addSubview:self.detailLab];
    }
    return self;
}

- (void)setModel:(WealthHealthModel *)model{
    _model = model;
    [self refreshUI];
}

- (void)refreshUI{
    _typeLabel.text = @[@"投资分布", @"还款能力", @"流动性", @"保险保障"][_model.type];
}

- (void)moreButtunClick{
    if (_delegate && [_delegate respondsToSelector:@selector(wealthHealthCellClick:)]) {
        [_delegate wealthHealthCellClick:_model.type];
    }
}

#pragma mark - get & set

- (CAGradientLayer *)lineLayer{
    if (!_lineLayer) {
        _lineLayer = [CAGradientLayer layer];
        _lineLayer.frame = CGRectMake(50, 0, 2, 67);
        if ([self.reuseIdentifier isEqualToString:@"lastCellid"]) {
            _lineLayer.frame = CGRectMake(50, 0, 2, 67);
            _lineLayer.colors = @[(id)([UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor),
                                      (id)([UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:0.2].CGColor)];
        }
        else{
            _lineLayer.colors = @[(id)([UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor),
                                      (id)([UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor)];
        }
        _lineLayer.startPoint = CGPointMake(0, 0);
        _lineLayer.endPoint = CGPointMake(0, 1);
    }
    return _lineLayer;
}

- (NSArray *)types{
    if (!_types) {
        _types = @[@"投资分布",@"还款能力",@"流动性",@"保险保障"];
    }
    return _types;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 3, 100, 14)];
        _typeLabel.textColor = [UIColor colorWithHex:0x465a94 alpha:1];
    }
    return _typeLabel;
}

- (UIButton *)moreButtun{
    if (!_moreButtun) {
        _moreButtun = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-79-20, _typeLabel.frame.origin.y, 79, 30)];
        [_moreButtun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _moreButtun.layer.cornerRadius = _moreButtun.frame.size.height/2;
        _moreButtun.clipsToBounds = YES;
        _moreButtun.layer.borderWidth = 1.5f;
        _moreButtun.layer.borderColor = [UIColor colorWithHex:0xff4141 alpha:1].CGColor;
        [_moreButtun setTitleColor:[UIColor colorWithHex:0xff4141 alpha:1] forState:UIControlStateNormal];
        _moreButtun.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreButtun setTitle:@"查看详情" forState:UIControlStateNormal];
        [_moreButtun addTarget:self action:@selector(moreButtunAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButtun;
}

- (UIImageView *)stateImageView{
    if (!_stateImageView) {
        UIImage *img = [UIImage imageNamed:@"wealthHealth_gantanhao@2"];
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19.5, 0, img.size.width, img.size.height)];
        _stateImageView.image = img;
        _stateImageView.center = CGPointMake(_lineLayer.position.x, img.size.height/2.0);
    }
    return _stateImageView;
}

- (UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.typeLabel.frame.origin.x, self.typeLabel.frame.origin.y+20, 200, 60)];
        _detailLab.text = @"您的风险偏好类型为 稳健型";
        _detailLab.textColor = [UIColor colorWithHex:0x7e8db8 alpha:1];
        _detailLab.font = [UIFont systemFontOfSize:14];
        _detailLab.numberOfLines = 0;
        [_detailLab sizeToFit];
    }
    return _detailLab;
}

- (void)moreButtunAction:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(wealthHealthCellClick:)]) {
        [_delegate wealthHealthCellClick:_model.type];
    }
}

@end
