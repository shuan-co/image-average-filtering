#include <stdio.h>
#include <string.h>
#include <math.h>

extern void add(int *, int *, int, int, int);

int main()
{   
    //  PARAMETERS
    int arr[] = {1, 4, 0, 1, 3, 1,
                 2, 2, 4, 2, 2, 3,
                 1, 0, 1, 0, 1, 0,
                 1, 2, 1, 0, 2, 2,
                 2, 5, 3, 1, 2, 5,
                 1, 1, 4, 2, 3, 0};

    int arr2[sizeof(arr)/4]; 
    memcpy(arr2, arr, sizeof(arr));

    //  PARAMETERS
    int image_size_x = 6;
    int image_size_y = 6;
    int sampling_window_size = 3;

    // DO NOT TOUCH
    int n = sizeof(arr) / sizeof(arr[0]);
    add(arr, arr2, image_size_x, image_size_y, sampling_window_size);

    printf("Contents of arr1:\n");
    for(int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
        if ((i + 1) % 6 == 0) {
            printf("\n");
        }
    }

    printf("Contents of arr2:\n");
    for(int i = 0; i < n; i++) {
        printf("%d ", arr2[i]);
        if ((i + 1) % 6 == 0) {
            printf("\n");
        }
    }

    return 0;
}
