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
    self.shouldShowLoader = true;
    return self;
}

-(void)fetchData:(PokemonDisplayCompletionHandler _Nullable)completionBlock {
    __weak PokemonListViewModel *weakSelf = self;
    [self.service fetchList: ^(PokemonList * _Nullable pokemon, NSError * _Nullable error) {
        if (error == nil) {
            [weakSelf
                 .service fetchPokemonData: pokemon andBlock: ^(NSArray<Pokemon *> * _Nullable pokemonList, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error == nil) {
                        NSMutableArray<PokemonDisplay*> *list = [[NSMutableArray alloc]init];
                        for (Pokemon *pokemonItem in pokemonList) {
                            [list addObject: [[PokemonDisplay alloc]initWithPokemonName: pokemonItem.name
                                                                                   andPokemonNumber: pokemonItem.pokemonId
                                                                                    andPokemonImage: pokemonItem.pictures.officialArtwork]];
                            NSLog(@"Pokemon %@", pokemonItem.name);
                        }
                        [weakSelf setPokemonList: list];
                        completionBlock(list, nil);
                    } else {
                        completionBlock(nil, error);
                    }
                });
            }];
        } else {
            completionBlock(nil, error);
        }
    }];
}

- (void)viewDidLoad { 
    
}

- (nullable PokemonDisplay *)itemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row >= self.pokemonList.count) {
        return nil;
    }
    return self.pokemonList[indexPath.row];
}


- (NSUInteger)numberOfItems {
    return self.pokemonList.count;
}


- (NSUInteger)numberOfSections {
    return 1;
}



@end
