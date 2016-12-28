# The following code (~233 lines) is copied with minor changes from William Stein's code here:

#       - http://wstein.org/mazur/sato.tate.figures/
#       - http://wstein.org/talks/20071016-convergence/

print 'Loading method dist \n\t creates a list of bins and sorts data for a histogram'
def dist(v, b, left=-1.0, right=1.0):
    """
    We divide the interval between left (default: 0) and 
    right (default: pi) up into b bins.
   
    For each number in v (which must left and right), 
    we find which bin it lies in and add this to a counter.
    This function then returns the bins and the number of
    elements of v that lie in each one. 

    ALGORITHM: To find the index of the bin that a given 
    number x lies in, we multiply x by b/length and take the 
    floor. 
    """
    length = right - left
    normalize = float(b/length)
    vals = {}
    d = dict([(i,0) for i in range(b)])
    for x in v:
        n = int(normalize*(float(x)-left))
        d[n] += 1
    return d, len(v)

from math import asin, log, sqrt

def redline(xmin,xmax):
    return line([(xmin,0.5),(xmax,0.5)], rgbcolor=(1,0,0))

def Xab(a,b):
    bb = (asin(b)/2 + b*sqrt(1-b**2)/2)
    aa = (asin(a)/2 + a*sqrt(1-a**2)/2)
    def X(T):
        return (asin(T)/2 + T*sqrt(1-T**2)/2 - aa)/(bb - aa)
    return X

import bisect

print 'Loading class SatoTate \n\t stores methods and information about Sato Tate distributions for an elliptic curve'
class SatoTate:
    def __init__(self, E, n):
        self._E = E    
        self._n = n
        self.init_aplist(n)

    def init_aplist(self, n):
        t = cputime()
        v = self._E.aplist(n)
        print 'computed aplist ', cputime(t)
        P = prime_range(n)
        self._aplist = v
        two = float(2)
        t = cputime()
        self._normalized_aplist = [float(v[i])/(two*math.sqrt(P[i])) for i in range(len(v))]
        print 'time to normalize ', cputime(t)

    def __repr__(self): 
        return "Sato-Tate data for %s using primes up to %s"%(self._E, self._n)
 
    def normalized_aplist(self, n):  # returns a copy
        k = prime_pi(n)
        v = self._normalized_aplist
        if k > len(v):
             raise ValueError, "call init_aplist"
        return v[:prime_pi(n)]

    def sorted_aplist(self, n):
        v = self.normalized_aplist(n)
        v.sort()
        return v

    def YCab(self, Cmax, a=-1, b=1):
        v = self.sorted_aplist(Cmax)
    
        denom = bisect.bisect_right(v, float(b)) - bisect.bisect_left(v, float(a))
        try:
           normalize = float(1)/denom
        except:
           def Y(T):
               return 1.0
           return Y
        start_pos = bisect.bisect_left(v, float(a))

        def Y(T):
            # find position that T would go in if it were inserted
            # in the sorted list v.
            n = bisect.bisect_right(v, float(T)) - start_pos
            return n * normalize
        return Y


    def xyplot(self, C, a=-1, b=1):
        """
        Return the quantile-quantile plot for given a,b, up to C.
        """
        Y = self.YCab(C,a=a,b=b)
        X = Xab(a=a,b=b)
        pX = plot(X, a, b, rgbcolor=(1,0,0))
        pY = plot(Y, a, b, rgbcolor=(0,0,1))
        return pX + pY

    def qqplot(self, C, a=-1, b=1):
        """
        Return the quantile-quantile plot for given a,b, up to C.
        """
        Y = self.YCab(C,a=a,b=b)
        X = Xab(a=a,b=b)
        pl = parametric_plot((X, Y), a,b)
        ll = line([(0,0), (1.1,1.1)], rgbcolor=(1,0,0))
        return pl+ll
 
    def Delta(self, C, a, b, max_points=300, L_norm=2):
        """
        Delta_{a}^{b} function:

        INPUT: C - cutoff
             a,b - evaluate over the interval (a,b)
             max_points - number of points used in numerical integral         
             L_norm --the integer n=2 or n=oo. 
                      Compute the L_n norm.   For n finite this
                      is the integral of the difference to the power n.
                      For n = +oo, this is the L_oo norm, which is the max
                      of the absolute value of the difference (where the max
                      is evaluated at max_points equidistributed points).
        """
        key = (C,a,b,max_points, L_norm)
        try:
           return self._delta[key]
        except AttributeError:
           self._delta = {}
        except KeyError:
           pass
        X = Xab(a,b)
        Y = self.YCab(C,a,b)     # This takes all the time.

        if L_norm == oo:
            val = max([abs(X(T)-Y(T)) for T in srange(a,b,float(b-a)/max_points)])
            err = 0
        else:
            n = int(L_norm)   # usually n = 2.
            def h(T):
                return (X(T) - Y(T))**n
            val, err = integral_numerical(h, a, b, max_points=max_points, 
              algorithm='qag', rule=1,eps_abs=1e-10, eps_rel=1e-10)
            val = float(val**(1.0/n)) # compute L_n norm.
            err = float(err**(1.0/n))
    
        self._delta[key] = (val, err)
        return val, err

    def theta(self, C, a=-1, b=1, max_points=300, L_norm=2):
        val, err = self.Delta(C, a, b, max_points=max_points, L_norm=L_norm)
        return -log(val)/log(C), val, err

    def theta_interval(self, C, a=-1, b=1, max_points=300, L_norm=2):
        val, err = self.Delta(C, a, b, max_points=max_points, L_norm=L_norm)
        return -log(val-abs(err))/log(C), -log(val+abs(err))/log(C)

    def compute_theta(self, Cmax, plot_points=30, a=-1, b=1, 
                 max_points=300, L_norm=2, verbose=False):
        a,b = (float(a), float(b))
        def f(C):
           z = self.theta(C, a, b, max_points=max_points, L_norm=L_norm)
           if verbose: print C, z
           return z[0]
        return [(x,f(x)) for x in range(100, Cmax, int(Cmax/plot_points))]

    def compute_theta_interval(self, Cmax, plot_points=30, a=-1, b=1, 
                max_points=300, L_norm=2, verbose=False):
        a,b = (float(a), float(b))
        vmin = []; vmax = []
        for C in range(100, Cmax, int(Cmax/plot_points)):
            zmin,zmax = self.theta_interval(C, a, b, max_points=max_points, L_norm=L_norm)
            vmin.append((C, zmin))
            vmax.append((C, zmax))
            if verbose: print C, zmin, zmax
        return vmin, vmax

    def plot_theta_interval(self, Cmax, clr=(0,0,0), *args, **kwds):
        vmin, vmax = self.compute_theta_interval(Cmax, *args, **kwds)
        v = self.compute_theta(Cmax, *args, **kwds)
        grey = (0.7,0.7,0.7)
        return line(vmin,rgbcolor=grey)+line(vmax,rgbcolor=grey) + \
                point(v,rgbcolor=clr) + line(v,rgbcolor=clr) + redline(0, Cmax)

    def histogram(self, Cmax, num_bins):
        v = self.normalized_aplist(Cmax)
        d, total_number_of_points = dist(v, num_bins)
        return frequency_histogram(d, num_bins, total_number_of_points) + semicircle

    def x_times_Delta(self, x):
        return x*self.Delta(x, -1,1, max_points=500)[0]

