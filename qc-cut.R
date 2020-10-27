library(magrittr)
prefix_list <- c('MRT1_b1','MRT2_b2', 'MRT_b2', 'MTC1_b1', 'MTC2_b1', 'MTC_b2', 'MRT_Ribo1', 'MRT_Ribo2', 'MRT1_T', 'MRT2_T')

prefix_list_r_f <- c()
for (k in 1:length(prefix_list)){
  prefix_list_r_f <-c(prefix_list_r_f, paste0(prefix_list[k], "_forward_paired_fastqc"), paste0(prefix_list[k], "_reverse_paired_fastqc"))
} 
i <- 1  
while (i <= length(prefix_list_r_f)){
  l = prefix_list_r_f[i]
  inp <- paste0("C:/Users/DENIS/Desktop/Fasqc_reports/fastqc/",l, ".zip")
  outp <- paste0("C:/Users/DENIS/Desktop/Fasqc_reports/fastqc/overrepresented/", l, ".fa")
  
  if (length(fastqcr::qc_read(inp)$overrepresented_sequences) == 0) {
    i <- i+1
  } else {
  fastqcr::qc_read(inp)$overrepresented_sequences %>%
    dplyr::mutate(name=paste(">",1:dplyr::n(),"-",Count,sep=""),fa=paste(name,Sequence,sep="\n")) %>%
    dplyr::pull(fa) %>% 
    readr::write_lines(outp)
    i <- i+1
  }
}
