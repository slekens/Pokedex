//
//  Pokemon.m
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import "PokemonList.h"

@implementation PokemonList

@synthesize previous, next, count, pokemonList;

#pragma mark - Initialization.

-(instancetype)initWithNext:(NSString *)next andPrevious:(NSString*)previous andCount:(NSInteger)count andPokemons:(NSMutableArray<Pokemon*>*)pokemonList {
    self = [super init];
    self.previous = previous;
    self.next = next;
    self.count = count;
    self.pokemonList = pokemonList;
    return self;
}

@end
