//
//  PokemonSprites.m
//  Pokedex
//
//  Created by Abraham Abreu on 16/12/21.
//

#import "PokemonImage.h"

@implementation PokemonImage

@synthesize officialArtwork;

-(instancetype)initWithImageURL:(NSString *)oficialArtwork {
    self = [super init];
    self.officialArtwork = oficialArtwork;
    return self;
}

@end
