# KnuthMorrisPratt

KNUTH-MORRIS-PRATT STRING MATCHING [Python recipe](https://code.activestate.com/recipes/117214-knuth-morris-pratt-string-matching/)
created by [David Epstein](https://code.activestate.com/recipes/users/218935/)
translated to Nim.

This is an implementation of the Knuth-Morris-Pratt algorithm for finding copies
of a given pattern as a contiguous subsequence of a larger text.
Since KMP accesses the text only sequentially, it is natural to implement it in
a way that allows the text to be an arbitrary iterator.
After a preprocessing stage which takes time linear in the length of the pattern,
each text symbol is processed in constant amortized time.
