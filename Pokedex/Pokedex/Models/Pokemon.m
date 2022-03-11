//
//  Pokemon.m
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import "Pokemon.h"

@implementation Pokemon

@synthesize name, url, baseExperience, height, pokemonId, weight, pictures, types;

#pragma mark - Initialization.

-(instancetype)initWithName:(NSString*)name andURL:(NSString*)url {
    self = [super init];
    self.name = name;
    self.url = url;
    return self;
}

-(instancetype)initWithAll:(NSString *)name
               resourceURL:(NSString *)url
            baseExperience:(NSInteger)experience
                    height:(NSInteger)height
                 pokemonID:(NSInteger)pokemonID
                    weight:(NSInteger)weight
                     image:(PokemonImage *)pictures
                  andTypes:(nonnull NSArray<PokemonTypes *> *)types {
    self = [super init];
    self.name = name;
    self.url = url;
    self.baseExperience = experience;
    self.height = height;
    self.pokemonId = pokemonID;
    self.weight = weight;
    self.pictures = pictures;
    self.types = types;
    return self;
}

-(instancetype)initWithModel:(PokemonMO *)model {
    self = [super init];
    self.name = model.name;
    self.url = model.pokemonURL;
    self.baseExperience = model.baseExperience;
    self.height = model.height;
    self.pokemonId = model.pokemonId;
    self.weight = model.weight;
    PokemonImage *pictures = [[PokemonImage alloc]initWithImageURL: model.oficialArtwork];
    self.pictures = pictures;
    return self;
}

-(NSString*)description {
    NSString *name = [NSString stringWithFormat: @"\nPokemon Name: %@", self.name];
    NSString *pokeId = [NSString stringWithFormat: @"\nPokemon Number: %ld", self.pokemonId];
    NSString *experience = [NSString stringWithFormat: @"\nPokemon Base Experience: %ld", self.baseExperience];
    NSString *pokeHeight = [NSString stringWithFormat: @"\nHeight: %ld", self.height];
    NSString *pokeWeigth = [NSString stringWithFormat: @"\nWeight: %ld", self.weight];
    NSString *oficialArtwork = [NSString stringWithFormat: @"\nImage Url: %@", self.pictures.officialArtwork];
    NSString *types = [NSString stringWithFormat: @"\nTypes: %@", self.types];
    return [NSString stringWithFormat: @"%@ %@ %@ %@ %@ %@ %@", name, pokeId, experience, pokeHeight, pokeWeigth, oficialArtwork, types];
}

@end
