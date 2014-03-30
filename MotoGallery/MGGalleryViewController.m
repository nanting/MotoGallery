//
//  MGGalleryViewController.m
//  MotoGallery
//
//  Created by Nanting Yang on 3/29/14.
//  Copyright (c) 2014 Nanting Yang. All rights reserved.
//

#import "MGGalleryViewController.h"
#import "MGCollectionViewCell.h"
#import "MGPhoto.h"

@interface MGGalleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIImageView *blurView;
@property (nonatomic) NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIImageView *displayedImageView;
@end

@implementation MGGalleryViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.blurView.hidden = YES;
    self.displayedImageView.hidden = YES;
    self.dismissButton.hidden = YES;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerNib:[UINib nibWithNibName:@"MGCollectionViewCell" bundle: nil] forCellWithReuseIdentifier: @"MGCell"];

    self.photos = [NSMutableArray array];
    [self loadImages];
}

- (void)loadImages {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
         [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
             MGPhoto *photo = [MGPhoto createWithAsset:result];
             [self.photos addObject:photo];
         }];
         [self.collectionView reloadData];
         
     } failureBlock:^(NSError *error) {
         NSLog(@"%@", error);
     }];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MGCell";

    MGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    MGPhoto *photo = [self.photos objectAtIndex:indexPath.row];
    cell.imageView.image = photo.thumbnail;
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MGPhoto *photo = self.photos[indexPath.row];
    NSInteger score = photo.score.integerValue + 1;
    photo.score = @(score);
    [self displayImage:photo.thumbnail];
}

- (void)displayImage:(UIImage *)highlightedImage {
    self.blurView.hidden = NO;
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImg = [CIImage imageWithCGImage:screenImg.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImg forKey:kCIInputImageKey];
    [filter setValue:@6.f forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImg extent]];
    
    self.blurView.image = [UIImage imageWithCGImage:cgImage];
    
    self.displayedImageView.hidden = NO;
    self.displayedImageView.image = highlightedImage;
    
    self.dismissButton.hidden = NO;
}

- (IBAction)dismiss:(id)sender {
    self.blurView.hidden = YES;
    self.displayedImageView.hidden = YES;
    self.dismissButton.hidden = YES;
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
