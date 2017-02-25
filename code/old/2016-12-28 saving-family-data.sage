# Christian Testa
# December 28 2016


# In this file I will generate curves in particular families and curves of many
# different ranks. The families that I will use will be taken from various
# research papers, and another set of curves that I will investigate will be
# sampled from the elliptic curve database in SageMath.

#  [ Infinite family of elliptic curves of rank at least 4 : Bartosz Naskr˛ecki ]( http://msp.org/involve/2010/3-3/involve-v3-n3-p06-s.pdf )
#  [ Elliptic Curves from Mordell to Diophantus and Back : Brown and Myers ]( https://www.math.vt.edu/people/brown/doc/dioellip.pdf )
#  [ Elliptic Curves of High Rank : Cecylia Bocovich ]( http://digitalcommons.macalester.edu/cgi/viewcontent.cgi?article=1025&context=mathcs_honors )
#  [ Twists of elliptic curves of rank at least four : Rubin and Silverberg ]( http://www.math.uci.edu/~asilverb/bibliography/rankfour.pdf )

# Additionally, I think it is a good idea to include some more basic elliptic
# curve families, and I will continue to use the Legendre, Hessian, Jacobi, and
# Tate families as basic elliptic curve families. (Not yet implemented)


        #### Load Sato Tate Convergence Plotting

# Download code from an online source and execute it.
def download_and_exec(download_path, http_source):
    from urllib2 import urlopen
    script = urlopen(http_source)
    script_data = script.read()

    script_file = open(download_path, 'w')
    script_file.write(script_data)
    script_file.close()

    execfile(download_path, globals())

# William Stein's Sato-Tate Convergence Plotting and my saving_ec_plots_and_data()
convergence_download_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'sato-tate-convergence.sage')
convergence_http_source = 'https://raw.githubusercontent.com/ctesta01/thesis-blog/master/code/sato-tate-convergence.sage'
download_and_exec(convergence_download_path, convergence_http_source)

# My desired output location
import os
sato_tate_dist_path = os.path.join(os.path.expanduser('~'), 'Desktop', 'sato-tate-distributions')

# For all families, I want to calculate anlists to 10^5
N = 10**5

        #### Legendre Curves

# The Legendre family are curves defined by

# $y^2 = x * (x-1) * (x-\lambda)$
# for some $\lambda$ not 1 or 0.

# They are curves which have necessarily four "2-division points", given by
# $e_0 = 0, e_1 = (0,0), e_2 = (1,0), e_3 = (\lambda, 0)$

# Page 86 in Dale Husemoller's Elliptic Curves:
# https://i.imgur.com/m8gumXm.png

legendre_path = os.path.join(sato_tate_dist_path, 'legendre')
os.mkdir(legendre_path)

# a method to pick a random legendre lambda that is not 0 or 1
def pick_random_legendre_lambda():
    # I may want to change the random_element parameters here
    legendre_lambda = QQ.random_element();
    while legendre_lambda in [0,1]:
        legendre_lambda = QQ.random_element();
    return legendre_lambda

# a method to generate an elliptic curve from a legendre lambda parameter
def curve_from_legendre_lambda(l):
    #     we could do it by the j-invariant, but I think that's unnecessarily complicated:
    # legendre_lambda_to_j_invariant = lambda l: 2^8 * (l^2 - l + 1)^3 / (l^2 * (l - 1)^2);
    # legendre_j = legendre_lambda_to_j_invariant(l)
    a2 = (x * (x-1) * (x-l)).expand().coefficient(x^2)
    a4 = (x * (x-1) * (x-l)).expand().coefficient(x)
    E = EllipticCurve(QQ, [0, a2, 0, a4, 0])
    return E

# generate a set of 50 unique curves
legendre_lambdas = []
legendre_curves = []
for i in range(0, 50):
    l = pick_random_legendre_lambda()
    # pick a different lambda if it's already been used
    while l in legendre_lambdas:
        l = pick_random_legendre_lambda()
    legendre_lambdas.append(l)
    legendre_curves.append(curve_from_legendre_lambda(l))

# save sato-tate, akiyama-tanigawa, qq-plots, curve, and data for legendre curves
saving_ec_plots_and_data(legendre_curves, legendre_path, an_limit=N)


        #### Naskrecki's Rank ≥ 4 Family

# Main Theorem from http://msp.org/involve/2010/3-3/involve-v3-n3-p06-s.pdf:
# For all but finitely many values of u, the curve given by
# $y^2 - t(u) xy = x^3 - t(u) x^2 - t(u) x + 1$
# has four independent points, where
# $t(u) = 1 - u/2 + u^2/2$

# Generate a list of unique $t$ values:
naskrecki_ts = []
naskrecki_curves = []
naskrecki_t_fn = lambda u: 1 - u / 2 + u**2 / 2
for i in range(0,50):
    naskrecki_u = QQ.random_element()
    naskrecki_t = naskrecki_t_fn(naskrecki_u)
    while naskrecki_t in naskrecki_ts:
        naskrecki_u = QQ.random_element()
        naskrecki_t = naskrecki_t_fn(naskrecki_u)
    naskrecki_ts.append(naskrecki_t)
    naskrecki_curves.append(EllipticCurve(QQ, [-naskrecki_t, -naskrecki_t, 0, -naskrecki_t, 1]))

# make output folder
naskrecki_path = os.path.join(sato_tate_dist_path, 'naskrecki')
os.mkdir(naskrecki_path)

# make output
saving_ec_plots_and_data(naskrecki_curves, naskrecki_path, time_limit=15, an_limit=N)


        #### Brown and Meyers

