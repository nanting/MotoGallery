//
//  MGPhoto.m
//  MotoGallery
//
//  Created by Nanting Yang on 3/29/14.
//  Copyright (c) 2014 Nanting Yang. All rights reserved.
//

#import "MGPhoto.h"

@implementation MGPhoto

+ (instancetype)createWithAsset:(ALAsset *)asset {
    MGPhoto *photo = [[MGPhoto alloc] init];
    photo.score = @1;
    photo.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
    return photo;
}


//
//@dynamic url;
//@dynamic score;
//@dynamic id;
//
//@synthesize thumbnail;

//+ (instancetype)createLocalModelWithAsset:(ALAsset *)asset
//                        inContext:(NSManagedObjectContext *)context {
//    MGPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:@"MGPhoto" inManagedObjectContext:context];
//    NSURL *url = [asset valueForProperty:ALAssetPropertyAssetURL];
//    photo.url = url.absoluteString;
//    photo.score = @1;
//    return photo;
//}

@end
