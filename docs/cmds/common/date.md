Title:   date
Summary: date: cPrint or set the system date and time
Authors: Carlos Ortiz
Date:    May 21, 2019

# Date

Print or set the system date and time

## Synopsis

``` bash
 date [OPTION]... [+FORMAT]
 date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
```


## Format
Like in C and Java, data can support formatting the output/input date from a String. Here's a list of the most common formats accepted by date: 

* %%     a literal %  
* %a     locale's abbreviated weekday name (e.g., Sun)
* %A     locale's full weekday name (e.g., Sunday)
* %b     locale's abbreviated month name (e.g., Jan)
* %B     locale's full month name (e.g., January)
* %c     locale's date and time (e.g., Thu Mar  3 23:05:25 2005)
* %C     century; like %Y, except omit last two digits (e.g., 20)
* %d     day of month (e.g., 01)
* %D     date; same as %m/%d/%y
* %e     day of month, space padded; same as %_d
* %F     full date; like %+4Y-%m-%d
* %g     last two digits of year of ISO week number (see %G)
* %G     year of ISO week number (see %V); normally useful only * with %V
* %h     same as %b
* %H     hour (00..23)
* %I     hour (01..12)
* %j     day of year (001..366)
* %k     hour, space padded ( 0..23); same as %_H
* %l     hour, space padded ( 1..12); same as %_I
* %m     month (01..12)
* %M     minute (00..59)


## Examples

Print current date 

``` bash
date
```

Output date and time in RFC 5322 format.
``` bash
date -R
```

Print or set Coordinated Universal Time (UTC)
``` bash
date -u
```

Print date with a given format

``` bash
date +"%m/%d/%y"
``` 



## References

* [Man](http://man7.org/linux/man-pages/man1/clear.1.html)

