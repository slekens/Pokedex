//
//  Pokemon.h
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *url;
@property(nonatomic)NSInteger baseExperience;
@property(nonatomic)NSInteger height;
@property(nonatomic)NSInteger pokemonId;
@property(nonatomic)BOOL isDefault;
@property(nonatomic, copy)NSString *locationEncounters;
@property(nonatomic)NSInteger order;
@property(nonatomic)NSInteger weight;

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
                    weight:(NSInteger)weight;

@end

NS_ASSUME_NONNULL_END
