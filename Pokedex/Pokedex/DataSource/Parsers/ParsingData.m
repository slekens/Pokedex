//
//  ParseData.m
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import "ParsingData.h"

@implementation ParsingData

#pragma mark - Initialization

-(instancetype)init {
    self = [super init];
    return self;
}

#pragma mark - Parsing Data.

-(Pokemon*)parsePokemonData:(NSData*)responseObject {
    NSDictionary *response = [ParsingData serializeResponse: responseObject];
    Pokemon *pokemon = [[Pokemon alloc]init];
    if (response) {
        pokemon.name = response[@"name"];
        pokemon.baseExperience = [response[@"base_experience"]integerValue];
        pokemon.height = [response[@"height"]integerValue];
        pokemon.pokemonId = [response[@"id"]integerValue];
        pokemon.weight = [response[@"weight"]integerValue];
        pokemon.pictures = [self parsePokemonSprites: response[@"sprites"]];
        pokemon.types = [self parseTypes: response[@"types"]];
    }
    NSLog(@"%@", pokemon);
    return pokemon;
}

-(PokemonList*)parsePokemonDataList:(NSData*)responseObject {
    NSDictionary *response = [ParsingData serializeResponse: responseObject];
    PokemonList *pokemonList = [[PokemonList alloc]init];
    if (response) {
        pokemonList.previous = response[@"previous"];
        pokemonList.next = response[@"next"];
        pokemonList.count = [response[@"count"] integerValue];
        pokemonList.pokemonList = [NSMutableArray array];
        if ([response[@"results"] isKindOfClass: [NSArray class]]) {
            for (NSDictionary* item in response[@"results"]) {
                Pokemon *pokemon = [[Pokemon alloc]initWithName: item[@"name"] andURL: item[@"url"]];
                [pokemonList.pokemonList addObject: pokemon];
            }
        }
    }
    return pokemonList;
}

-(PokemonImage*)parsePokemonSprites:(id)responseObject {
    PokemonImage *images = [[PokemonImage alloc]init];
    if ([responseObject isKindOfClass: [NSDictionary class]]) {
        NSDictionary *others = responseObject[@"other"];
        NSDictionary *official = others[@"official-artwork"];
        if (official) {
            images.officialArtwork = official[@"front_default"];
        }
    }
    return images;
}

-(NSArray<PokemonTypes*>*)parseTypes:(id)responseObject {
    NSMutableArray *types = [[NSMutableArray alloc]init];
    if ([responseObject isKindOfClass: [NSArray class]]) {
        for(NSDictionary *item in responseObject) {
            if ([item isKindOfClass: [NSDictionary class]]) {
                NSDictionary *type = item[@"type"];
                PokemonTypes *pokeType = [[PokemonTypes alloc]initWithName: type[@"name"]];
                [types addObject: pokeType];
            }
        }
    }
    return types;
}

#pragma mark - Serialize Data.

+(NSDictionary* _Nullable)serializeResponse:(NSData*)data {
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData: data options: kNilOptions error: &error];
}

@end


