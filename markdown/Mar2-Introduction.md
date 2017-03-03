# Elliptic Curves are Neat [🍵](https://ctesta01.github.io/thesis-blog/)

## Definining an Elliptic Curve

Elliptic curves are degree three nonsingular plane curves with at least one rational point.

They often look something like this:

<center>
<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/496a1.png?raw=true" alt="" width="304" height="228">
  <figcaption> $ y^2 = x^3 + x + 1 $ </figcaption>
</figure>

<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/92b1.png?raw=true" alt="" width="304" height="228">
  <figcaption>$ y^2 = x^3 - x + 1 $ </figcaption>
</figure>

<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/32a2.png?raw=true" alt="" width="304" height="228">
  <figcaption>$ y^2 = x^3 - x $ </figcaption>
</figure>
</center>

These are just three examples, and it will be useful to think of elliptic curves abstractly as those cubics which are nonsingular with at least one point. To require that they are nonsingular is equivalent to requiring that no point is singular, that is there is no $P \in E$ such that all
derivatives vanish. That means that an elliptic curve could never look like the following:

<center>
<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/acnode.png?raw=true" alt="" width="304" height="228">
  <figcaption>$ y^2 = x^3 - x^2 $ </figcaption>
</figure>

<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/singular-cusp.png?raw=true" alt="" width="304" height="228">
  <figcaption>$ y^2 = x^3 $ </figcaption>
</figure>



<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/singular-node.png?raw=true" alt="" width="304" height="228">
  <figcaption>$ y^2 = x^3 + x^2 $ </figcaption>
</figure>

<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/tacnode.png?raw=true" alt="" width="304" height="228">
  <figcaption>$ (x^2 + y^2 - 3x)^2 = 4x^2(2-x) $ </figcaption>
</figure>
</center>

In fact, the last was never in the running, since it isn't even a cubic equation.

There are many different ways of considering an elliptic curve. Most often they are depicted in the affine or cartesian plane, but they also exist in projective space. To construct the projective plane, we identify the lines through the origin in 3-dimensional affine or Euclidean space ($\mathbb A^2$) as the points of projective 2-dimensional space $\mathbb P^2$.

We denote the points of the projective plane as $(x:y:z)$ since it is only the ratio between these points which identifies the point. If we consider a
cubic nonsingular curve, we immediately find that it must be homogenous
in its terms in order to be well-defined as a polynomial of variables
in $\mathbb P^2$. We will denote these variables by capital $X, Y$ and $Z$.

It is important to distinguish between the projective plane and the affine plane, but there's nothing stopping us from visualizing what the rays satisfying an elliptic curve might look like in 3-dimensional space. This forms a surface in $\mathbb R^3$.

<center>
<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/37a1%20affine%20intersection%20from%20side.png?raw=true" alt="" width="304" height="228">
  <figcaption>Projective with Affine Highlighted $ Y^2Z = X^3 - X^2 $ </figcaption>
</figure>

<figure>
  <img src="https://github.com/ctesta01/thesis-blog/blob/master/images/37a1.png?raw=true" alt="" width="304" height="228">
  <figcaption> Affine Curve $ y^2 + y = x^3 - x $ </figcaption>
</figure>
</center>

## So What Are They Good For?

Elliptic Curves are of significance primarily to number theorists, and have had a major impact on problems like fast integer factorization and Fermat's Last Theorem. Elliptic curve cryptography has been one of the most popular public key cryptography systems from 2004 to now (2017), and was originally suggested in the 1980s. Further, understanding their rational points is of such significance that for proving the Birch-Swinnerton-Dyer conjecture which relates the analytic rank to the algebraic rank one can win \$$10^6$.

- [Lenstra's Elliptic Curve Factorization Algorithm](https://en.wikipedia.org/wiki/Lenstra_elliptic_curve_factorization)
- [Elliptic Curve Cryptography](https://en.wikipedia.org/wiki/Elliptic_curve_cryptography)
- [The Modularity Theorem](https://en.wikipedia.org/wiki/Modularity_theorem)
- [The Birch and Swinnerton-Dyer Conjecture](https://en.wikipedia.org/wiki/Birch_and_Swinnerton-Dyer_conjecture)

## Where To From Here?

At the Second International Congress in 1900 the incredible mathematician [David Hilbert](https://en.wikipedia.org/wiki/David_Hilbert) presented 10 of [23 problems](http://mathworld.wolfram.com/HilbertsProblems.html) that were then unsolved. The tenth of these was to find
a general algorithm deciding the solvability of an arbitrary Diophantine equation. [Matiyasevich's Theorem] from 1970 yielded the discovery that no such algorithm can exist. This certainly makes finding and describing the complete solution set of a Diophantine problem more difficult. Progress in Algebraic-Geometry and the proof of Fermat's Last Theorem make Diophantine Equations an exciting subject, and the rational points on elliptic curves
are one of many mysterious behaviors to explore. 
