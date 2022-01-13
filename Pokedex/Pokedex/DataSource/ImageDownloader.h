//
//  ImageDownloader.h
//  Pokedex
//
//  Created by Abraham Abreu on 10/01/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PokemonImageHandler)(UIImage* __nullable pokemonSprite, NSError * __nullable error);

typedef NS_ENUM(NSUInteger, ImageDownloaderError) {
    ImageDownloaderErrorInvalidURL,
    ImageDownloaderErrorNetworkError,
    ImageDownloaderErrorNotValidImage
};

@interface ImageDownloader : NSObject

+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedImageDownloader instead")));
- (instancetype)init __attribute__((unavailable("init not available, call sharedImageDownloader instead")));
+ (instancetype)new __attribute__((unavailable("new not available, call sharedImageDownloader instead")));
- (instancetype)copy __attribute__((unavailable("copy not available, call sharedImageDownloader instead")));

@property(class, nonnull, readonly, strong)ImageDownloader *sharedImageDownloader;

- (NSURLSessionTask * _Nullable)downloadImageWithURL:(NSString* )imageURL andHandler:(PokemonImageHandler)completionBlock;

@end

NS_ASSUME_NONNULL_END
