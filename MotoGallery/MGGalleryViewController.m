//
//  MGGalleryViewController.m
//  MotoGallery
//
//  Created by Nanting Yang on 3/29/14.
//  Copyright (c) 2014 Nanting Yang. All rights reserved.
//

#import "MGGalleryViewController.h"
#import "MGCollectionViewCell.h"

@interface MGGalleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *testPhotos;
@end

@implementation MGGalleryViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerNib:[UINib nibWithNibName:@"MGCollectionViewCell" bundle: nil] forCellWithReuseIdentifier: @"MGCell"];

    //set up datasource
    self.testPhotos = [NSArray arrayWithObjects:@"grumpycat1.jpg", @"grumpycat2.jpg", nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.testPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MGCell";

    MGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage *testImage = [UIImage imageNamed:[self.testPhotos objectAtIndex:indexPath.row]];
    cell.imageView.image = testImage;
    return cell;
}


#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval = CGSizeMake(100, 100);
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}


@end
