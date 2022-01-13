//
//  BaseCoordinator.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "AppCoordinator.h"

@interface AppCoordinator()

@property(nonatomic, assign)UIWindow* window;

@end

@implementation AppCoordinator

-(instancetype)initWithWindow:(UIWindow*)window {
    self = [super init];
    self.window = window;
    self.pokemonList = [[PokemonListCoordinator alloc]init];
    return self;
}

-(UIViewController*)start {
    UIViewController* pokemonList = [self.pokemonList start];
    self.window.rootViewController = pokemonList;
    [self.window makeKeyAndVisible];
    return pokemonList;
}

@end
