//
//  PokemonTypes.m
//  Pokedex
//
//  Created by Abraham Abreu on 09/03/22.
//

#import "PokemonTypes.h"

@implementation PokemonTypes

@synthesize name;

-(instancetype)initWithName:(NSString *)name {
    self = [super init];
    self.name = name;
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat: @"Type name: %@", self.name];
}

@end