print 'Loading method showtheta \n\t plotting the Akiyama-Tanigawa conjecture data constructed in the SatoTate class'
def showtheta(P):
    P.show(xmin=0, ymin=0, ymax=0.6, figsize=[9,4])

print 'Loading method graph \n\t creating a histogram graphic out of the output of graph'
def graph(d, b, num=5000, left=float(0), right=float(pi)):
    s = Graphics()
    left = float(left); right = float(right)
    length = right - left
    w = length/b
    k = 0
    for i, n in d.iteritems():
        k += n
        # ith bin has n objects in it. 
        s += polygon([(w*i+left,0), (w*(i+1)+left,0), 
                     (w*(i+1)+left, n/(num*w)), (w*i+left, n/(num*w))],
                     rgbcolor=(0,0,0.5))
    return s

print 'Loading function sato_tate_noacos \n\t creating a normalized aplist'
def sato_tate_noacos(E, N):
    return [E.ap(p)/(2*math.sqrt(p)) for p in prime_range(N+1) if N%p != 0]

print 'Loading function graph_ellcurve_noacos \n\t histogramming an aplist'
def graph_ellcurve_noacos(E, b=10, num=5000):
    v = sato_tate_noacos(E, num)
    d, total_number_of_points = dist(v,b,-1,1)
    return graph(d, b, total_number_of_points,-1,1)

print 'Loading function f(x) = 2/pi * sqrt(1-x^2)), the Sato Tate semi-circle'
def f(x):
    if abs(x) == 1 or x < -1:
        return 0
    return (2/math.pi) * sqrt(1-x**2)

print 'Loading function sin2acos, which graphs f(x)'
def sin2acos():
    PI = float(pi)
    return plot(f, -1.01,1, plot_points=200, \
              rgbcolor=(1,0,0), thickness=4,alpha=0.7)


