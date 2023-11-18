#include <stdio.h>
#include <math.h>

extern void add(int *, int, int, int);

int main()
{
    int arr[] = {1, 4, 0, 1, 3, 1,
                 2, 2, 4, 2, 2, 3,
                 1, 0, 1, 0, 1, 0,
                 1, 2, 1, 0, 2, 2,
                 2, 5, 3, 1, 2, 5,
                 1, 1, 4, 2, 3, 0};

    int arr2[] = {1, 4, 0, 1, 3, 1,
                  2, 2, 4, 2, 2, 3,
                  1, 0, 1, 0, 1, 0,
                  1, 2, 1, 0, 2, 2,
                  2, 5, 3, 1, 2, 5,
                  1, 1, 4, 2, 3, 0};
    int image_size_x = 6;
    int image_size_y = 6;
    int sampling_window_size = 5;

    int n = sizeof(arr) / sizeof(arr[0]);
    add(arr, image_size_x, image_size_y, sampling_window_size);

    printf("Done\n");
    return 0;
}
