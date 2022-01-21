//
//  PokemonDisplay.h
//  Pokedex
//
//  Created by Abraham Abreu on 14/01/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDisplay : NSObject

@property(nonatomic, strong)NSString *pokemonName;
@property(nonatomic, assign)NSInteger pokemonNumber;
@property(nonatomic, strong)NSString *pokemonImage;

-(instancetype)initWithPokemonName:(NSString*)name
                  andPokemonNumber:(NSInteger)number
                   andPokemonImage:(NSString*)image;

@end

NS_ASSUME_NONNULL_END
