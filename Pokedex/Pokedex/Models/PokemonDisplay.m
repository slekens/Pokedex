//
//  PokemonDisplay.m
//  Pokedex
//
//  Created by Abraham Abreu on 14/01/22.
//

#import "PokemonDisplay.h"

@implementation PokemonDisplay

@synthesize pokemonName, pokemonImage, pokemonNumber;

#pragma mark - Initialization.

-(instancetype)initWithPokemonName:(NSString*)name
                  andPokemonNumber:(NSInteger)number
                   andPokemonImage:(NSString*)image {
    self = [super init];
    self.pokemonName = name;
    self.pokemonNumber = number;
    self.pokemonImage = image;
    return self;
}

-(instancetype)initWithModel:(PokemonMO *)model {
    self = [super init];
    self.pokemonName = model.name;
    self.pokemonNumber = model.pokemonId;
    self.pokemonImage = model.pokemonURL;
    return self;
}

@end
