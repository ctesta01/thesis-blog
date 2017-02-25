# Elliptic Curves are Neat [🍵](https://ctesta01.github.io/thesis-blog/)

An Elliptic Curve is a projective degree three nonsingular curve,
and that means that all its points (except for the point at infinity $\mathcal O = (0 : 1 : 0)$) can be transformed to have coordinates in the affine plane $z=1$, i.e. every point is rewritten $(x:y:1)$.

This yields traditional pictures of elliptic curves, like the following one for curve 37a.

![A thick plot of 37a made in Sage](https://github.com/ctesta01/thesis-blog/blob/master/images/37a1.png?raw=true)

I think those are quite neat, but I much prefer considering the points which satisfy
the projective equation as a surface in $\mathbb R^3$. The blue strip denotes the affine part.

![A projective surface corresponding to curve 37a with a blue stripe to denote the affine part, view from above](https://github.com/ctesta01/thesis-blog/blob/master/images/37a1%20affine%20intersection%20from%20above.png?raw=true)

![Corresponding side view](https://github.com/ctesta01/thesis-blog/blob/master/images/37a1%20affine%20intersection%20from%20side.png?raw=true)

But Elliptic Curves are compact, and I want a representation that demonstates that, so I'm
interested in taking this surface in $\mathbb R^3$ and considering its intersection with the sphere
of radius 1/2 centered in at $(0,0,1/2)$.

![Intersection of the projective surface plot and the sphere described](https://github.com/ctesta01/thesis-blog/blob/master/images/37a1%20sphere%20intersection.png?raw=true)

Really, my motivation in doing this is to consider what happens to point distributions after
they undergo this kind of transformation.

37a a nice curve, because it is the first rank one curve when ordered by conductor. For reasons
not entirely clear to me, it is easier to compute with elliptic curves that have small conductors
[1](https://arxiv.org/abs/math/0403374).


### Spherically projecting the first $\pm 100$ multiples of $(1,0) \in E_{37a}$
Since it is rank one, we can let $P$ be its generator, and we can compute the multiples of $nP$ multiples
for $n \in [-100,100]$. Then we can take those points and project them onto the sphere of radius 1/2 centered
at $(0,0,1/2)$.

![Some rational points on 37a appear as 2 separate oval-esque shapes rotating in space around a sphere](https://github.com/ctesta01/thesis-blog/blob/master/images/37a1%20Spherical%20Points.gif?raw=true)

What I find fascinating is that it seems to me that the behavior of rational points is more uniform
on the spherical projection. This makes sense, because I was interested in a compact curve rather
than an unbounded one. To show you what I mean about points becoming more uniformly distributed,
take a look at some of the first multiples of the generator for `E = EllipticCurve('61a1')`

### The first $\pm 100$ multiples of the generator of $E_{61a1}$
I think it's really interesting how, for a lack of more technical terms, the points look like
ants on a log. Why should they tend to be this way? It's an interesting phenomena to me.

![100 Spherically Projected Generated Points on 61a1](https://github.com/ctesta01/thesis-blog/blob/master/images/61a1%20100%20spherical%20points.gif?raw=true)

![100 Generated Points on 61a1](https://github.com/ctesta01/thesis-blog/blob/master/images/61a1%20100%20generated%20points.png?raw=true)


### The first $\pm 160$ multiples of the generator of $E_{61a1}$
It seems like there's a value for which you go over the whole curve "once."
Maybe the points want to fill in the biggest gaps before moving on. Maybe they don't like sitting next
to each other. I'm not sure.

![160 Spherically Projected Points](https://github.com/ctesta01/thesis-blog/blob/master/images/61a1%20160%20Sphericals.gif?raw=true)

![160 Generated Points](https://github.com/ctesta01/thesis-blog/blob/master/images/61a1%20160%20Generated%20Points%20Affine.png?raw=true)


While I really enjoy these three dimensional plots, they are a little cumbersome to work with. A couple methods I've thought of for reducing the difficulty of investigation are different kinds of flattenings.

One idea is to take a larger sphere, the unit sphere centered at the origin, to only project onto the top of that, and then squash this upper hemisphere. This is equivalent to taking the projective Weierstrauss equation
and substituting $z = \sqrt{1 + x^2 + y^2}$ into it. (Note that we don't want to take the negative solution, since we only want to consider the upper hemisphere, since it is ) The result is this hairy mess:

$$y^2\sqrt{\left(1-x^2-y^2\right)}+a_1xy\sqrt{\left(1-x^2-y^2\right)}+a_3y\left(1-x^2-y^2\right)=x^3+a_2x^2\sqrt{\left(1-x^2-y^2\right)}+a_4x\left(1-x^2-y^2\right)+a_6\left(1-x^2-y^2\right)^{\left(\frac{3}{2}\right)}$$
