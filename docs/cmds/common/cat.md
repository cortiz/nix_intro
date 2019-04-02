Title:   Cat 
Summary:  concatenate files and print on the standard output
Authors: Carlos Ortiz
Date:    March 29, 2019

# cat

Concatenate files and print on the standard output

## Examples

```bash 
~/d/r/m/nix_intro> cat .gitignore
.venv/
site/
```

Add line numbers to the output 

``` bash
~/d/r/m/nix_intro> cat -n requirements.txt
     1  Click==7.0
     2  Jinja2==2.10
     3  livereload==2.6.0
     4  Markdown==3.1
     5  MarkupSafe==1.1.1
     6  mkdocs==1.0.4
     7  mkdocs-bootstrap386==0.0.1
     8  mkdocs-material==4.1.1
     9  mkdocs-rtd-dropdown==1.0.2
    10  Pygments==2.3.1
    11  pymdown-extensions==6.0
    12  PyYAML==5.1
    13  six==1.12.0
    14  tornado==6.0.2

```

Concatenate multiple files with line numbers

```bash 
 ~/d/r/m/nix_intro> cat -n .gitignore requirements.txt
     1  .venv/
     2  site/
     3  Click==7.0
     4  Jinja2==2.10
     5  livereload==2.6.0
     6  Markdown==3.1
     7  MarkupSafe==1.1.1
     8  mkdocs==1.0.4
     9  mkdocs-bootstrap386==0.0.1
    10  mkdocs-material==4.1.1
    11  mkdocs-rtd-dropdown==1.0.2
    12  Pygments==2.3.1
    13  pymdown-extensions==6.0
    14  PyYAML==5.1
    15  six==1.12.0
    16  tornado==6.0.2
```

Concatenate multiple files and send the output to a file.

```bash
 ~/d/r/m/nix_intro> cat -n .gitignore requirements.txt > output.txt
    
```

Print all non visiable characters

```bash
cat docs/shell/index.md -n
```


## References

* [Man](http://man7.org/linux/man-pages/man1/cat.1.html)
