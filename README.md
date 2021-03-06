sort
====

Abstract:
It can be difficult for any beginning programmer to understand what a sorting algorithm does. This makes it difficult to understand why a one sorting algorithm is better than another. If you throw formulae and proofs at the student, the tendency is to shut down one's mind and accept that smarter people have figured all this stuff already--so there is no point in engaging when memorization works just as well. The author believes that good programmers actually understand the algorithms they use--not simply memorize. Thus, students need a visual representation of the algorithms as they work on a set to provide an intuition that will guide the more rigorous understanding.

Purpose:
sort_android is an open source project intended to educate beginning programmers regarding sorting algorithms by allowing them to repeatedly experiment and interact with the algorithms, comparing the performance of different algorithms side-by-side.

Language:
Processing 2.0: http://processing.org/

Recent Updates:
1. Added InsertionSort (the button is no longer a placeholder)
2. Provided three options for starting sort: nearly sorted, reverse sorted, and random sorted
3. Added a sound toggle
4. Added a desktop version

Known issues:
- It takes two update cycles to perform a swap, but only one update cycle to perform a compare. This tends to make SelectionSort run very fast in comparison to InsertionSort, when, in practice, that's not actually true.

Next updates:
- In some systems, writes are more expensive than reads. Perhaps I'll add an option to adjust the relative time it takes to do a compare vs. a swap.
- Independent left/right sound toggle

Android Verison:
The current apk is for Android 2.3.3

Tested devices:
    - ViewSonic G Tablet running Android 2.3.5 (VeganTab)

How to run:
You have two choices:
    1. Download the apk and install it on your device.
    2. Download the source and use Processing to install it on your device.
For 2, see http://wiki.processing.org/w/Android

To Contribute or make suggestions on improvements:
Contact Ryan at ryansgot@gmail.com
