#include "prime.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int main()
{
    __uint32_t i;
    
    for(i=1; i < NUM_ELEMENTS; i++)
    {
        if (isPrime(i))
        {
            printf("%u is a prime number.\n", i);
        }

        else
        {
            printf("%u is NOT a prime number.\n", i);
        }
    }

    return 0;
}

bool isPrime(__uint32_t num)
{
    //begin w/ result set to true, test for composite numbers
    bool result = true;

    __uint32_t i;

    //base case for 1 - not a prime by definition
    if(num == 1)
    {
        return false;
    }

    //only need to test from 2 to half of num
    for(i = 2; i < (num / 2) + 1; i++)
    {
        //if remainder is 0, number is composite
        if ((num % i) == 0)
        {
            result = false;
        }
    }
    return result;
}