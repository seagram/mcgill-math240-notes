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

We have learned from Calculus that objects pertain to continuous functions and continuous domains whose outputs are real numbers.
These can be translated to various physical phenomenons such as temperature or speed.
In Discrete Mathematics, the objects in question are ones separated in space.
They may or may not be linked together. Take for example, the graph.
The objects within Discrete Mathematics are composed of a finite definition and nature.
Think then of how any computer you may encounter leverages finite memory and thus, it can be considered discrete.
Therefore, we can think of Discrete Mathematics as "the math of computers".
This is not the only definition as Discrete Mathematics is not merely _this_.
But within its varied applications, it can be thought of in this way.
Not far divergent from computers, Discrete Mathematics finds itself in relation to programming, particularly, in graph algorithms and their applications.
In this class, however, we are solely concerned about the theory behind these concepts.
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

  *_Note:_* the previous statement reads naturally as "$"If" A subset.eq B "then" x in A "implies" x in B$"
]

With this, we can establish that $X subset.eq X$.
That is, for any set $A$, $A$ is a _subset_ of its self.
This applies to the empty set as well: $emptyset subset.eq emptyset$.


=== Equality
#definition[
  For any two sets, $A, B$, we say $A$ and $B$ are _equal_ to each other if and only if $A$ is a subset of $B$ and $B$ is a subset of $A$.
  The order of the elements in either set are ignored.
  Additionally, repetitions of the same element are ignored.
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
This is, however, not always the preferred method of expression.
#example[
  Consider the set of rational numbers: $QQ$.
  $ QQ = {..., 1/2, 0, (-2)/5, ...} $
]
There lacks any resemblance of order or pattern to this representation of the set.
A better definition could simply be "the fractions".
This is an example of a _definition by comprehension_:
collecting all elements from a given set which satisfy a common property.
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
  *_Note:_* We restrict $b$ to exist in the set $NN^+$ which includes all natural numbers except for 0 since no element within the rational set contains a denominator of 0.
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

#lecture[September 3rd, 2026]
== Sets
Recall that we previously defined a _set_ as a collection of objects.
This calls into question: what is an object? What are the restraints as for what entities are allowed to be included inside a set?
Answer: Objects must all have the same "context" or the same "universe".
=== Russell's Paradox
Define the following:
$ R = {x | x "is a set and" x in.not x} $
This $R$ is called _Russell's Set_, discovered by Bertrand Russell in 1901.
It defines as the set of all sets that do not contain themselves as members.
This definition carries it's own contradiction which leads it to be called Russell's Paradox.
For a given Russell's Set $R$, if $R$ is not a member of itself ($R in.not R$), it qualifies as a set that does not contain itself which means
it must be a member of R ($R in R$). But if $R$ is a member of itself ($R in R$), it violates the definition of $R$ since
$R$ only contains sets that do not contain themselves which means it cannot be a member of $R$ ($R in.not R$).
#example[
$ emptyset in.not emptyset therefore emptyset in R $
]
#example[
$ NN in.not NN therefore NN in R $
]
#example[
$ "Let" A = { "Abstract ideas" } $
$ A in A => A in.not R $
]
#example[
  Quine's Set
$ Q = {Q} $
$ Q in Q => Q in.not R $
*_Note_*: $Q = {Q} "is equivalent to" Q = {{Q}} "and" Q = {{{Q}}} "and so forth."$
#v(0.15cm)
*_Question:_* Does $R in R$?
$ R in R <=> R in.not R "(given the definition of R)" $
This is a contradiction and thus a paradox. This is what prevents us from establishing a "set containing all sets".

*_Solution_*:
Comprehension should only be used from a known/accepted set (universe) $U$.
*_Question:_* what is the requirements to define a universe? What properties must it follow?
]

== Set Operations
Specifically, those that occur within a given universe $U$.
=== Union
$ A union B = { x in U | x in A "or" x in B "or both" } $
#example-plain[
  #math-venn[
    $ A = {1,3,5} $
    $ B = {1,2,3} $
    $ A union B = {1,3,5, 2} $
  ][
    #venn2-fig(a-fill: gray, b-fill: gray, ab-fill: gray)
  ]
]

=== Intersection
$ A inter B = { x in U | x in A "and" x in B } $
#example-plain[
  #math-venn[
    $ A = {1,3,5} $
    $ B = {1,2,3} $
    $ A inter B = {1,3} $
  ][
    #venn2-fig(ab-fill: gray)
  ]
]

=== Set Difference
$ A without B = {x in U | x in A "but" x in.not B} $
#example-plain[
  #math-venn[
    $ A = {1,3,5} $
    $ B = {1,2,3} $
    $ A without B = {5} $
    $ B without A = {2} $
  ][
    #grid(
      columns: 2,
      column-gutter: 2em,
      align: center,
      [$A without B$ \ #venn2-fig(a-fill: gray, length: 0.7cm)],
      [$B without A$ \ #venn2-fig(b-fill: gray, length: 0.7cm)],
    )
  ]
]
=== Complementation
$ overline(A) = {x in U | x in.not A} $

