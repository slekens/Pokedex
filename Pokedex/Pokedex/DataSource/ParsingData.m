//
//  ParseData.m
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import "ParsingData.h"

@implementation ParsingData

#pragma mark - Parsing Data.

+(Pokemon*)parsePokemonData:(id)responseObject {
    Pokemon *pokemon = [[Pokemon alloc]init];
    if ([responseObject isKindOfClass: [NSDictionary class]]) {
        pokemon.name = responseObject[@"name"];
        pokemon.baseExperience = [responseObject[@"base_experience"]integerValue];
        pokemon.height = [responseObject[@"height"]integerValue];
        pokemon.pokemonId = [responseObject[@"id"]integerValue];
        pokemon.isDefault = [responseObject[@"is_default"]boolValue];
        pokemon.locationEncounters = responseObject[@"location_area_encounters"];
        pokemon.order = [responseObject[@"order"]integerValue];
        pokemon.weight = [responseObject[@"weight"]integerValue];
        
    }
    return pokemon;
}

+(PokemonList*)parsePokemonDataList:(id)responseObject {
    PokemonList *pokemonList = [[PokemonList alloc]init];
    if ([responseObject isKindOfClass: [NSDictionary class]]) {
        pokemonList.previous = responseObject[@"previous"];
        pokemonList.next = responseObject[@"next"];
        pokemonList.count = [responseObject[@"count"] integerValue];
        pokemonList.pokemonList = [NSMutableArray array];
        if ([responseObject[@"results"] isKindOfClass: [NSArray class]]) {
            for (NSDictionary* item in responseObject[@"results"]) {
                Pokemon *pokemon = [[Pokemon alloc]initWithName: item[@"name"] andURL: item[@"url"]];
                [pokemonList.pokemonList addObject: pokemon];
            }
        }
    }
    return pokemonList;
}

@end


