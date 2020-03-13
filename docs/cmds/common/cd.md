Title:   Cd 
Summary: concatenate files and print on the standard output
Authors: Carlos Ortiz
Date:    March 29, 2019

# cd

The cd  command shall change the working directory of the current shell execution environment

1.  If no directory operand is given and the HOME environment variable is empty or  undefined no further steps shall be taken

2.  If no directory operand is given and the HOME environment variable is set to a non-empty value,HOME environment variable  will be use as directory operand.

3.  When a <hyphen> (-) is used as the operand, this shall be equivalent to the command:

## Synopsis

``` bash
cd [DIRECTORY]
```

## Examples

Goes to A dir
``` bash
cd /tmp
```

Goes to last dirrectory
``` bash
cd -
```

Goes to $HOME

``` bash
cd 
```


## References

* [Man](http://man7.org/linux/man-pages/man1/cd.1p.html)

