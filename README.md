# TG3DCard
## 卡牌3D 浏览

## ![](http://zhaoquntao/TG3DCard/Untitled.gif)![]
###主要代码
#### 自定义UICollectionViewFlowLayout
#### 重写方法
     - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
     // 设置cell尺寸 => UICollectionViewLayoutAttributes
    // 越靠近中心点,距离越小,缩放越大
    // 
    // 1.获取当前显示cell的布局
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    for (UICollectionViewLayoutAttributes *attr in attrs) { 
        // 2.计算中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
        // 3.计算比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * 0.25;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}

#### 什么时候调用:用户手指一松开就会调用
#### 作用:确定最终偏移量
#### 定位:距离中心点越近,这个cell最终展示到中心点
      - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    // 获取最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 获取距离中心点距离:注意:应该用最终的x
        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    // 移动间距
    targetP.x += minDelta;
    
    if (targetP.x < 0) {
        targetP.x = 0;
    }
    
    return targetP;
   }


#### 在滚动的时候是否允许刷新布局
     - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
         return YES;
    }

#### 创建流水布局
    - (TGFlowLayout *)setupCollectionViewFlowLayout {
    TGFlowLayout *layout = [[TGFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(250, 350);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = (ScreenW -250) * 0.5;

    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = 20;
    
    return layout;
     }

#### 创建UICollectionView
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



