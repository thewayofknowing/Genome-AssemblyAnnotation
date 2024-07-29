library(ggplot2)
library(GENESPACE)
gpar <- init_genespace(wd = "/storage/homefs/kk22w918/Assembly/8-Comparitive-Genomics", path2mcscanx = "/storage/homefs/kk22w918/MCScanX")
out <- run_genespace(gsParam = gpar, overwrite = T)