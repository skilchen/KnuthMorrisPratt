## Knuth-Morris-Pratt string matching
## David Eppstein, UC Irvine, 1 Mar 2002


proc initShiftTable(n: int): seq[int] =
  result = newSeq[int](n)
  for i in countUp(0, n - 1):
    result[i] = 1

iterator KnuthMorrisPratt*(text, pattern: string): int =
  ##
  ## Yields all starting positions of copies of the pattern in the text.
  ## 
  runnableExamples:
    import strutils
    let str = "hello nim world".repeat(10)
    let pat = "nim"
    for pos in KnuthMorrisPratt(str, pat):
      assert str[pos .. (pos + len(pat) - 1)] == "nim"

  let lenPat = len(pattern)

  # build table of shift amounts
  var shifts = initShiftTable(lenPat + 1)
  var shift = 1
  for pos in 0 ..< lenPat:
    while shift <= pos and pattern[pos] != pattern[pos-shift]:
      shift += shifts[pos - shift]
    shifts[pos + 1] = shift

  # do the actual search
  var startPos = 0
  var matchLen = 0
  for c in text:
    while matchLen == lenPat or 
          matchLen >= 0 and pattern[matchLen] != c:
      startPos += shifts[matchLen]
      matchLen -= shifts[matchLen]
    matchLen += 1
    if matchLen == lenPat:
      yield startPos
      
when isMainModule:
  from strutils import repeat
  let str = "hello world".repeat(100)
  let pat = "world"
  for i in KnuthMorrisPratt(str, pat):
    echo i, " ", str[i .. (i+len(pat)-1)]