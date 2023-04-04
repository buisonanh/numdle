import random

numbers = []
while len(numbers) < 100:
    num_str = str(random.randint(1, 99999)).zfill(5)
    if num_str not in numbers:
        numbers.append(num_str)

# Print the list of numbers
print(numbers)
