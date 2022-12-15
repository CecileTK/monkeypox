nextstrain build --conda . data/sequences.fasta data/metadata.tsv

nextstrain build --conda  --cpus 1 . results/hmpxv1/aligned.fasta 
results/hmpxv1/insertions.fasta --configfile config/my_config_hmpxv1.yaml

#nextstrain build --conda --cpus 4 . --configfile config/my_config_hmpxv1.yaml
