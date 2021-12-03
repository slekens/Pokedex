//
//  Pokemon.m
//  Pokedex
//
//  Created by Abraham Abreu on 03/12/21.
//

#import "Pokemon.h"

@implementation Pokemon

-(instancetype)initWithName:(NSString*)name andURL:(NSString*)url {
    self = [super init];
    self.name = name;
    self.url = url;
    return self;
}

@end
