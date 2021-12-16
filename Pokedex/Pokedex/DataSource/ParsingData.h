//
//  ParseData.h
//  Pokedex
//
//  Created by Abraham Abreu on 15/12/21.
//

#import <Foundation/Foundation.h>
#import "PokemonList.h"
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParsingData : NSObject

+(PokemonList*)parsePokemonDataList:(id)responseObject;
+(Pokemon*)parsePokemonData:(id)responseObject;

@end

NS_ASSUME_NONNULL_END
