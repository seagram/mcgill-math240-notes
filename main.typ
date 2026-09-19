#import "@preview/mousse-notes:1.1.0": *
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-venn:0.2.0"
#import "theme.typ": *

#show: theme

#show: book.with(
  title: [MATH 240],
  subtitle: [Discrete Structures],
  subsubtitle: [
    Fall 2026 Term
  ],
  subsubsubtitle: [
    #smallcaps[McGill University]
  ],
  epigraph: quote(
    attribution: [Arthur Eddington],
  )[Proof is the idol before which the pure mathematician tortures himself.],
  font-style: "serif",
)

#show: lecture-headings

#lecture[September 1st, 2026]

== Introduction

We have learned from Calculus that objects pertain to continuous functions and continous domains whose outputs are real numbers.
These can be translated to various physical phenomenons such as temperature or speed.
In Discrete Mathematics, the objects in question are ones seperated in space.
They may or may not be linked together. Take for example, the graph.
The objects within Discrete Mathematics are composed of a finitie definition and nature.
Think then of how any computer you may encounter levearges finite memory and thus, it can be considered discrete.
Therefore, we can think of Discrete Mathematics as "the math of computers".
This is not the only definition as Discrete Mathematics is not merely _this_.
But within its varied applications, it can be thought of in this way.
Not far divergent from computers, Discrete Mathematics finds itself in relation to programming, particularly, in graph algorithms and their applications.
In this class, however, we are soley concered about the theory behind these concepts.
One of the core elements of this course is to teach you how to complete rigorous proofs.
Set Theory and Logic serve as the foundations of establishing such proofs whereas the latter topics in the course leverage said proof structures for their respective applications.
Often we are dealing with objects that exists purely within our minds. 
Take the number 3. This number is not instantiated in our universe, but merely a concept confined to our thinking.
Proofs are a way to assess whether something is true in regards to abstract mathematical concepts and objects.

== Set Theory

#definition[
A _set_ is a collection of objects.
]

#example[
$ A = {1,2,3} "is a set." $
]

#definition[
  The _empty set_ ($emptyset$) contains no elements.
]

#example[
  $ emptyset = {} $
]

#definition[
  The _natural set_ contains all the elements of natural numbers.
  $ NN = {0,1,2,3,4,...} $
]

#definition[
  The _natural set without zero_ can be denoted by the following:
  $ NN^+ = {1,2,3,4,...} $
]

#definition[
  The _integer set_ contains all the integer numbers.
  $ ZZ = {..., -3,-2,-1,0,1,2,3, ...} $
]

#definition[
  The _real set_ contains all the real numbers.
  This is, it contains all rational and irrational numbers.
  $ RR = {..., -1, 0, 1/2, 1, 2.25, root(3, 9), pi} $
  *_Note_*: We are primarily concerned with real numbers in this course.
]

*_Notation_*: $x in A "implies that x is an element of the set A."$

#example[
$ 2 in NN $
$ -5 in.not NN $
$ x in.not emptyset "(by definition)" $
$ emptyset in.not emptyset $
]


== Subsets
#definition[
  A _subset_ is a set whose every element is contained inside another set.
  We denote this with the symbol: $subset.eq$ .
  $A subset.eq B$ implies that A is a subset of B.
  Alternatively, we say A is _included_ in B.
  We denote _implies_ with the symbol $=>$.
  Lastly, we denote "if-then" statements with $->$.
]

#example[
$ {1,2,3} subset.eq NN => 1 in NN, 2 in NN, 3 in NN. $
$ A subset.eq B -> x in A => x in B $

*_Note:_* the previous statement reads naturally as "$"If" A subset.eq B "then" x in A "implies" x in B $"
]

With this, we can establish that $X subset.eq X$.
That is, for any set $A$, $A$ is a _subset_ of its self.
This applies to the empty set as well: $emptyset subset.eq emptyset$.


=== Equality
#definition[
  For any two sets, $A, B$, we say $A$ and $B$ are _equal_ to each other if and only if $A$ is a subset of $B$ and $B$ is a subset of $A$.
  The order of the elements in either set are ignored.
  Additionally, repitions of the same element are ignored.
  We denote "if and only if" with $<==>$. 
  #v(0.5cm)
  $ A = B <==> A subset.eq B "and" B subset.eq A $
]

#example[
$ A = {1,2,3} $
$ B = {2,3,1} $
$ A = B $
]

#example[
  $ A = {1,2,3} $
  $ B = {1,1,2,3} $
  $ A = B $
]

== Sets Through Comprehension

So far, we examined sets only by _extension_ (illustrated with a list in curly brackets).
This is, however, not always the preffered method of expression.
#example[
  Consider the set of rational numbers: $QQ$.
  $ QQ = {..., 1/2, 0, (-2)/5, ...} $
]
There lacks any resemblence of order or pattern to this representation of the set.
A better definition could simply be "the fractions".
This is an example of a _definition by comprehension_:
collecting all elements from a given set which satisy a common property.
The notation is as follows:
$ A = { x in U | "x has property P"} $
*_Note:_* We use $U$ to denote _the universe_ or _the universal set_. That is, the set which contains all elements under consideration.
Any element which another set (e.g $A$, $B$) could contain exists within the universal set.

#example[
  Consider the set which contains all odd integers: $O$.
  #v(0.25cm)
  $ O = {..., -7, -5, -3, -1, 0, 1,3,5,7, ...} "(definition)" $
  $ O = { x in ZZ | "x is odd" } "(comprehension)" $
  #v(0.25cm)
  However, our definition by comprehension has presented a problem.
  Defining odd in terms of "odd" is a recursive definition. 
  So instead we'd say:
  #v(0.25cm)
  $ O = {x in ZZ | x = 2k + 1, k in ZZ } $
  Or more concisely:
  $ O = {2k + 1 | k in ZZ } $
]

#example[
  Consider the set which contains all rational numbers: $QQ$.
  $ QQ = {a/b | a in ZZ, b in NN^+ } $
  *_Note:_* We restrict $b$ to exist in the set $NN^+$ which includes all natural numbers except for 0 since no element within the rational set contains a denomenator of 0.
  We therefore do not write $2/(-3)$ but $(-2)/3$ instead.

]

Consider, however, that an element such as $2/4$ is the equal to $1/2$ and we've already established that sets cannot contain duplicate elements.
One way to enforce this principle is to say that all fractions in the set must be simplified:
$ QQ = {a/b | a in ZZ, b in NN^+, "GCD"(a,b) = 1} $

*_Recall:_* $A=B$ means $A subset.eq B$ and $B subset.eq A$.

#example[
$ O = {2k + 1 | k in ZZ } $
$ A = {2l - 1 | l in ZZ } $


If you were try to write out this set, you would see that they are equivalent.
Thus, $A=O$. However, they are defined differently. How can we prove that these sets are equal?
To show that they are the same, you have to show one is included in the other and vice versa.
In other words, prove $A subset.eq O$ and $O subset.eq A$.
]

#proof[
$ A subset.eq O $
$ "Let" x = 2l -1 $
$ "Then" x = 2l - 1 -1 + 1 $
$ x = 2(l-1) + 1 $
$ "Let" k = l-1 $
$ "Then" x = 2k+1 $
$ "So" x in O $
]
