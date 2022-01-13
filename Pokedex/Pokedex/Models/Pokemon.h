//
//  Pokemon.h
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import <Foundation/Foundation.h>
#import "PokemonImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *url;
@property(nonatomic, assign)NSInteger baseExperience;
@property(nonatomic, assign)NSInteger height;
@property(nonatomic, assign)NSInteger pokemonId;
@property(nonatomic, assign)BOOL isDefault;
@property(nonatomic, copy)NSString *locationEncounters;
@property(nonatomic, assign)NSInteger order;
@property(nonatomic, assign)NSInteger weight;
@property(nonatomic, strong)PokemonImage *pictures;

-(instancetype)initWithName:(NSString*)name
                     andURL:(NSString*)url;
-(instancetype)initWithAll:(NSString*)name
            resourceURL:(NSString*)url
            baseExperience:(NSInteger)experience
                    height:(NSInteger)height
                 pokemonID:(NSInteger)pokemonID
                 isDefault:(BOOL)isDefault
 locationEncounterResource:(NSString*)locationURL
                     order:(NSInteger)order
                    weight:(NSInteger)weight
                   image:(PokemonImage*)pictures;

@end

NS_ASSUME_NONNULL_END
