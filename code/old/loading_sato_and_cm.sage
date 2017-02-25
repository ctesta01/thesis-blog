# Download code from an online source and execute it. 
    # BE WARY. This is very insecure. 
    # I am using it with code from my own GitHub account over HTTPS, 
    # and I do NOT recommend that anybody else uses this. 

def download_and_exec(download_path, http_source):
    from urllib2 import urlopen
    script = urlopen(http_source)
    script_data = script.read()
    
    script_file = open(download_path, 'w')
    script_file.write(script_data)
    script_file.close()
    
    execfile(download_path, globals())
    
    
    
# William Stein's plotting functions:
#     http://wstein.org/mazur/sato.tate.figures/
#     http://wstein.org/talks/20071016-convergence/
    
convergence_download_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'sato-tate-convergence.sage')
convergence_http_source = 'https://raw.githubusercontent.com/ctesta01/thesis-blog/master/code/sato-tate-convergence.sage'

download_and_exec(convergence_download_path, convergence_http_source)



# Complex Multiplication Curves from LMFDB
#    You may perform the same search here, and download the data.
#    My data was downloaded December 25 2016
#    http://lmfdb.warwick.ac.uk/EllipticCurve/Q/?include_cm=only

cm_curves_download_path = os.path.join(os.path.expanduser('~'), 'Downloads', 'cm-curves.sage')
cm_curves_http_source = 'https://raw.githubusercontent.com/ctesta01/thesis-blog/master/code/cm-curves.sage'
download_and_exec(cm_curves_download_path, cm_curves_http_source)
