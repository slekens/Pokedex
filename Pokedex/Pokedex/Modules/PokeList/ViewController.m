//
//  ViewController.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"MainViewTitle", @"");
    
    WebClient *client = [[WebClient alloc]init];
    
    [client fetchPokemonData:^(PokemonList * _Nullable pokemon, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"Pokemons: %@", pokemon.pokemonList);
        } else {
            NSLog(@"An error ocurred: %@", error);
        }
    }];
}


@end
