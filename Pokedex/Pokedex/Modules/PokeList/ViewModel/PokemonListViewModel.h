//
//  PokemonListViewModel.h
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import <Foundation/Foundation.h>
#import "PokemonDisplay.h"
#import "WebClient.h"
#import "CoreDataManager.h"

typedef void (^PokemonDisplayCompletionHandler)(NSMutableArray<PokemonDisplay *> * _Nullable pokemonList, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@protocol PokemonListViewProtocol <NSObject>

@optional
-(void)refresh;
-(void)showError:(NSError *)error;

@end

@protocol PokemonListViewModel <NSObject>

@required

-(void)viewDidLoad;
-(void)nextDataList;
-(void)search:(NSString *)searchText;
-(NSUInteger)numberOfItems;
-(NSUInteger)numberOfSections;
-(void)cancelSearch;
-(nullable PokemonDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath;
-(nullable PokemonDisplay *)didSelectAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

@interface PokemonListViewModel : NSObject<PokemonListViewModel>

@property(nonatomic, weak)id <PokemonListViewProtocol> pokemonListView;
@property(nonatomic, strong)WebClient *service;
@property(nonatomic, strong)NSMutableArray<PokemonDisplay *> *pokemonDisplayList;
@property(nonatomic, strong)NSMutableArray<PokemonDisplay *> *filteredPokemonList;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, assign)BOOL isFiltered;

-(instancetype)initWithService:(WebClient*)client andDatabaseManager:(CoreDataManager*)manager;

@end

NS_ASSUME_NONNULL_END
