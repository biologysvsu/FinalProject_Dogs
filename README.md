Bioinformatics Final Project 
Problem Statement
•	Clearly define the biological question your project addresses.
o	Is there a genetic difference between French Bulldogs and Labs that make one breed more susceptible to cancer?
•	Clearly state your hypotheses
o	Null: There is not a difference in cancer susceptibility between Labrador Retrievers and French Bulldogs
•	Explain why this problem is significant.
o	Less dog cancer = good
•	Define the goal of your project in relation to the problem.
o	Discover potential gene markers that make certain breeds of dog more susceptible to cancer formation
•	List specific objectives that will help achieve this goal.
o	Identify cancer genes in Labradors
o	Identify anti-cancer genes in Frenchies
o	Compare and contrast the abundance of such genes
Connection to Course Topics
•	Demonstrate how your project builds on the concepts and tools covered in class.
•	Gene annotation/analysis
Data and Database
•	Specify the target organism and type of data used 
o	Canis Lupus Familiaris – French Bulldog & Labrador Retriever - WGS
•	Include details on sample size and replicates.
o	5 accession numbers from each breed (10 total)
•	Identify the database(s) where data was retrieved: NCBI
o	SRA database on NCBI
Methods and Tools
•	Highlight the bioinformatics tools, algorithms, or workflows applied for data analysis.
•	Specify the computing resources used, and the time required for processing.
•	Describe any strategies to optimize performance, such as multi-threading, parallelization, or loops.
•	Justify your choice of methods: why is your workflow efficient and appropriate for the problem?
Results and Visualizations
•	Present findings using clear and relevant visualizations (graphs, sequence alignments).
•	Make sure your visuals are properly labeled and have a description/legend.
Conclusions
•	Summarize the key findings and their biological significance.
•	Clearly state whether your data supported the hypothesis.
•	Discuss future directions
Common tumor suppressors and proto-oncogenes in dogs:
1.	Tumor Suppressors:
a.	TP53 - https://www.ncbi.nlm.nih.gov/nuccore/NM_001389218.1?report=fasta
b.	PTEN
i.	CCGCCCGCCGCCAGGCCCGGGGCCGCCTGCAGCCTGCGGAGGAGGCCGCGCCGCCCGCCGCTCCTGCCGT
CTCTCTCCTCCTTCCTCTCCAGCCACCGGCTCCCAGACATGACAGCCATCATCAAGGAGATCGTCAGCAG
AAACAAAAGGCGCTACCAGGAGGATGGGTTCGACTTGGACTTGACCTATATTTATCCCAACATTATTGCT
ATGGGGTTTCCTGCAGAAAGACTTGAAGGCGTATACAGGAACAATATTGATGATGTAGTAAGGTTTTTGG
ATTCAAAGCATAAAAACCATTACAAGATATACAATCTGTGTGCTGAAAGACATTATGATACCGCCAAATT
TAACTGCAGAGTTGCACAGTATCCTTTTGAAGACCATAATCCACCACAGCTAGAACTTATCAAACCCTTT
TGTGAAGATCTTGACCAATGGCTAAGTGAAGATGACAATCATGTTGCAGCAATTCACTGTAAAGCTGGAA
AGGGACGAACTGGTGTAATGATTTGTGCATATTTATTACATCGGGGCAAATTTCTAAAGGCACAAGAGGC
CCTAGATTTCTATGGGGAAGTAAGGACCAGAGACAAAAAGGGAGTAACTATTCCCAGTCAGAGGCGCTAT
GTGTATTATTATAGCTACCTGTTAAAGAATCATCTGGATTATAGACCAGTGGCACTGTTGTTTCACAAGA
TGATGTTTGAAACTATTCCAATGTTCAGTGGCGGAACTTGCAATCCTCAGTTTGTGGTCTGCCAGCTAAA
GGTGAAGATCTATTCCTCCAATTCAGGACCCACACGACGGGAAGACAAGTTCATGTACTTTGAGTTCCCT
CAGCCATTGCCTGTGTGCGGTGACATCAAAGTAGAGTTCTTCCACAAACAGAACAAGATGCTAAAAAAGG
ACAAAATGTTTCACTTTTGGGTAAACACATTCTTCATACCAGGACCAGAGGAAACCTCAGAAAAAGTAGA
AAATGGAAGTCTATGTGATCAAGAAATTGATAGTATTTGCAGTATAGAACGTGCAGATAATGACAAGGAA
TATCTAGTACTCACTTTAACAAAAAATGATCTCGACAAAGCAAATAAAGACAAGGCCAACCGATATTTTT
CTCCAAATTTTAAGGTGAAGCTGTACTTCACAAAAACTGTAGAGGAGCCATCAAACCCGGAGGCTAGCAG
TTCAACTTCTGTGACGCCAGATGTTAGTGACAATGAACCTGATCATTATAGATATTCTGACACCACTGAC
TCTGACCCAGAGAATGAACCCTTTGATGAAGATCAGCACACACAAATCACAAAAGTCTGAATTTTTTTTA
ATCAAGAGGGATAAAACACCATGAAAACAAACTTGAATAAACTGAAATTGGACCTTTTTTTTTTAA
c.	BRCA1
d.	BRCA2
e.	CDKN2A
f.	WT1
2.	 Protooncogenes:
a.	MYC
b.	RAS
c.	SRC
d.	ABL
e.	 EGFR
f.	HER2
Links and resources: 
1.	Labrador SRRs https://www.ncbi.nlm.nih.gov/Traces/study?acc=SRP724329&o=acc_s%3Aa
2.	Other dog breed SRRs (includes French bulldogs) https://www.ncbi.nlm.nih.gov/Traces/study?page=2&acc=SRP424334&o=acc_s%3Aa
Labrador Retriever SRR
1.	SRR23628612   10
2.	SRR29398833  116
3.	SRR35557651   558
4.	SRR23628673  71
5.	SRR23628682  80
French Bulldog SRR
1.	SRR23628665
2.	SRR27051485
3.	SRR23628636
4.	SRR35533785
5.	SRR35538214
Bowtie used to map genes from a reference gene using 10 different cancer genes for the comparison. 
Week 4 repository has instructions for assembling a genome and comparing it to another genome. 

Genes of interest
2. The five genes I would start with
Gene	Category	Why investigate it?
TP53	Tumor suppressor	Controls responses to DNA damage and abnormal cell growth
BRCA1	Tumor suppressor / DNA repair	Helps repair damaged DNA
BRCA2	Tumor suppressor / DNA repair	Maintains genomic stability
RB1	Tumor suppressor	Regulates cell-cycle progression
PIK3CA	Oncogene	Participates in signaling that regulates cell growth and survival



