//
//  PokemonListViewModel.m
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import "PokemonListViewModel.h"

@interface PokemonListViewModel()

@property(nonatomic, strong)PokemonList *pokemonDataList;
@property(nonatomic, strong)CoreDataManager *databaseManager;

@end

@implementation PokemonListViewModel

@synthesize title, pokemonList, service, isFiltered;

#pragma mark - Initialization.

-(instancetype)initWithService:(WebClient*)client {
    self = [super init];
    self.service = client;
    self.isFiltered = NO;
    self.pokemonList = [[NSMutableArray alloc]init];
    self.databaseManager = [[CoreDataManager alloc]init];
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
                            PokemonDisplay *pokemon = [[PokemonDisplay alloc]initWithPokemonName: pokemonItem.name
                                                                                andPokemonNumber: pokemonItem.pokemonId
                                                                                 andPokemonImage: pokemonItem.pictures.officialArtwork];
                            [weakSelf.pokemonList addObject: pokemon];
                            //[weakSelf.databaseManager createNewEntryWith: pokemon];
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
    self.isFiltered = NO;
    [self fetchData];
}

-(void)nextDataList {
    self.isFiltered = NO;
    [self fetchData];
}

-(void)search:(NSString *)searchText {
    if (searchText == 0) {
        self.isFiltered = NO;
    } else {
        self.isFiltered = YES;
        self.filteredPokemonList = [[NSMutableArray alloc]init];
        for (PokemonDisplay* pokemon in self.pokemonList) {
            NSRange nameRange = [pokemon.pokemonName rangeOfString: searchText options: NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound) {
                [self.filteredPokemonList addObject: pokemon];
            }
        }
        [self.pokemonListView refresh];
    }
}

-(void)cancelSearch {
    self.isFiltered = NO;
    [self.pokemonListView refresh];
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

-(nullable PokemonDisplay *)itemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row >= self.pokemonList.count) {
        return nil;
    }
    if (self.isFiltered) {
        return self.filteredPokemonList[indexPath.row];
    } else {
        return self.pokemonList[indexPath.row];
    }
}

-(nullable PokemonDisplay *)didSelectAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row >= self.pokemonList.count) {
        return nil;
    }
    if (self.isFiltered) {
        return self.filteredPokemonList[indexPath.row];
    } else {
        return self.pokemonList[indexPath.row];
    }
}


- (NSUInteger)numberOfItems {
    if (self.isFiltered) {
        return self.filteredPokemonList.count;
    } else {
        return self.pokemonList.count;
    }
}


- (NSUInteger)numberOfSections {
    return 1;
}

@end
