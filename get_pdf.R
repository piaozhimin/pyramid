#通过R语言调用latex程序，将质控结果图片写入pdf中
#调用该程序，用户需在命令行输入六个参数：1-数据类型;2-图片所在工作目录;3-rseqc的结果名称前缀;4-latex程序文件所在工作目录;5-样本名称;6-tophat结果txt所在目录；
library(utils)
#install.packages("raster")
library(sp)
library(raster)
args<-commandArgs(TRUE)
#setwd("/home/chuhong/Downloads/first_project")
#"/home/liyunfan/my_project"
setwd(args[4])
#Getting current time
today<-date()
#The file name in the figures_afqc file 
figures_fqc<-c("","")
#fastqc的结果图片名称，双端有一个结果，单端有两个结果
single_name_fastqc<-c("per_base_quality.png")
paired_name_fastqc<-c("per_base_quality1.png","per_base_quality2.png")
#rseqc的结果图片名称，双端与单端
paired_name_rseqc<-c('_clipping_profile_R1.png','_clipping_profile_R2.png',
	'_deletion_profile.png','_geneBodyCoverage_curves.png',
	'_inner_distance_plot.png','_insertion_profile_R1.png',
	'_insertion_profile_R2.png','_splice_junction.png',
	'_splice_events.png','_junctionSaturation_plot.png',
	'_mismatch_profile.png','_DupRate_plot.png',
	'_GC_plot.png','_NVC_plot.png','_saturation.png')
single_name_rseqc<-c('_clipping_profile.png','_deletion_profile.png',
	'_geneBodyCoverage_curves.png','_insertion_profile.png',
	'_junctionSaturation_plot.png',
	'_mismatch_profile.png','_DupRate_plot.png',
	'_GC_plot.png','_NVC_plot.png','_saturation.png')
#afterqc的结果图片名称，双端与单端
paired_name_afterqc<-c('summary-table.png','filter_stat.png','error_matrix.png','overlap_stat.png',
	'r1_pre_quality.png','r1_pre_content.png','r1_pre_gc.png',
	'r1_pre_discontinuity.png','r1_pre_sb.png',
	'r1_post_quality.png','r1_post_content.png',
	'r1_post_gc.png','r1_post_discontinuity.png',
	'r1_post_sb.png','r2_pre_quality.png',
	'r2_pre_content.png','r2_pre_gc.png',
	'r2_pre_discontinuity.png','r2_pre_sb.png',
	'r2_post_quality.png','r2_post_content.png',
	'r2_post_gc.png','r2_post_discontinuity.png',
	'r2_post_sb.png')
single_name_afterqc<-c('summary-table.png','filter_stat.png',
	'r1_pre_quality.png','r1_pre_content.png','r1_pre_gc.png',
	'r1_pre_discontinuity.png','r1_pre_sb.png',
	'r1_post_quality.png','r1_post_content.png',
	'r1_post_gc.png','r1_post_discontinuity.png',
	'r1_post_sb.png')
#为图片添加所在的地址的函数
get_bind_name<-function(names,path){
	for(i in 1:length(names)){
		names[i]<-paste(path,names[i], sep = "",collapse="")
	}
	return(names)
}
#为一些必备参数赋值
file_path<-args[2]
rseqc_file_path<-paste(file_path,args[3],sep = "",collapse="")
sample<-args[5]
#添加tophat结果txt文件
txt_content<-read.table(args[6],fill=T,sep=';',stringsAsFactors = F)
for(i in 2:dim(txt_content)[1]){
	txt_content[i,1]<-paste("\\\\hspace*{0.8cm}",trim (as.character(txt_content[i,1])), sep = "",collapse="")
}
txt_content<-paste(txt_content[1:dim(txt_content)[1],1], sep = "",collapse="\\\\\\\\")
txt_content<-gsub("%", "\\\\\\\\%", txt_content)
#不同的数据类型对应不同的latex程序文件
if(args[1]==1){
	#fastq，single
	figures_fqc[1]<-paste(file_path,single_name_fastqc, sep = "",collapse="")
	figures_afqc<-get_bind_name(single_name_afterqc,file_path)
	figures_rsqc<-get_bind_name(single_name_rseqc,rseqc_file_path)
	Sweave("report_Single.Rnw")
}else if(args[1]==2){
	#fastq，double
	figures_fqc[1]<-paste(file_path,paired_name_fastqc[1], sep = "",collapse="")
	figures_fqc[2]<-paste(file_path,paired_name_fastqc[2], sep = "",collapse="")
	figures_afqc<-get_bind_name(paired_name_afterqc,file_path)
	figures_rsqc<-get_bind_name(paired_name_rseqc,rseqc_file_path)
	Sweave("report_Paired.Rnw")
}else if(args[1]==3){
	#bam，single
	figures_fqc[1]<-paste(file_path,single_name_fastqc, sep = "",collapse="")
	figures_rsqc<-get_bind_name(single_name_rseqc,rseqc_file_path)
	Sweave("report_Single_bam.Rnw")
}else{
	#bam，double，但fastqc的结果仍只有一个
	figures_fqc[1]<-paste(file_path,single_name_fastqc, sep = "",collapse="")
	figures_rsqc<-get_bind_name(paired_name_rseqc,rseqc_file_path)
	Sweave("report_Paired_bam.Rnw")
}
#tinytex::pdflatex('report.tex')