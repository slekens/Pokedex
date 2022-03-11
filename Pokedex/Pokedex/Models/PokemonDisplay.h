//
//  PokemonDisplay.h
//  Pokedex
//
//  Created by Abraham Abreu on 14/01/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import "PokemonMO.h"
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDisplay : NSObject

@property(nonatomic, copy)NSString *pokemonName;
@property(nonatomic, assign)NSInteger pokemonNumber;
@property(nonatomic, copy)NSString *pokemonImage;

-(instancetype)initWithPokemonName:(NSString*)name
                  andPokemonNumber:(NSInteger)number
                   andPokemonImage:(NSString*)image;

-(instancetype)initWithModel:(PokemonMO*)model;
-(instancetype)initWithVO:(Pokemon*)valueObject;

@end

NS_ASSUME_NONNULL_END
