---
title:  "算法"
category: Other
---

Think algorithmically. 以算法的方式思考，将现实世界里的问题量化，将知识转化为实际编写代码来解决这些问题。

## 搜索

### Linear Search

以数组为例，任何时候从左到右或从右到左搜索时，称为**线性搜索**。无论朝哪个方向，都在走一条直线。

### Binary Search

以有序数组为例，采取一种 divide and conquer approach（分治的方法），从中间开始，要么向左要么向右查找，dividing and dividing in half（每次减半）查找范围，直到找到目标元素或搜索到边界，称为**二分搜索**。

<!--more-->
举个例子，从n个储物柜里找出存放了50美元的柜子。二分搜索的伪代码如下：

```
If no doors left
    Return false
If 50 behind doors[middle]
    Return true
Else if 50 < doors[middle] 
    Search doors[0] through doors[middle-1]
Else if 50 > doors[middle]
    Search doors[middle+1] through doors[n-1]
```

## 排序

### Selection sort

依次选择最小的元素。先找到最小的，再找次小的，以此类推。伪代码：

```
For i from 0 to n-1
    Find smallest number between numbers[i] and numbers[n-1]
    Swap smallest number with numbers[i]
```

该算法的效率如下：
```
(n-1) + (n-2) + (n - 3)... + 1 = n(n-1)/2 = n^2/2 - n/2 = O(n^2) = Ω(n^2)
```
即使在最好的情况下，即所有数字已经排序，选择排序算法也不会提前退出。

### Bubble sort

冒泡排序解决局部的问题，遍历数组，一遍又一遍比较相邻元素的大小，直到解决所有的小问题。伪代码：

```
Repeat n - 1 times
    For i from 0 to n-2
        If numbers[i] and numbers[i+1] out of order
            Swap them
    If no swaps
        Quit
```

该算法的效率如下：
```
(n - 1)x(n - 1)=n^2 -2n + 1 = O(n^2)
```
如果从左到右比较了整个数组，而没有进行任何交换，可认为数组已经排好序。因此最好的情况下该算法的效率是`Ω(n)`。

## Recursion 递归

递归是一种非常强大的解决技术。它紧凑/压缩了编写算法所需的代码行数，以一种完全不同的方式通过使用计算机内存来解决问题。

a function that calls itself. 将问题抽象成更小的子问题，递归地解决这些子问题。

例如打印马里奥游戏里的金字塔，打印4层金字塔，可以看成是在打印3层金字塔的基础上再多打印一层，该层含有 3 + 1 块砖头。

```C
// n为4，输出
// #
// ##
// ###
// ####
void draw(int n) {
    // If nothing to draw
    if (n <= 0) return;
    // Print pyramid of Height n - 1
    draw(n - 1);
    // Print one more row
    for (int i = 0; i < n; i++) {
        printf("#");
    }
    printf("\n");
}
```

### Merge sort

在CS编程中，如果你想花费更少的时间解决问题，就需要花费更多的空间。

归并排序：将问题规模依次减半，如果左右两边已经排好序，则将两个子数组合并成一个有序数组。伪代码：

```
If only one number
    Quit
Else 
    Sort left half of numbers
    Sort right half of numbers
    Merge sorted halves
```

举例：待排序数组有8个元素，先分成两个含有4个元素的子数组，再分成四个含义2个元素的子数组，再分成八个含义1个元素的子数组，每一层都必须将所有的子元素合并到一起。

移动的总次数 = 层数（logN：以2为底，8的对数）* n的宽度（每层元素的个数）= log2(8) * 8 = 24。

该算法的效率为`O(nlogn)`。

## 算法的运行时间

当谈论算法的好坏时，通常指的是算法的 Running time 或者 efficiency。

而在谈论算法的效率时又通常忽略常量因子，即 n 足够大时，常数因子对算法的影响可以忽略不计。如 O(n/2) 与 O(n) 虽然前者从技术上快2倍，但当n足够大时，两者越来越相似；对于 O(log2^n) ，很容易将对数的底数换成其他数字，因此常概括为 O(logn)。

用图形解释：以x轴表示问题的规模，y轴表示解决问题的时间，无限拉大x轴和y轴，常量因子不会改变算法的形状。

### 大写英文字母 O

表示可能要计数的上限，通常用来考虑**最差的情况**worst case。运行效率从高到低依次为：

+ O(1)：常数时间（并不是说只需要一步，而是指不论规模多大，某件事只需执行一步或一定数量的步骤），如：打印。
+ O(logn)：Binary search。
+ O(n)：Linear search。
+ O(nlogn)：Merge sort。
+ O(n^2)：n个人做n件事，如：Selection sort、冒泡排序。

### 大写希腊字母 Ω

表示下限，算法在**最好的情况**下需要的步骤。运行效率从高到低依次为：

+ Ω(1)：Linear search、Binary search。
+ Ω(n)：冒泡排序。
+ Ω(nlogn)：Merge sort。
+ Ω(n^2)：Selection sort。

### 大写罗马字母 Θ

表示算法在最好和最坏的情况下运行时间相同，即 O 和 Ω 相同

+ Θ(n)，仍然需要n步。
+ Θ(nlogn)：Merge sort。
+ Θ(n^2)：Selection sort。
