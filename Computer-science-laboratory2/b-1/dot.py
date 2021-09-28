import random

def dot_product(a, b):
    n = len(a)
    res = 0
    for i in range(n):
        res += a[i]*b[i]

    return res


n = int(input("整数を入力してください"))
a = []
b = []

for i in range(n):
    a.append(random.random())
    b.append(random.random())

print("a = ", a)
print("b = ", b)

c = dot_product(a, b)
print(c)
