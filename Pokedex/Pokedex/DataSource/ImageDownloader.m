//
//  ImageDownloader.m
//  Pokedex
//
//  Created by Abraham Abreu on 10/01/22.
//

#import "ImageDownloader.h"

@interface ImageDownloader()

@property(nonatomic, strong)NSCache<NSString*, UIImage*> *imageCache;

@end

@implementation ImageDownloader

#pragma mark - Initialization.

+(instancetype)sharedImageDownloader {
    static dispatch_once_t onceToken;
    static ImageDownloader *shared;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc]initPrivate];
    });
    return shared;
}

-(instancetype)initPrivate {
    self = [super init];
    if (self) {
        _imageCache = [[NSCache alloc]init];
    }
    return self;
}

/// Download an Image from the given URL;
/// @param imageURL The String with the URL.
/// @param completionBlock The handler to return an UIImage or NSError.
- (NSURLSessionTask *)downloadImageWithURL:(NSString* )imageURL andHandler:(PokemonImageHandler)completionBlock {
    
    UIImage *cachedImage = [self.imageCache objectForKey: imageURL];
    if (cachedImage) {
        completionBlock(cachedImage, nil);
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString: imageURL];
    if(!url) {
        NSError *error = [NSError errorWithDomain: [[NSBundle mainBundle]bundleIdentifier] code: ImageDownloaderErrorInvalidURL userInfo: nil];
        completionBlock(nil, error);
        return nil;
    }
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
            return;
        }
        if(!data) {
            NSError *error = [NSError errorWithDomain: [[NSBundle mainBundle] bundleIdentifier] code: ImageDownloaderErrorNetworkError userInfo: nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
        }
        UIImage *thumbnail = [UIImage imageWithData: data];
        if (!thumbnail) {
            NSDictionary *userInfo = @{
                @"data": data,
                @"response": response ? response : [NSNull null]
            };
            NSError *error =[NSError errorWithDomain: [[NSBundle mainBundle] bundleIdentifier] code: ImageDownloaderErrorNotValidImage userInfo: userInfo];
            dispatch_sync(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
        }
        [self.imageCache setObject: thumbnail forKey: imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(thumbnail, nil);
        });
    }];
    [task resume];
    return task;
}

@end
