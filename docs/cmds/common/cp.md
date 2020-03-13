Title:   cp
Summary: cp: copy files and directories
Authors: Carlos Ortiz
Date:    May 21, 2019

# cp

Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.


## Synopsis

``` bash
cp [OPTION]... [-T] SOURCE DEST
cp [OPTION]... SOURCE... DIRECTORY
cp [OPTION]... -t DIRECTORY SOURCE...
```

## Examples

Copy file to the other folder
``` bash
cp ~/myFile.txt /tmp/myFile.txt
```

Copy a folder to and another folder
``` bash
cp -r ~/myFolder /tmp/myFolder
```
Copy a folder to and another folder and show information

``` bash
cp -rv ~/myFolder /tmp/myFolder
```
Copy a folder to and another but *do not* override existing files

``` bash
cp -rn ~/myFolder /tmp/myFolder
```

Copy only when the SOURCE file is newer than the destination file or when the destination file is missing

``` bash
cp -ru ~/myFolder /tmp/myFolder
```
Copy to an specific directory 

``` bash
cp -t DEST SOURCE SOURCE 2 SOURCE 3
```

Copy and preserve the specified attributes(mode,ownership,timestamps),  if possible additional attributes: context, links, xattr, all

``` 
cp -p SOURCE DEST
```

## References

* [Man](http://man7.org/linux/man-pages/man1/cp.1.html)

