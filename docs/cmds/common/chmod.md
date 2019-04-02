Title:   chmod
Summary: clear: clears your screen if this is possible, including its scrollback buffer
Authors: Carlos Ortiz
Date:    March 29, 2019

# chmod

`chmod` changes the file mode bits of each given file
according to mode, which can be either a symbolic representation of changes to make, or an octal number rep‐
resenting the bit pattern for the new mode bits.

 A  combination  of  the  letters _ugoa_ controls which users' access to the file will be changed: the user who
owns it (_u_), other users in the file's group (_g_), other users not in the file's group (_o_), or all users (_a_).

If  none  of these are given, the effect is as if (_a_) were given, but bits that are set in the umask are not
affected.

The operator _+_ causes the selected file mode bits to be added to the existing file mode bits of each file; _-_ causes  them  to  be removed;


The letters _rwxXst_ select file mode bits for the affected users: read (_r_), write (_w_), execute (or search for
directories)  (_x_), execute/search only if the file is a directory or already has execute permission for some
user (_X_), set user or group ID on execution (_s_), restricted deletion flag or sticky bit (_t_).


A  numeric mode is from one to four octal digits (0-7), derived by adding up the bits with values 4, 2, and 1
**Omitted digits are assumed to be leading zeros.**

The first digit selects the set user  ID  (4)  and  set
group ID (2) and restricted deletion or sticky (1) attributes.


The second digit selects permissions for the
user who owns the file: read (4), write (2), and execute (1); the third selects permissions for other  users
in  the file's group, with the same values; and the fourth for other users not in the file's group, with the
same values.

| Binary | Octal | Perms |
|--------|-------|-------|
| 0      | 000   | ---   |
| 1      | 001   | --x   |
| 2      | 010   | -w-   |
| 3      | 011   | -wx   |
| 4      | 100   | r--   |
| 5      | 101   | rw    |
| 6      | 111   | rwx   |

!!! Note 
	chmod never changes the permissions of symbolic links

	This  is  not  a problem since the permissions of symbolic links are never used

## Examples

Change permissions output a diagnostic for every file processed

``` bash
chmod -v 0666 myFolder
```

Change permission to multiples users and groups at the same time
```bash
 chmod u=rwe,g=rw,o-rwx hello.txt
```

Change permissions and write 

## References

* [Man](http://man7.org/linux/man-pages/man1/chmod.1.html)

