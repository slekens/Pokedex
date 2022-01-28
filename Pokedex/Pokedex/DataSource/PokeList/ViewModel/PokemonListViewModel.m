//
//  PokemonListViewModel.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "PokemonListViewModel.h"

@interface PokemonListViewModel()

@property(nonatomic, strong)PokemonList *pokemonDataList;

@end

@implementation PokemonListViewModel

@synthesize title, pokemonList, service;

#pragma mark - Initialization.

-(instancetype)initWithService:(WebClient*)client {
    self = [super init];
    self.service = client;
    self.shouldShowLoader = true;
    self.pokemonList = [[NSMutableArray alloc]init];
    return self;
}

#pragma mark - Fetch Data.

-(void)fetchData:(PokemonDisplayCompletionHandler _Nullable)completionBlock {
    __weak PokemonListViewModel *weakSelf = self;
    [self.service fetchList: ^(PokemonList * _Nullable pokemon, NSError * _Nullable error) {
        if (error == nil) {
            weakSelf.pokemonDataList = pokemon;
            [weakSelf
                 .service fetchPokemonData: pokemon andBlock: ^(NSArray<Pokemon *> * _Nullable pokemonList, NSError * _Nullable error) {
                
                    if (error == nil) {
                        for (Pokemon *pokemonItem in pokemonList) {
                            [weakSelf.pokemonList addObject: [[PokemonDisplay alloc]initWithPokemonName: pokemonItem.name
                                                                       andPokemonNumber: pokemonItem.pokemonId
                                                                        andPokemonImage: pokemonItem.pictures.officialArtwork]];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completionBlock(weakSelf.pokemonList, nil);
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completionBlock(nil, error);
                        });
                    }
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
        }
    }];
}

#pragma mark - View Methods.

- (void)viewDidLoad {
    [self fetchData];
}

-(void)nextDataList {
    [self fetchData];
}

-(void)fetchData {
    __weak PokemonListViewModel *weakSelf = self;
    [self fetchData:^(NSMutableArray<PokemonDisplay *> * _Nullable pokemonList, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf.pokemonListView showError: error];
            } else {
                
                [weakSelf.pokemonListView refresh];
            }
        });
    }];
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
