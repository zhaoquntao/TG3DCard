//
//  ViewController.m
//  TG3DCard
//
//  Created by 赵群涛 on 2016/11/8.
//  Copyright © 2016年 赵群涛. All rights reserved.
//

#import "ViewController.h"
#import "TGCollectionViewCell.h"
#import "TGFlowLayout.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width

static NSString * const TGID = @"TGcell";

@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TGFlowLayout *layout = [self setupCollectionViewFlowLayout];
    
    [self setupCollectionView:layout];
    
    
}

#pragma mark 创建流水布局
- (TGFlowLayout *)setupCollectionViewFlowLayout {
    TGFlowLayout *layout = [[TGFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(250, 350);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = (ScreenW -250) * 0.5;

    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = 20;
    
    return layout;
}


#pragma mark - 创建UICollectionView
- (void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.center = self.view.center;
    collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    
    // 设置数据源
    collectionView.dataSource = self;
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TGCollectionViewCell class])  bundle:nil] forCellWithReuseIdentifier:TGID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TGID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
