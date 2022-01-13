//
//  PokemonListViewModel.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "PokemonListViewModel.h"

@implementation PokemonListViewModel

@synthesize title, pokemonList, service;

-(instancetype)initWithService:(WebClient*)client {
    self = [super init];
    self.service = client;
    return self;
}

@end
