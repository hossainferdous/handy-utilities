##### Program: Creat an MD5 checksum and compare the checksums with the existing files
##### Author: S M Ferdous Hossain
##### Email: smferdoushossain1@gmail.com
##### Date: 15 Aug 2021

getwd()

library(tidyverse)

system('powershell.exe', input='Get-FileHash -Algorithm MD5 -Path (Get-ChildItem "*.*" -recurse -exclude *Checksum*,*Compare*) | Export-Csv -Path "MD5_Checksum_new.txt" ')


file_list = list.files(pattern = "MD5|Checksum")

if(length(file_list) == 2){
  
  for(i in 1:length(file_list)){
    files1 = data.frame(read.table(file=file_list[[1]], skip = 2, sep = ','))
    files2 = data.frame(read.table(file=file_list[[2]], skip = 2, sep = ','))
  }
} else {
    stop('Can not find more then one checksum files')
  }

sim = levels(files1$V2)==levels(files2$V2)

if (file.exists('File_Comparison.txt')) {
  file.remove('File_Comparison.txt')
}

sink('File_Comparison.txt', type = c("output", "message"), split = FALSE)

if(all(levels(files1$V2)==levels(files2$V2))){
  print('Two checksum files matched.')
  stop()
} else {print('WARNING: Following one of more files in the checksum are not matching!')}

as.character(files1[which(sim=='FALSE'),3])

sink()
