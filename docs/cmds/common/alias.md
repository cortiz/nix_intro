Title:   Alias
Summary: Alias Cmd
Authors: Carlos Ortiz
Date:    March 29, 2019

# Alias
 
 The alias utility shall create or redefine alias definitions or write the values of existing alias definitions to standard output.
 For more infomation see [Alias](/shell/#alias)


## Synopsis

``` bash
alias
alias [OPTIONS] NAME DEFINITION
alias [OPTIONS] NAME=DEFINITION
```

## Examples


```bash 
# Search Through Terminal History
alias hs='history | grep'
#Open file with admin access
alias snano='sudo nano'
#clear terminal screen
alias c='clear'
# Shows all open ports
alias ports='netstat -tulanp'
#Tail a file 
alias t='tail -f'
```


## References

* [Man](http://man7.org/linux/man-pages/man1/alias.1p.html)
* [Aliases](https://www.tldp.org/LDP/abs/html/aliases.html)