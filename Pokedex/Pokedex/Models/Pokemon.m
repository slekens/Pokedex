//
//  Pokemon.m
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import "Pokemon.h"

@implementation Pokemon

@synthesize name, url, baseExperience, height, pokemonId, isDefault, locationEncounters, order, weight, pictures;

#pragma mark - Initialization.

-(instancetype)initWithName:(NSString*)name andURL:(NSString*)url {
    self = [super init];
    self.name = name;
    self.url = url;
    return self;
}

-(instancetype)initWithAll:(NSString *)name resourceURL:(NSString *)url baseExperience:(NSInteger)experience height:(NSInteger)height pokemonID:(NSInteger)pokemonID isDefault:(BOOL)isDefault locationEncounterResource:(NSString *)locationURL order:(NSInteger)order weight:(NSInteger)weight image:(PokemonImage *)pictures {
    self = [super init];
    self.name = name;
    self.url = url;
    self.baseExperience = experience;
    self.height = height;
    self.pokemonId = pokemonID;
    self.isDefault = isDefault;
    self.locationEncounters = locationURL;
    self.order = order;
    self.weight = weight;
    self.pictures = pictures;
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat: @"\nPokemon Name: %@  \nBase Experience: %ld \nHeight: %ld\nWeight: %ld",  self.name, self.baseExperience, self.height, self.weight];
}

@end
