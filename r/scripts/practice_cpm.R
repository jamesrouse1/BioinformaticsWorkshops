library(data.table)

cpm_df <- cpm

rownames(cpm_df) <- cpm_df$Gene
cpm_df <- cpm_df %>%
  mutate(
    Tumor_Mean = (Tumor_1 + Tumor_2 + Tumor_3) / 3,
    Normal_Mean = (Normal_1 + Normal_2 + Normal_3) / 3
  )
cpm_df %>%
  mutate(Tumor_Mean = rowMeans(select(., Tumor_1, Tumor_2, Tumor_3)))

cpm_df <- cpm_df %>%
  mutate(log2FC = log2(Tumor_Mean / Normal_Mean))

ensembl_ids <- fread("/Users/rouse/CSH/meta_files/ensembl_gene_name.tsv")

cpm_df$gene_name <- rownames(cpm_df)

cpm_df_merged <- cpm_df %>%
  left_join(ensembl_ids, by = c("gene_name"))

cpm_df_merged %>%
  arrange(desc(log2FC)) %>%
  select(gene_id, log2FC) %>%
  slice(1)

cpm_df <- cpm_df %>%
  rowwise() %>%
  mutate(
    p_value = t.test(c_across(Tumor_1:Tumor_3), c_across(Normal_1:Normal_3))$p.value
  ) %>%
  ungroup()

p_values <- numeric(nrow(cpm_df))

for (i in 1:nrow(cpm_df)) {
  tumor_vals <- as.numeric(cpm_df[i, c("Tumor_1", "Tumor_2", "Tumor_3")])
  normal_vals <- as.numeric(cpm_df[i, c("Normal_1", "Normal_2", "Normal_3")])
  p_values[i] <- t.test(tumor_vals, normal_vals)$p.value
}

cpm_df$p_value <- p_values

library(ggplot2)

# Assume your dataframe is called `cpm_df`

library(ggplot2)

# Add a column to categorize regulation
cpm_df <- cpm_df %>%
  mutate(
    regulation = case_when(
      p_value < 0.05 & log2FC > 0.2  ~ "Upregulated",
      p_value < 0.05 & log2FC < -0.2 ~ "Downregulated",
      TRUE                           ~ "Not Significant"
    )
  )

# Plot
ggplot(cpm_df, aes(x = log2FC, y = -log10(p_value), color = regulation, label = gene_name)) +
  geom_point(size = 3) +
  geom_text(aes(label = ifelse(p_value < 0.05 & abs(log2FC) > 0.2, gene_name, "")),
            hjust = 0, vjust = 1.5, size = 3.5, show.legend = FALSE) +
  scale_color_manual(values = c("Upregulated" = "red", "Downregulated" = "blue", "Not Significant" = "grey30")) +
  geom_vline(xintercept = c(-0.2, 0.2), linetype = "dashed", color = "black") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  theme_minimal() +
  labs(
    title = "Volcano Plot",
    x = "log2 Fold Change",
    y = "-log10(p-value)",
    color = "Regulation"
  )

# Calculate correlation
cor_val <- cor(cpm_df$Normal_Mean, cpm_df$Tumor_Mean, method = "pearson", use = "complete.obs")
cor_label <- paste0("r = ", round(cor_val, 3))

# Plot with annotation in top-left
ggplot(cpm_df, aes(x = Normal_Mean, y = Tumor_Mean)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "blue", se = FALSE) +
  annotate("text", x = -Inf, y = Inf, label = cor_label, 
           hjust = -0.1, vjust = 1.2, size = 5, color = "black") +
  theme_minimal() +
  labs(
    title = "Scatter Plot: Tumor vs. Normal Expression",
    x = "Normal Mean (CPM)",
    y = "Tumor Mean (CPM)"
  )

ggplot(cpm_df, aes(x = Normal_Mean)) +
  geom_histogram(bins = 10, fill = "steelblue", color = "white", alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "Histogram of Normal Mean Expression",
    x = "Normal Mean (CPM)",
    y = "Frequency"
  )


library(ggplot2)

# Select top 20 genes by significance
top_dot <- cpm_df %>%
  arrange(p_value) %>%
  slice(1:20)

# Plot
ggplot(top_dot, aes(x = log2FC, y = reorder(gene_name, log2FC), 
                    size = -log10(p_value), color = regulation)) +
  geom_point() +
  scale_color_manual(values = c("Upregulated" = "red", "Downregulated" = "blue", "Not Significant" = "grey30")) +
  theme_minimal() +
  labs(
    title = "Dot Plot of Top 20 Differentially Expressed Genes",
    x = "log2 Fold Change",
    y = "Gene",
    size = "-log10(p-value)",
    color = "Regulation"
  )




top_genes <- cpm_df %>%
  arrange(p_value) %>%
  slice(1:25) %>%
  pull(gene_name)


# Subset CPM data for those genes and relevant columns
heatmap_mat <- cpm_df %>%
  filter(gene_name %in% top_genes) %>%
  select(Tumor_1, Tumor_2, Tumor_3, Normal_1, Normal_2, Normal_3)

heatmap_mat <- as.data.frame(heatmap_mat)

rownames(heatmap_mat) <- cpm_df$gene_name[cpm_df$gene_name %in% top_genes]

# Assign row names as gene names
rownames(heatmap_mat) <- cpm_df$gene_name[cpm_df$gene_name %in% top_genes]

library(pheatmap)



annotation_col <- data.frame(
  Group = c(rep("Tumor", 3), rep("Normal", 3))
)
rownames(annotation_col) <- c("Tumor_1", "Tumor_2", "Tumor_3", 
                              "Normal_1", "Normal_2", "Normal_3")

pheatmap(
  heatmap_mat,
  annotation_col = annotation_col,
  scale = "row",
  show_rownames = TRUE,
  main = "Clustered Heatmap of Top 50 DE Genes"
)
