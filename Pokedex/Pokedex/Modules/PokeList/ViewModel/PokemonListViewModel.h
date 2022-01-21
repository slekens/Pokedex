//
//  PokemonListViewModel.h
//  Pokedex
//
//  Created by Abraham Abreu on 12/01/22.
//

#import <Foundation/Foundation.h>
#import "PokemonDisplay.h"
#import "WebClient.h"

typedef void (^PokemonDisplayCompletionHandler)(NSMutableArray<PokemonDisplay *> * _Nullable pokemonList, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@protocol PokemonListViewModelCoordinatorDelegate <NSObject>

@required
-(void)didTapOnRow:(Pokemon*)pokemon;

@end

@protocol PokemonListViewModel <NSObject>

@required

-(void)viewDidLoad;
-(void)fetchData:(PokemonDisplayCompletionHandler _Nullable)completionBlock;
- (NSUInteger)numberOfItems;
- (NSUInteger)numberOfSections;
- (nullable PokemonDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PokemonListViewModel : NSObject<PokemonListViewModel>

@property(nonatomic, strong)WebClient *service;
@property(nonatomic, strong)NSMutableArray<PokemonDisplay *> *pokemonList;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, assign)Boolean shouldShowLoader;

-(instancetype)initWithService:(WebClient*)client;

@end

NS_ASSUME_NONNULL_END
