#!/usr/bin/env python3

import random
import itertools
import sys, getopt
import argparse
import numpy as np
from sklearn import preprocessing
import math

def get_args():
  parser = argparse.ArgumentParser(description='generates vectors for community simulation')
  parser.add_argument('-f', '--genomes', help='genome list file path',
    type=str, metavar='GENOMES', required=True)
  parser.add_argument('-m', '--meta', help='nb of metagenomes',
    type=int, metavar='META', required=True)
  parser.add_argument('-o', '--output', help='output directory',
    type=str, metavar='OUTPUT', required=True)
  parser.add_argument('-mi', '--mini', help='minimum nb of org',
    type=int, metavar='MINI', required=True)
  parser.add_argument('-ma', '--maxi', help='maximum nb of org',
    type=int, metavar='MAXI', required=True)
  parser.add_argument('-q', '--queue', help='queued distribution?',
    type=str, metavar='QUEUE', required=True)
  return parser.parse_args()

def get_meta(vec):

    list2=list()
    for i in np.nditer(vec):
        #print(i, end=' ')
        temp=abs(float(np.random.normal(0, i, 1)))
        list2.append(float(temp))

    vec2 = np.array(list2)
    vec_temp = np.add(vec, vec2)
    vecsum=np.sum(vec_temp)
    norm_vec=vec_temp/vecsum

    return norm_vec

def main():
    args = get_args()
    outdir= args.output
    mygenomes= args.genomes
    nb_meta= args.meta
    mymin= args.mini
    mymax= args.maxi
    queue= args.queue
    my_vec = list()
    my_names = list()
    np.set_printoptions(precision=5,suppress=True)

#load names of genomes in array
    fin = open(mygenomes, "r")
    for x in fin:
        my_names.append(x.strip())
    names=np.array(my_names)
    print(names)
    
    upper=0
    if names.size < mymax:
        upper=names.size
    else :
        upper=mymax 

#pick a random number of organism between min and max, generates a vector of abundance
    for i in range(nb_meta):
        cpt=0
        mynb=int(random.randint(mymin,upper))
        print("this is my number")
        print(str(mynb))
        if queue == "TRUE" :
           print("this is the major population :")
           major=int(math.ceil(mynb/5.0))
           print(str(major))
           major_init=0.6/major
           major_vec=np.full(major, major_init, dtype=float)
           minor=mynb-major
           minor_init=0.4/minor
           minor_vec=np.full(minor, minor_init, dtype=float)
           vec=np.concatenate([major_vec,minor_vec])
           new_vec = get_meta(vec)
        else :
            init=1/mynb
            vec=np.full(mynb, init, dtype=float)
            new_vec = get_meta(vec)

#print profile file out
        np.random.shuffle(names)
        outfile=outdir+"/meta_"+str(i+1)+".txt"
        fout = open(outfile, 'w')
        for j in np.nditer(new_vec):
            fout.write(names[cpt]+"\t"+str(float(j))+"\n")
            cpt+=1


if __name__ == "__main__":main()
