//
//  BaseCoordinator.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "AppCoordinator.h"

#pragma mark - Private Interface

@interface AppCoordinator()

@property(nonatomic, assign)UIWindow* window;

@end

@implementation AppCoordinator

@synthesize pokemonListCoordinator;

#pragma mark - Initialize.

-(instancetype)initWithWindow:(UIWindow*)window {
    self = [super init];
    self.window = window;
    self.pokemonListCoordinator = [[PokemonListCoordinator alloc]init];
    return self;
}

#pragma mark - Coordinator config.

-(UIViewController*)start {
    UIViewController* pokemonList = [self.pokemonListCoordinator start];
    self.window.rootViewController = pokemonList;
    [self.window makeKeyAndVisible];
    return pokemonList;
}

@end
