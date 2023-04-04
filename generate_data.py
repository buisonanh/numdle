import random
import sys

numbers = []
for i in range(4000):
    while True:
        num = random.sample(range(10), 5)
        if not any(num.count(x) > 1 for x in num):
            numbers.append("'" + ''.join(map(str, num)) + "',")
            break

with open("numbers.txt", "w") as f:
    sys.stdout = f
    print(*numbers, sep='\n')
