out.sorted <- c(0.0,0.021785695627187712,0.06248367378924821,0.1112272086097905,0.16399352175957368,0.2208348571130035,0.2679588318269683,0.3233373386970378,0.38070111279452484,0.4241157724256831,0.4765163784546262,0.515438064886892,0.5370147850164568,0.5715479859986416,0.6192466433310694,0.6441669714226007,0.648503212998276,0.657071208400815,0.6743639308291103,0.6947912857217491,0.7119272765268272,0.7339219476516379,0.7429601379238284,0.7451021367744632,0.7791651428869965,0.7933754767253539,0.8157358549710046,0.8255054594848754,0.8270727757170472,0.8232589728854292,0.8390888668303641,0.853403688417533,0.8520453476829841,0.8462985214983543,0.8584191003604827,0.8607700747087405,0.8575309544955854,0.8558591505146022,0.8624418786897237,0.8866830364139805,0.8833916723264197,0.8831304529543911,0.8956689828117653,0.9394493495637637,0.9682357243613187,1.0,0.9858419100360483,0.9897602006164777,0.9500026121937203,0.9513087090538634,0.9276422339480696,0.9114466328822945,0.9070581474322136,0.9110286818870488,0.9059087821952876,0.8984379081552688,0.8978109816624,0.9001619560106577,0.8907058147432213,0.8921163993521759,0.8975497622903714,0.9202236037824565,0.91040175539418,0.8913849851104958,0.8983334204064574,0.8835484039496369,0.8814064050990021,0.8744057259286349,0.8844365498145342,0.904498197586333,0.8996917611410062,0.8693903139856852,0.8466642286191944,0.8519931038085784,0.8581056371140484,0.8605610992111175,0.8629120735593752,0.8481793009769605,0.857792173867614,0.8720025077059714,0.8593072462253801,0.8445222297685596,0.8235724361318636,0.7994880100308239,0.7563345697716942,0.7533044250561621,0.7471918917506922,0.7295857060759626,0.7257196593699389,0.701112794524842,0.6735280288386186,0.6450028734130924,0.6175225954756804,0.5774515438064887,0.5443289274332584,0.5001306096860143,0.42850425787576407,0.36868502168120787,0.2801316545635024,0.1738676140222559)


png("../out_GSE56087_nor/out_picture/out.geneBodyCoverage.curves.png")
x=1:100
icolor = colorRampPalette(c("#7fc97f","#beaed4","#fdc086","#ffff99","#386cb0","#f0027f"))(1)
plot(x,out.sorted,type='l',xlab="Gene body percentile (5'->3')", ylab="Coverage",lwd=0.8,col=icolor[1])
dev.off()
