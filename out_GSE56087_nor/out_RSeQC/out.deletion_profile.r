pdf("../out_GSE56087_nor/out_RSeQC/out.deletion_profile.pdf")
pos=c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99)
value=c(0,0,980,12659,55265,26531,3908,1427,708,463,386,289,278,356,380,361,387,442,393,411,481,449,426,475,424,390,413,367,426,397,349,370,358,428,440,417,395,369,419,338,439,368,395,441,503,417,423,426,374,377,344,404,359,394,427,385,385,378,366,444,420,420,370,366,404,371,344,413,422,518,643,373,363,378,409,440,434,386,397,376,351,417,383,390,409,396,354,332,330,386,338,328,298,333,370,491,477,126,88,0)
plot(pos,value,type='b', col='blue',xlab="Read position (5'->3')", ylab='Deletion count')
dev.off()
