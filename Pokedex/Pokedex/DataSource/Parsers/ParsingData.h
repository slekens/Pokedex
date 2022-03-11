//
//  ParseData.h
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import <Foundation/Foundation.h>
#import "ServicesProtocol.h"
#import "PokemonList.h"
#import "Pokemon.h"
#import "PokemonImage.h"
#import "PokemonTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParsingData : NSObject<PokemonParserProtocol>

@end

NS_ASSUME_NONNULL_END
