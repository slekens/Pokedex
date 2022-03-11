//
//  PokemonMO.h
//  Pokedex
//
//  Created by Abraham Abreu on 25/02/22.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonMO : NSManagedObject

@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)NSInteger pokemonId;
@property(nonatomic, strong)NSString *pokemonURL;
@property(nonatomic, strong)NSString *oficialArtwork;
@property(nonatomic, assign)NSInteger baseExperience;
@property(nonatomic, assign)NSInteger height;
@property(nonatomic, assign)NSInteger weight;
@property(nonatomic, assign)NSArray<NSNumber*>* types;

@end

NS_ASSUME_NONNULL_END
