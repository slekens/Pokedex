//
//  WebClient.m
//  Pokedex
//
//  Created by Abraham Abreu on 01/12/21.
//

#import "WebClient.h"

#pragma mark - Private interface.

@interface WebClient()

@property(nonatomic, strong)id<PokemonParserProtocol> parser;
@property(nonatomic, copy)NSString *actualURL;

@end

@implementation WebClient

@synthesize sessionConfiguration, manager, dataTask;

#pragma mark - Initialization.

-(instancetype)initWithParser:(id<PokemonParserProtocol>)parser {
    if (self = [super init]) {
        self.parser = parser;
        self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [NSURLSession sessionWithConfiguration: self.sessionConfiguration];
        self.actualURL = @"https://pokeapi.co/api/v2/pokemon/";
    }
    return self;
}

#pragma mark - WS Calls.

-(void)fetchList:(PokemonCompletionHandler)completionBlock {
    NSURL *url = [NSURL URLWithString: self.actualURL];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    __weak WebClient *weakSelf = self;
    self.dataTask = [self.manager dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completionBlock(nil, error);
        } else {
            PokemonList *list = [weakSelf.parser parsePokemonDataList: data];
            self.actualURL = list.next;
            completionBlock(list, nil);
        }
    }];
    [self.dataTask resume];
}

-(void)fetchPokemonData:(PokemonList *)pokemonlist andBlock:(PokemonDataCompletionHandler)completionBlock {
    
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray <Pokemon*> *pokemonList = [NSMutableArray array];
    
    __weak WebClient *weakSelf = self;

    for (Pokemon *pokemon in pokemonlist.pokemonList) {
        dispatch_group_enter(group);
        NSURL* url = [NSURL URLWithString: pokemon.url];
        NSURLRequest* request = [NSURLRequest requestWithURL: url];
        self.dataTask = [self.manager dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error);
                completionBlock(nil, error);
            } else {
                [pokemonList addObject: [weakSelf.parser parsePokemonData: data]];
            }
            dispatch_group_leave(group);
        }];
        [self.dataTask resume];
    }

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completionBlock(pokemonList, nil);
    });
}


@end
