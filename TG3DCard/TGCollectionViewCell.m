//
//  TGCollectionViewCell.m
//  TG3DCard
//
//  Created by 赵群涛 on 2016/11/8.
//  Copyright © 2016年 赵群涛. All rights reserved.
//

#import "TGCollectionViewCell.h"

@interface TGCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;


@end

@implementation TGCollectionViewCell


- (void)setImage:(UIImage *)image {
    _image = image;
    _cellImage.image = image;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
