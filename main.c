#include <stdio.h>
#include <math.h>
extern int add(int *, int);

int main()
{
    int arr[] = {1, 4, 0, 1, 3, 1,
                 2, 2, 4, 2, 2, 3,
                 1, 0, 1, 0, 1, 0,
                 1, 2, 1, 0, 2, 2,
                 2, 5, 3, 1, 2, 5,
                 1, 1, 4, 2, 3, 0}; // Example array

    int arr2[] = {1, 4, 0, 1, 3, 1,
                  2, 2, 4, 2, 2, 3,
                  1, 0, 1, 0, 1, 0,
                  1, 2, 1, 0, 2, 2,
                  2, 5, 3, 1, 2, 5,
                  1, 1, 4, 2, 3, 0}; // Example array

    int n = sizeof(arr) / sizeof(arr[0]); // Calculate the number of elements in the array
    int result = add(arr, n);             // Call the assembly function to sum the array
    printf("Sum of array elements: %d\n", result);
    scanf("%d", &result);
    return 0;
}
