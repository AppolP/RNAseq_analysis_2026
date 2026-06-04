#' Plot heatmap of top N DEGs
#' 
#' @param res DESeq2 results object
#' @param vsd vst-transformed data
#' @param col_labels vector of column labels (sample names or conditions)
#' @param n_top number of top genes to show
#' @param title plot title
plot_heatmap <- function(res, vsd, col_labels, n_top = 30, title = "Top 30 DEGs") {
  top_genes <- head(order(res$padj), n_top)
  top_data <- assay(vsd)[top_genes, ]
  colnames(top_data) <- col_labels
  
  pheatmap(
    top_data,
    scale = "row",
    main = title,
    fontsize_row = 6,
    fontsize_col = 8,
    angle_col = 45,
    border_color = NA
  )
}

#' Volcano plot with EnhancedVolcano
#' @param res DESeq2 results object
#' @param title plot title
plot_volcano <- function(res, title = "Volcano plot", subtitle = NULL, fc_cutoff = 1, p_cutoff = 0.05) {
  EnhancedVolcano(
    res,
    lab = rownames(res),
    x = 'log2FoldChange',
    y = 'pvalue',
    title = title,
    subtitle = subtitle,
    pCutoff = p_cutoff,
    FCcutoff = fc_cutoff,
    pointSize = 2.0,
    labSize = 4.0
  )
}

#' Run GSEA GO and return plots
#' @param gene_stat named vector (stat values), names = gene symbols
#' @param ont ontology: "ALL", "BP", "MF", or "CC"
#' @param title_prefix prefix for plot titles
run_gsea_go <- function(gene_stat, ont = "ALL", title_prefix = "") {
  
  gse_GO <- gseGO(geneList = gene_stat, 
                  ont = ont, 
                  keyType = "SYMBOL", 
                  minGSSize = 3, 
                  maxGSSize = 800, 
                  pvalueCutoff = 0.05, 
                  verbose = FALSE, 
                  OrgDb = org.Hs.eg.db, 
                  pAdjustMethod = "BH")
  
  p1 <- dotplot(gse_GO, showCategory = 8, split = ".sign") + 
    facet_grid(. ~ .sign) +
    ggtitle(paste(title_prefix, "GSEA GO", ont))
  
  # simplify for "ALL"
  if (ont == "ALL") {
    simplified_result <- clusterProfiler::simplify(gse_GO,
                                                   cutoff = 0.7,
                                                   by = "p.adjust",
                                                   select_fun = min)
    p2 <- dotplot(simplified_result, showCategory = 8, split = ".sign") + 
      facet_grid(. ~ .sign) +
      ggtitle(paste(title_prefix, "GSEA GO", ont, "(simplified)"))
    return(list(gse_GO = gse_GO, simplified = simplified_result, p1 = p1, p2 = p2))
  } else {
    return(list(gse_GO = gse_GO, p1 = p1))
  }
}

#' Run GSEA KEGG and return plot
#' @param gene_list_entrez named vector (stat values), names = ENTREZ IDs
#' @param title_prefix prefix for plot titles
run_gsea_kegg <- function(gene_list_entrez, title_prefix = "") {
  
  gsea_kegg <- gseKEGG(
    geneList = gene_list_entrez,
    organism = "hsa",
    keyType = "ncbi-geneid",
    pvalueCutoff = 0.05,
    pAdjustMethod = "BH"
  )
  
  gsea_kegg <- setReadable(gsea_kegg, 'org.Hs.eg.db', keyType = "ENTREZID")
  
  p <- dotplot(gsea_kegg, showCategory = 8, split = ".sign") + 
    facet_grid(. ~ .sign) +
    ggtitle(paste(title_prefix, "GSEA KEGG"))
  
  return(list(gsea_kegg = gsea_kegg, plot = p))
}

#' Run GSEA with TRED transcription factor database
#' @param gene_list_entrez named vector (stat values), names = ENTREZ IDs
#' @param title_prefix prefix for plot titles
run_tred_gsea <- function(gene_list_entrez, title_prefix = "") {
  
  gmt_file <- "TRED_db.gmt"
  file_conn <- file(gmt_file, "w")
  
  for (tf_name in names(TRED)) {
    target_genes <- TRED[[tf_name]]
    gmt_line <- paste(tf_name, "TRED_target_genes", 
                      paste(target_genes, collapse = "\t"), sep = "\t")
    writeLines(gmt_line, file_conn)
  }
  close(file_conn)
  
  gmt_to_TERM2GENE <- function(gmt_file) {
    readLines(gmt_file) %>% 
      strsplit("\t") %>% 
      lapply(function(x) {
        term <- x[1]
        genes <- x[-c(1, 2)]
        data.frame(term = term, gene = genes)
      }) %>% 
      bind_rows()
  }
  
  TERM2GENE <- gmt_to_TERM2GENE("TRED_db.gmt")
  
  # GSEA
  gsea_TRED <- GSEA(
    geneList = gene_list_entrez,
    pvalueCutoff = 0.05,
    pAdjustMethod = "none",
    TERM2GENE = TERM2GENE
  )
  
  gsea_TRED <- setReadable(gsea_TRED, 'org.Hs.eg.db', keyType = "ENTREZID")
  
  p_dot <- dotplot(gsea_TRED, showCategory = 8, split = ".sign") + 
    facet_grid(. ~ .sign) +
    ggtitle(paste(title_prefix, "TRED GSEA"))
  
  p_gsea <- gseaplot2(gsea_TRED, geneSetID = 1:3)
  
  return(list(gsea_TRED = gsea_TRED, dotplot = p_dot, gseaplot = p_gsea))
}