//
//  main.c
//  Program V
//
//  Created by Illya Starikov on 5/2/14.
//  Copyright (c) 2014 iTz iLLi Production. All rights reserved.
//

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

typedef struct Cards
{
    char Suit[10];
    int Value;
    char Delt;
}aDeck;

aDeck myDeck[52];

int main(void)
{
    int x=0, y=0, i = 0;


    for (x=0; x < 4; x++)
    {
        for(y=0; y < 13; y++)
        {
            i = x * 13 + y;
            switch (x)
            {
                case 0:
                    strcpy(myDeck[i].Suit, "Diamonds");
                    myDeck[i].Value = y;
                    myDeck[i].Delt = 'N';
                    break;

                case 1:
                    strcpy(myDeck[i].Suit, "Clubs");
                    myDeck[i].Value = y;
                    myDeck[i].Delt = 'N';
                    break;

                case 2:
                    strcpy(myDeck[i].Suit, "Spades");
                    myDeck[i].Value = y;
                    myDeck[i].Delt = 'N';
                    break;

                case 3:
                    strcpy(myDeck[i].Suit, "Hearts");
                    myDeck[i].Value = y;
                    myDeck[i].Delt = 'N';
                    break;
            }
        }
    }

    printf("Your Hand Is:\n");
    for (i = 0; i < 5; i++)
    {
        printf("  %s %d\n", myDeck[i].Suit, myDeck[i].Value);
    }

    return 0;
}
