//
//  PokemonSprites.h
//  Pokedex
//
//  Created by Abraham Abreu on 16/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonImage : NSObject

@property(nonatomic, copy)NSString *officialArtwork;

-(instancetype)initWithImageURL:(NSString*)oficialArtwork;

@end

NS_ASSUME_NONNULL_END