# Theorem 1 from https://www.math.vt.edu/people/brown/doc/dioellip.pdf
# The curve $y^2 = x^3 - x + m^2$
# for $m ≥ 1$ has trivial torsion,
# for $m ≥ 2$ has rank ≥ 2,
# and there are infinitely many m for which it has rank ≥ 3

# generate a list of unique curves
brown_and_meyer_curves = []
brown_and_meyer_ms = []
for i in range(0,21):
    bm_m = ZZ.random_element()
    bm_m = bm_m**2
    while bm_m <= 1 or bm_m in brown_and_meyer_ms:
        bm_m = ZZ.random_element()
        bm_m = bm_m**2
    brown_and_meyer_ms.append(bm_m)
    brown_and_meyer_curves.append(EllipticCurve([0, 0, 0, -1, bm_m]))

# make output folder
brown_and_meyer_path = os.path.join(sato_tate_dist_path, 'brown-and-meyer')
os.mkdir(brown_and_meyer_path)

# make output
saving_ec_plots_and_data(brown_and_meyer_curves, brown_and_meyer_path, time_limit=15, an_limit=N)

# mentioned at the end of the paper is the following curve:
# y^2 = x^3 − m^2x + 1
# I will generate data for it as well.

# generate a list of unique curves
brown_and_meyer_curves = []
brown_and_meyer_ms = []
for i in range(0,21):
    bm_m = ZZ.random_element()
    bm_m = bm_m**2
    while bm_m <= 1 or bm_m in brown_and_meyer_ms:
        bm_m = ZZ.random_element()
        bm_m = bm_m**2
    brown_and_meyer_ms.append(bm_m)
    brown_and_meyer_curves.append(EllipticCurve(QQ, [0, 0, 0, -bm_m, 1]))

# make output folder
brown_and_meyer_path2 = os.path.join(sato_tate_dist_path, 'brown-and-meyer2')
os.mkdir(brown_and_meyer_path2)

# make output
saving_ec_plots_and_data(brown_and_meyer_curves, brown_and_meyer_path2, time_limit=15, an_limit=N)




        #### Bocovich
# http://digitalcommons.macalester.edu/cgi/viewcontent.cgi?article=1025&context=mathcs_honors
# This paper provides lower bounds on the rank of the following curve:

# Km : y^2 = x^3 + m^3x − m^3
# generate a list of unique curves
bocovich_curves = []
bocovich_ms = []
for i in range(0,21):
    bocovich_m = ZZ.random_element()
    bocovich_m = bocovich_m**2
    while bocovich_m <= 1 or bocovich_m in bocovich_ms:
        bocovich_m = ZZ.random_element()
        bocovich_m = bocovich_m**2
    bocovich_ms.append(bocovich_m)
    bocovich_curves.append(EllipticCurve(QQ, [0, 0, 0, -bocovich_m, 1]))

# make output folder
bocovich_path = os.path.join(sato_tate_dist_path, 'bocovich')
os.mkdir(bocovich_path)

# make output
saving_ec_plots_and_data(bocovich_curves, bocovich_path, time_limit=15, an_limit=N)



        #### Rubin and Silverberg

# http://www.math.uci.edu/~asilverb/bibliography/rankfour.pdf
# Theorem 3.2
# Suppose $a \in \mathbb Q - \{ 0, 1, -1 \}$
# Let $\nu = a^2$
# Let $$f_\nu (x) = x (x-1) (x - \frac{1-\nu}{\nu+2})$$
# $E_\nu : y^2 = f_\nu(x)$ is a curve with:
# rank ≥ 4 for infinitely many quadratic Twists

# note to self: I'm not sure if the quadratic twists in Thm 3.2.iii must
# be from t_\nu or not

# we will use the same function as with the Legendre family
# a method to generate an elliptic curve from a legendre lambda parameter

# def curve_from_legendre_lambda(l):
    #     we could do it by the j-invariant, but I think that's unnecessarily complicated:
    # legendre_lambda_to_j_invariant = lambda l: 2^8 * (l^2 - l + 1)^3 / (l^2 * (l - 1)^2);
    # legendre_j = legendre_lambda_to_j_invariant(l)
#     a2 = (x * (x-1) * (x-l)).expand().coefficient(x^2)
#     a4 = (x * (x-1) * (x-l)).expand().coefficient(x)
#     E = EllipticCurve(QQ, [0, a2, 0, a4, 0])
#     return E

# generate a list of unique as to use
# rubin_silverberg_as = []
# rubin_silverberg_curves = []
# for i in range(1,21):
#     rubin_silverberg_a = QQ.random_element()
#     while rubin_silverberg_a in [0, -1, 1] or rubin_silverberg_a in rubin_silverberg_as:
#         rubin_silverberg_a = QQ.random_element()
#     rubin_silverberg_as.append(rubin_silverberg_a)
#     rubin_silverberg_lambda = (1 - rubin_silverberg_a**2)/(rubin_silverberg_a**2 + 2)
#     rubin_silverberg_curves.append(curve_from_legendre_lambda(rubin_silverberg_lambda))

# Hmm. I think I need to twist these to get a useful curve.

        #### Elliptic Curve Database
# make a list of curves with increasing rank
sage_curves = []
for i in range(0, 28):
    # this returns at maximum 10 curves
    E_list = elliptic_curves.rank(i)
    for j in range(0,len(E_list)):
        sage_curves.append(E_list[j])

sage_database_rank_range_path = os.path.join(sato_tate_dist_path, 'sage_db_rank_range')
os.mkdir(sage_database_rank_range_path)

# make output
saving_ec_plots_and_data(sage_curves, sage_database_rank_range_path, time_limit=15, an_limit=N)
