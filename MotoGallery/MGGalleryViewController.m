//
//  MGGalleryViewController.m
//  MotoGallery
//
//  Created by Nanting Yang on 3/29/14.
//  Copyright (c) 2014 Nanting Yang. All rights reserved.
//

#import "MGGalleryViewController.h"
#import "MGPhoto.h"

@interface MGGalleryViewController ()
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *photos;
@end

@implementation MGGalleryViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.photos = [NSMutableArray array];
    [self loadImages];
}

- (void)loadImages {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
    {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            MGPhoto *photo = [MGPhoto createWithAsset:result];
            [self.photos addObject:photo];
        }];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
