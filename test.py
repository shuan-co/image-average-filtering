def average_filter(pixel_values, image_size_x, image_size_y, sampling_window_size):
    if len(pixel_values) != image_size_x * image_size_y:
        raise ValueError(
            "Input pixel array size does not match the specified image dimensions.")

    if sampling_window_size % 2 == 0:
        raise ValueError("Sampling window size should be an odd number.")

    half_window = sampling_window_size // 2
    result = [0] * (image_size_x * image_size_y)

    for y in range(half_window, image_size_y - half_window):
        for x in range(half_window, image_size_x - half_window):
            total = 0
            for j in range(-half_window, half_window + 1):
                for i in range(-half_window, half_window + 1):
                    index = (y + j) * image_size_x + (x + i)
                    total += pixel_values[index]
            average = round(total / (sampling_window_size ** 2))
            print(average)
            result[y * image_size_x + x] = average

    return result


array = [1, 4, 0, 1, 3, 1,
         2, 2, 4, 2, 2, 3,
         1, 0, 1, 0, 1, 0,
         1, 2, 1, 0, 2, 2,
         2, 5, 3, 1, 2, 5,
         1, 1, 4, 2, 3, 0]

result = average_filter(array, 6, 6, 5)
# print(result)
# # Print the result in a 2D format
# for idx, value in enumerate(result):
#     if ((idx + 1) % 6) == 0:
#         print(value, end=" ")
#         print("")
#     else:
#         print(value, end=" ")