#example-plain[
  #math-venn[
    $ A = {1,3,5} $
    $ overline(A) = {0,2,4,6,7,8,...} "given" U = NN $
    $ overline(A) = {(-infinity, 1) union (1,3) union (3,5) union (5, infinity)} \
    "given" U = RR $
  ][
    #align(center, cetz.canvas({
      import cetz.draw: *
      cetz-venn.venn2(
        name: "venn",
        fill: bg,
        stroke: fg,
        b-fill: gray,
        not-ab-fill: gray,
      )
      content("venn.a", [$A$])
      content("venn.b", [$B$])
      content("venn.not-ab", [$U$])
      content((rel: (0.6, 1.6), to: "venn.not-ab"), [$overline(A)$])
    }))
  ]
]

=== Symmetric Difference
$ A triangle B = { x in U | x in A "or" x in B "but not both"} $
// Add proper math symbols for above. Do same for others with words in them
#example-plain[
  #math-venn[
    $ A = {1,3,5} $
    $ B = {1,2,3} $
    $ A triangle B = {5, 2} $
  ][
    #venn2-fig(a-fill: gray, b-fill: gray)
  ]
]
*_Note_*: This is the same as:
$ A triangle B = (A union B) without (A inter B) $
This is also the same as:
$ A triangle B = (A without B) union (B without A) $
Naturally, we can read this as the union without the intersection.

=== Venn Diagrams
All of the properties we have just looked at are what's called _set identities_. equalities that are true of all sets.

#theorem[
If two set expressions ($X$ and $Y$), shade the same Venn diagram, then $X = Y$ is a set identity.
]

#proof[
$X = Y$ means $X subset.eq Y$ and $Y subset.eq X$. First, we establish $X subset.eq Y$.

Let $x in X$. Our goal is to prove then $x in Y$. 

Let $x in X$. Then $x$ is in the region of the Venn diagram shaded by $X$.
Which is the same as the region shaded by $Y$. $square$

For $Y subset.eq X$, we use a similar proof. $square$
]

#example[
Use Venn diagrams to prove the _distributive law_:
$ A union (B inter C) = (A union B) inter (A union C) $

*_Note_*: Notice how this expression is not too different to those of numbers.
$ a dot (b+c) = (a dot b) + (a dot c) $

*_Strategy_*: Draw both Venn diagrams and observe that they are equivalent.
#v(0.25cm)
#align(center, grid(
  columns: (auto, auto),
  column-gutter: 2em,
  align: center,
  [
    $ A union (B inter C) $
    #venn3-fig(
      a-fill: gray,
      ab-fill: gray,
      ac-fill: gray,
      abc-fill: gray,
      bc-fill: gray,
      length: 0.7cm,
    )
  ],
  [
    $ (A union B) inter (A union C) $
    #venn3-fig(
      a-fill: gray,
      ab-fill: gray,
      ac-fill: gray,
      abc-fill: gray,
      bc-fill: gray,
      length: 0.7cm,
    )
  ],
))
#v(0.25cm)
It is recommended exercise to prove the following identities with Venn diagrams in a similar fashion:
$ A union (B inter C) = (A union B) inter (A union C) $
$ A inter (B union C) = (A inter B) union A (inter C) $
*_Note_*: These identities are in fact different to that of real numbers.
$ a + (b dot c) eq.not (...) $
]

== Additional Set Identities

=== Identity Laws
$ A inter U = A $ // add venn diagram
$ A union emptyset = A $ // add venn diagram

=== Idempotent Laws
$ A union A = A $
$ A inter A = A $

=== Double Complement Law
$ overline(overline(A)) = A $

=== Commutative Laws
$ A union B = B union A $
$ A inter B = B inter A $

=== Associative Laws
$ A union (B union C) = (A union B) union C = A union B union C $
$ A inter (B inter C) = (A inter B) union C = A inter B inter C $

=== De Morgan's Laws
$ overline(A union B) = overline(A) inter overline(B) $
$ overline(A inter B) = overline(A) union overline(B) $

=== Complement Laws
$ A inter overline(A) = emptyset $ // show venn
$ A union overline(A) = U $ // show venn

=== Absorption Laws
$ A union (A inter B) = A $ // show venn
$ A inter (A union B) = A $

=== Domination Laws
$ A inter emptyset = emptyset $
$ A union U = U $

#example[
Use the set identities to show that:
$ overline(A union (B inter C)) = (overline(C) union overline(B)) inter overline(A) $
*_Solution_*:
$ overline(A union (B inter C)) = overline(A) inter overline((B inter C)) "(De Morgan)" $
$ = overline(A) inter (overline(B) union overline(C)) "(De Morgan)" $
$ = (overline(B) union overline(C)) inter overline(A) "(Commutative)" $
$ = (overline(C) union overline(B)) inter overline(A) "(Commutative)" $
]

== External Operations
We define _external operations_ as operations which _change the universe_.
=== Cartesian Product
$ A times B = {(a,b) | a in A, b in B } $
#example-plain[
$ RR^2 = RR times RR = {(x,y) | x,y in RR} $
]
#example-plain[
$ A = {1,3,5} $
$ B = {6,7} $
$ A times B = {(1,6), (1,7), (2,6), (2,7), (3,6), (3,7), (5,6), (5,7)} $
]
=== Powersets
Given a set $A$, we define the _powerset_ of $A$ as the set $P(A) = {x | x subset.eq A}$.
We'd say this naturally as "the set of all subsets of $A$".
#example-plain[
$ A = {1,2,3} $
$ P(A) = {emptyset, {1}, {2}, {3}, {1,2}, {1,3}, {2,3}, {1,2,3} } $
$ P(emptyset) = {emptyset} eq.not emptyset $
]
