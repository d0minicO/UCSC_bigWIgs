# Hosting bigwig files to visualize on UCSC
### How to host a bigwig file to visualize on UCSC
You can host bigWig files on github for free and visualize on UCSC. You just need to alter the URL slightly before loading as a custom track.

First create a new repository on github. (Github desktop is easy to use!)
Then add the bigwig files and commit to main.

Original URL looks like this:
```sh
https://github.com/d0minicO/UCSC_bigWIgs/blob/main/GSE56802_DDX21_WT_iCLIPseq.bw
```

Change this to
```sh
https://raw.githubusercontent.com/d0minicO/UCSC_bigWIgs/main/GSE56802_DDX21_WT_iCLIPseq.bw
```

then add to UCSC custom tracks like this:
```sh
track type=bigWig name="My Big Wig" color=0,200,0 description="A Graph of Data from My Lab" visibility=2 bigDataUrl=https://raw.githubusercontent.com/d0minicO/UCSC_bigWIgs/main/GSE56802_DDX21_WT_iCLIPseq.bw
```
