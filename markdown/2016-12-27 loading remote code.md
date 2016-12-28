#### execfile() is DANGEROUS!

Well, that's what I tell myself, and then I go ahead and use it anyway.

Since the export that I have from [LMFDB](lmfdb.warwick.ac.uk) of elliptic curves
with complex multiplication is ~5000 lines, I thought it would be better if I could
load it from an external script. Further, I thought it would be nice if that script was
kept on GitHub so that I could load it regardless of the device I was on and so
that others could run my code as well. William Stein has some codes for plotting
data related to Sato-Tate distributions and the Akiyama-Tanigawa conjecture
in a few different places, from which I've grabbed a couple different functions and
done something similar with:
- [Convergence Talk](http://wstein.org/talks/20071016-convergence/)
- [Code for Mazur's Finding Meaning in Error Terms](http://wstein.org/mazur/sato.tate.figures/)


This is the method I've written for loading data from remotely. It's quite naive, it simply downloads the code and executes it, storing the results in the global scope. (Note: it doesn't seem to like loading objects, only methods)
```python
def download_and_exec(download_path, http_source):
    from urllib2 import urlopen
    script = urlopen(http_source)
    script_data = script.read()

    script_file = open(download_path, 'w')
    script_file.write(script_data)
    script_file.close()

    execfile(download_path, globals())
```

And then to load some data I do something like this:
```python
cm_curves_download_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'cm-curves.sage')
cm_curves_http_source = 'https://raw.githubusercontent.com/ctesta01/thesis-blog/master/code/cm-curves.sage'
download_and_exec(cm_curves_download_path, cm_curves_http_source)
# Loading return_cm_curves()
# retrieve CM curves by running
# cm_curves = return_cm_curves()

cm_curves = return_cm_curves()
E = EllipticCurve(cm_curves[0])
```

Now `E` the elliptic curve $y^2 + y = x^3 - 2174420*x + 1234136692$ with complex multiplication, and `cm_curves` is the `ainvs` (a invariants) list of a bunch of CM curves.

This is a nice way of carrying around a list of 5128 lines of coefficients for curves with complex multiplication,
but really what I'm interested in this for is storing functions. I suppose I could be building actual
python modules, but I know nothing about that so far, and this is effective enough to make me happy.

The last thing I've done today is wrapping up some work I've been doing on making data
on families of elliptic curves into a function. This is contained in my `code/sato-tate-convergence.sage`
file, and I want to make it clear that the vast majority of the work done in that file
(as with everything in sage) was done by William Stein. The function `saving_ec_plots_and_data()` allows
me to save for a list of elliptic curves a whole bunch of data at once, and I intend to use it
to study families of large rank.

Thanks for reading ☕️
