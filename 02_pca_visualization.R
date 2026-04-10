# ==============================================================================
# PROJECT: Population Genomics - PCA Visualization
# AUTHOR: Octavio Morga Angel
# DESCRIPTION: Calculates Principal Components from an ANGSD covariance matrix 
#              and visualizes genetic clustering. Includes mock data generation.
# ==============================================================================

# 1. Load Libraries
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(ggplot2)

# ==============================================================================
# 2. DATA LOADING & MOCK DATA GENERATION
# ==============================================================================
cov_file <- "population_cov.covMat"
meta_file <- "population_metadata.txt"

# Generates mock data if real data is absent (for portfolio demonstration)
if (!file.exists(cov_file)) {
  message("⚠️ Raw data embargoed. Generating mock matrix for demonstration...")
  set.seed(9)
  mock_cov <- matrix(rnorm(400, mean = 0, sd = 0.1), nrow = 20)
  mock_cov <- t(mock_cov) %*% mock_cov 
  write.table(mock_cov, cov_file, row.names = FALSE, col.names = FALSE)
  
  mock_meta <- data.frame(
    ID = paste0("Sample_", 1:20),
    Pop = rep(c("NU", "FA", "CH", "CA"), each = 5) # Populations from Rmd
  )
  write.table(mock_meta, meta_file, row.names = FALSE, sep = "\t", quote = FALSE)
}

# Load Data
cov_matrix <- as.matrix(read.table(cov_file, header = FALSE))
sites <- read.table(meta_file, header = TRUE, sep = "\t")

# ==============================================================================
# 3. PCA COMPUTATION
# ==============================================================================
pca_res <- eigen(cov_matrix)
var_explained <- round((pca_res$values / sum(pca_res$values)) * 100, 1)

pca_data <- data.frame(
  PC1 = pca_res$vectors[, 1],
  PC2 = pca_res$vectors[, 2],
  ID = sites$ID,
  Pop = sites$Pop
)

# ==============================================================================
# 4. VISUALIZATION
# ==============================================================================
# Professional color palette adapted from laboratory standards
pop_colors <- c("NU" = "#00468B", "FA" = "#42B540", "CH" = "#ED0000", "CA" = "#0099B4")

pca_plot <- ggplot(pca_data, aes(x = PC1, y = PC2, color = Pop, label = ID)) +
  geom_point(size = 5, alpha = 0.8) +
  scale_color_manual(values = pop_colors) +
  labs(title = "Genetic Clustering across Populations",
       x = paste0("PC1 (", var_explained[1], "%)"),
       y = paste0("PC2 (", var_explained[2], "%)"),
       color = "Population") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.title = element_text(face = "bold")
  )

print(pca_plot)
ggsave("PCA_Populations.pdf", plot = pca_plot, width = 8, height = 6)
message("✅ Plot saved as PCA_Populations.pdf")
