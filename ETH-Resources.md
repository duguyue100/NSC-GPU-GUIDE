# ETH Resources for Computing

## ETH Euler Cluster for Student

More complete information at [here](https://scicomp.ethz.ch/wiki/Euler).

Use your ETHz login, you can access the cluster via:

```
ssh ethusername@euler.ethz.ch
```

+ __The Good Part:__ If you know tons of OpenMP knowledge and want to
get something done, this is perfect for you

+ __The Bad Part:__
    + There is no GPU Support
    + The file storage is tricky
    + Software constraints

The good news is that the new [Leonhard](https://scicomp.ethz.ch/wiki/Leonhard)
is setting up. Right now it's restricted to only internal users.

It use `bsub` to schedule the computing jobs.

__Side Note:__ I actually want to write some easy wrappers for the `bsub`
jobs because it's not so obvious how to use it. It would be nice if someone
can contribute. Contact me if you want to do it.

## PolyBox -- DropBox like storage service

This is free for ETHz students, you can login with your ETHz username.
Access from [here](https://polybox.ethz.ch/index.php).

__The good parts__ are:

+ 50GB quota
+ Can mount as a `smb` disk
+ Very fast

__The bad parts__ are:

+ Only 50GB quota
+ Upload limit via `smb` disk

It's a great platform in general, use it well!

## CIFEX file sharing

CIFEX is a file sharing service by ETHz, access it from [here](https://cifex.ethz.ch/).

You have 100GB file limit. And it's very fast.
I transferred about 400GB to Canada in few hours.


## Contacts

Yuhuang Hu  
Email: yuhuang.hu@ini.uzh.ch
