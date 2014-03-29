//
//  MGPhoto.h
//  MotoGallery
//
//  Created by Nanting Yang on 3/29/14.
//  Copyright (c) 2014 Nanting Yang. All rights reserved.
//

@import Foundation;
@import CoreData;
@import AssetsLibrary;

@interface MGPhoto :NSObject
@property (nonatomic) NSNumber * score;
@property (nonatomic) UIImage *thumbnail;

+ (instancetype)createWithAsset:(ALAsset *)asset;

@end;

//@interface MGPhoto : NSManagedObject
//
//@property (nonatomic) NSString * url;
//@property (nonatomic) NSNumber * score;
//@property (nonatomic) NSString * id;
//@property (nonatomic) CGImageRef thumbnail;
////@property (nonatomic) UIImage *thumbnailImage;
//
//
//+ (instancetype)createLocalModelWithAsset:(ALAsset *)asset
//                        inContext:(NSManagedObjectContext *)context;
//
//
//@end
