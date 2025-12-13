//
//  main.c
//  Project IV
//
//  Created by Illya Starikov on 4/4/14.
//  Copyright (c) 2014 iTz iLLi Production. All rights reserved.
//

#include <stdio.h>
#include <string.h>

int main(void)
{
    char strStudent[25][25];
    int intScores[25];

    char strTemporaryName[25];
    int intTemporaryScore;

    char strName[25];
    int intScr = 0;
    int intCounter = 0;
    int intMean, intMedian;
    char Trans = 'Y';
    int intTotalScore = 0;
    int mode[101] = {0};
    int maxMode = 0, modeValue = 0;

    printf("Student Grade Statistics Program\n");
    printf("Enter student names and scores (empty name to finish)\n\n");

    do
    {
        printf("Enter Student Name: ");
        if (fgets(strName, sizeof(strName), stdin) != NULL) {
            strName[strcspn(strName, "\n")] = 0;
        }

        if (strlen(strName) > 0)
        {
            strcpy(strStudent[intCounter], strName);
            printf("Enter Score: ");
            scanf("%d", &intScr);
            getchar();
            if (intScr >= 0 && intScr <= 100)
                intScores[intCounter] = intScr;
            else
                intScores[intCounter] = 0;
            intCounter++;
        }
    } while (strlen(strName) > 0 && intCounter < 25);

    if (intCounter == 0) {
        printf("No students entered.\n");
        return 0;
    }

    Trans = 'Y';
    while (Trans == 'Y')
    {
        Trans = 'N';
        for (int i = 0; i < intCounter - 1; i++)
        {
            if (intScores[i] < intScores[i+1])
            {
                intTemporaryScore = intScores[i];
                intScores[i] = intScores[i+1];
                intScores[i+1] = intTemporaryScore;
                strcpy(strTemporaryName, strStudent[i]);
                strcpy(strStudent[i], strStudent[i+1]);
                strcpy(strStudent[i+1], strTemporaryName);
                Trans = 'Y';
            }
        }
    }

    for (int i = 0; i < intCounter; i++)
    {
        if (intScores[i] >= 0 && intScores[i] <= 100)
            mode[intScores[i]] += 1;
    }

    for (int i = 0; i <= 100; i++)
    {
        if (mode[i] > maxMode)
        {
            maxMode = mode[i];
            modeValue = i;
        }
    }

    for (int i = 0; i < intCounter; i++)
        intTotalScore += intScores[i];

    intMean = intTotalScore / intCounter;
    intMedian = intScores[intCounter / 2];

    printf("\n--- Results (sorted by score) ---\n");
    for (int i = 0; i < intCounter; i++)
    {
        printf("%s: %d\n", strStudent[i], intScores[i]);
    }

    printf("\nMean: %d\n", intMean);
    printf("Median: %d\n", intMedian);
    printf("Mode: %d (appears %d times)\n", modeValue, maxMode);

    return 0;
}
