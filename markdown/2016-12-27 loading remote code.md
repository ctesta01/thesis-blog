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
```

After doing this, I can run `cm_curves = return_cm_curves(); E = EllipticCurve(cm_curves[0])` and now `E` is the elliptic curve $y^2 + y = x^3 - 2174420*x + 1234136692$ with complex multiplication.
