# Transcriptomic Analysis of Oxaliplatin-resistant Colorectal Adenocarcinoma HCT116 Cells to Identify Markers Associated With Platinum Resistance

## Project goal

To identify transcriptomic markers and biological pathways associated with oxaliplatin resistance and E1A‑induced reprogramming in HCT116 colorectal cancer cells.

## Project structure

The work was divided into four parts:

| Part | Description | Design | Report |
|------------------|--------------------|------------------|------------------|
| **I** | Oxaliplatin‑resistant vs sensitive cells (baseline) | HCT116_oxpl_R vs HCT116 (no E1A, no oxaliplatin) | [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/AppolP/RNAseq_analysis_2026/main/results/BI-PROJECT-TRANSCRIPTOME-6-samples.html) |
| **II** | General E1A effect | All 24 samples, contrast on doxycycline effect | [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/AppolP/RNAseq_analysis_2026/main/results/BI-PROJECT-TRANSCRIPTOME-E1A-effects-for-github.html) |
| **III** | E1A‑induced chemosensitisation | All 24 samples and HCT116 sensitive-only subset; interaction contrast for E1A effect on oxaliplatin response | [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/AppolP/RNAseq_analysis_2026/main/results/E1A_chemosensitization_en.html) |
| **IV** | E1A in resistant cells | Full DESeq2 model with all factors (e1a_status \* condition \* cell_line) | [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/AppolP/RNAseq_analysis_2026/main/results/BI-PROJECT-TRANSCRIPTOME-allfactors.html) |

------------------------------------------------------------------------

## Part I. Oxaliplatin‑resistant vs sensitive cells (baseline comparison)

### Experimental design

-   **Samples**: 3 HCT116 (sensitive) vs 3 HCT116_oxpl_R (resistant)
-   **Conditions**: baseline, without E1A and without oxaliplatin treatment

### Results

#### Differential expression

At thresholds `padj < 0.05, |log2FC| > 1` we detected **2091 differentially expressed genes**: - **Upregulated in resistant cells**: 1380 genes - **Downregulated in resistant cells**: 711 genes

#### PCA

PCA shows clear separation between resistant and sensitive samples.\
**PC1 explains 89% of variance**, indicating that the resistant phenotype is associated with a strong, reproducible transcriptional shift.

#### Top differentially expressed genes

**Upregulated**: `BCL2L15`, `LOXL4`, `ANO1`, `CYP4F3` and others **Downregulated**: `CYP24A1` and others

#### GSEA (GO and KEGG)

**Activated pathways in resistant cells:** - Oxidative phosphorylation (mitochondrial metabolism) - ECM‑receptor interaction (cell adhesion, signalling) - Ribosome biogenesis - Parathyroid hormone pathway - Huntington disease pathway (proteotoxic stress)

**Suppressed pathways in resistant cells:** - Spliceosome (RNA processing) - Nucleocytoplasmic transport - ATP‑dependent chromatin remodelling - mRNA surveillance pathway - Adherens junction (cell‑cell adhesion)

#### KEGG summary (resistant vs sensitive)

| Activated                 | Suppressed                  |
|---------------------------|-----------------------------|
| Oxidative phosphorylation | Spliceosome                 |
| Ribosome                  | Nucleocytoplasmic transport |
| ECM‑receptor interaction  | Chromatin remodelling       |
| Huntington disease        | mRNA surveillance           |

#### TRED transcription factor analysis

**Activated in resistant cells:** `FOS`, `JUN`, `JUND`, `EGR1`, `SMAD1`, `RARA`, `SP1`, `TP53`

**Suppressed in resistant cells:** `E2F4`, `E2F2`

**Interpretation:** Resistant cells already exhibit a distinct transcriptional landscape under baseline conditions. They show activation of stress‑response (AP‑1, p53), metabolic (oxidative phosphorylation) and adhesion pathways, while suppressing RNA processing, transport and chromatin remodelling.

------------------------------------------------------------------------

## Part II. General E1A effect (all 24 samples)

-   **DEGs**: 117 (109 up, 8 down)
-   E1A predominantly activates transcription, consistent with its known mechanism via p300/CBP and Rb/E2F pathways.
-   **Top activated genes**: `JUNB`, `ARC`, `CIRBP-AS1`, `SP110`, `ZFP36`, `HSPA1A`

------------------------------------------------------------------------

## E1A effect on sensitive cells (HCT116, ctrl vs dox+)

-   **DEGs**: 183 (149 up, 34 down) — stronger effect than in full model
-   **GSEA**:
    -   Suppressed: ribosome biogenesis, rRNA processing
    -   Activated: ECM‑receptor interaction, oxidative phosphorylation, neuroactive ligand‑receptor interaction
-   **TRED analysis**: activation of `SMAD4`, `FOS`, `ATF2`, `TP53`, `ETS2`, `WT1`

------------------------------------------------------------------------

## E1A in resistant cells (HCT116_oxpl_R, ctrl vs dox+)

-   **DEGs**: 46 (43 up, 3 down) — much weaker response
-   E1A retains only the core activation signature (`JUNB`, `EGR1`, `ARC`, `HSPA1B`)

------------------------------------------------------------------------

## Part III. E1A-induced chemosensitisation

### Experimental design

-   **Question**: how E1A changes the cellular response to oxaliplatin.
-   **Full analysis**: all 24 samples from the factorial design\
    `cell_line × e1a_status × condition`.
-   **Focused analysis**: 12 samples of sensitive HCT116 cells only:\
    `ctrl`, `E1A/dox+`, `oxpl`, `oxpl + E1A/dox+`.
-   **Main contrast**: interaction between E1A expression and oxaliplatin treatment:

`(oxpl_E1A - ctrl_E1A) - (oxpl - ctrl)`

This contrast asks whether the oxaliplatin response changes when E1A expression is induced.

### DESeq2 models

-   **All 24 samples**: `~ cell_line * e1a_status * condition`
-   **HCT116 only**: `~ e1a_status * condition`

### Results

#### Full 24-sample model

-   **DEGs**: 10 genes at `padj < 0.05` and `|log2FC| > 1`
    -   **Upregulated**: 4 genes
    -   **Downregulated**: 6 genes

**Upregulated genes**:\
`NSUN5P1`, `ITGB7`, `SPEF2`, `RTEL1-TNFRSF6B`

**Downregulated genes**:\
`SULF2`, `DSP-AS1`, `CCN2`, `KLK11`, `CASTOR3P`, `LINC00659`

**Interpretation:**\
In the full model, the E1A-dependent change in oxaliplatin response is relatively narrow at the single-gene level, but it highlights genes whose response to oxaliplatin differs when E1A is induced.

------------------------------------------------------------------------

#### HCT116-sensitive cells only

-   **DEGs**: 15 genes at `padj < 0.05` and `|log2FC| > 1`
    -   **Upregulated**: 7 genes
    -   **Downregulated**: 8 genes

**Upregulated genes**:\
`ATP6V1G2-DDX39B`, `NSUN5P1`, `AGAP13P`, `IFT57`, `ASAH2`, `HNRNPA1L2`, `SPEF2`

**Downregulated genes**:\
`PADI3`, `PKDCC`, `SULF2`, `DSP-AS1`, `GPR162`, `CCN2`, `LINC00659`, `CASTOR3P`

### GSEA: HCT116-only interaction model

**Activated pathways:** - RNA processing - Spliceosome - Ribosome biogenesis - mRNA surveillance - Basal transcription factors - DNA replication - Cell-cycle-associated programs

**Suppressed pathways:** - Cell-substrate adhesion - Extracellular matrix - Integrin/cadherin signaling - Cell migration and motility - PI3K-Akt survival signaling

### Interpretation

E1A modifies the oxaliplatin response in sensitive HCT116 cells by activating RNA-processing, transcriptional and cell-cycle-associated programs, while suppressing adhesion-, migration- and survival-associated pathways.

------------------------------------------------------------------------

## Part IV. Comparison of E1A‑induced chemosensitization between resistant and sensitive cells

**Experimental design**\
- **Samples**: all 24 samples from full factorial design (2 cell lines × 2 E1A status × 2 oxaliplatin treatments × 3 replicates).\
- **Contrast**: triple interaction term `e1a_statuspositive.conditionoxpl.cell_lineHCT116_oxpl_R`\
→ asks: *“Does the effect of E1A on oxaliplatin response differ between resistant (HCT116_oxpl_R) and sensitive (HCT116) cells?”*\
Positive log2FC = stronger (or less suppressive) effect of E1A in resistant cells; negative log2FC = weaker or opposite effect.

**Results**

**Differential expression (triple interaction)**\
- Threshold: `padj < 0.1` (to capture biologically meaningful differences)\
- Total significant genes: **29**\
- Upregulated (LFC \> 0, *stronger effect in resistant*): 26 genes\
- Downregulated (LFC \< 0, *weaker/opposite effect in resistant*): 3 genes

**Top‑upregulated genes (stronger effect in resistant)**\
`PKDCC` (LFC = 5.03), `KLK11` (3.91), `CDT1` (1.95), `E2F1` (1.91), `ARC` (1.76), `NRGN` (1.64), `H2AX` (1.54), `TICRR` (1.51), `MCM5` (1.49), `MYBL2` (1.48), `SULF2` (1.44), `TONSL` (1.23), `TREX1` (\~1.22), `DUSP1` (1.2), `OAS3` (1.2), `KIFC1` (1.19), `MCM7` (1.01)

**Top‑downregulated genes (weaker/opposite effect in resistant)**\
`MYH4` (-29.13), `NSUN5P1` (-24.17), `ITGB7` (-3.66)

**GSEA (GO BP, CC, MF)**\
- All significant GO terms (n = 237) showed **negative NES** (suppressed in resistant cells compared to sensitive on the background of E1A+oxaliplatin).\
- **Main suppressed processes** (representative terms):\
- Ribonucleoprotein complex biogenesis\
- Ribosome biogenesis\
- Ribosomal large subunit biogenesis\
- Preribosome\
- RNA processing / splicing / nucleocytoplasmic transport

→ **Interpretation**: In resistant cells, E1A+oxaliplatin leads to **stronger suppression** of ribosome synthesis and RNA processing than in sensitive cells. This global decrease in translational capacity may contribute to chemosensitization by limiting the ability of resistant cells to mount a protective protein response.

**KEGG ORA (on 20 significant genes with padj \< 0.05)**\
- No significant KEGG pathways were enriched (likely due to small gene set size and functional heterogeneity).

**Conclusion**\
- E1A on top of oxaliplatin **divergently affects** resistant vs sensitive cells:\
- Upregulation of cell‑cycle/DNA‑repair genes (E2F1, CDT1, MCMs, H2AX, TONSL) — possibly reflecting replicative stress.\
- Simultaneous **suppression of ribosome biogenesis and RNA processing** (GSEA) — a metabolic shutdown.\
- This combination (replication stress + reduced protein synthesis) may render previously resistant cells **vulnerable to further damage**, suggesting a mechanism by which E1A could overcome oxaliplatin resistance.

## Conclusions

1.  Oxaliplatin‑resistant cells already have a distinct transcriptomic profile (2091 DEGs) under baseline conditions, with activated stress‑response and metabolic pathways.
2.  E1A induces strong reprogramming in sensitive HCT116 cells (183 DEGs), activating stress‑response and ECM‑related pathways while suppressing ribosome biogenesis.
3.  The effect is dramatically weaker in resistant cells (46 DEGs), suggesting that the resistant phenotype attenuates E1A‑mediated reprogramming.
4.  E1A-induced chemosensitisation analysis showed that E1A remodels the oxaliplatin response in sensitive HCT116 cells, activating RNA-processing and cell-cycle-associated programs while suppressing adhesion, migration and survival pathways.

## Literature

1.  P. Comella, R. Casaretti, C. Sandomenico, A. Avallone, and L. Franco. “Role of oxaliplatin in the treatment of colorectal cancer,” Therapeutics and Clinical Risk Management, vol. 5, no. 1, Feb., pp. 229-238, 2009. <https://doi.org/10.2147/tcrm.s3583>

2.  A. Morshneva, O. Gnedina, K. Fedotova, N. Yartseva, N. Aksenov, and M. Igotti,  “Transcriptomic and Cytogenetic Analysis of Oxaliplatin-Resistant Colorectal Adenocarcinoma HCT116 Cells to Identify Markers Associated with Platinum Resistance,” International Journal of Molecular Sciences, vol. 26, no. 18, Sep., 8869, 2025. <https://doi.org/10.3390/ijms26188869>

3.  Berk AJ. Functions of adenovirus E1A. *Cancer Surv.* 1986;5(2):367-87. PMID: 2946406.

4.  Lundblad JR, Kwok RP, Laurance ME, Harter ML, Goodman RH. Adenoviral E1A-associated protein p300 as a functional homologue of the transcriptional co-activator CBP. *Nature.* 1995;374(6517):85-8. <doi:10.1038/374085a0>

5.  Müller U, Roberts MP, Engel DA, Doerfler W, Shenk T. Induction of transcription factor AP-1 by adenovirus E1A protein and cAMP. *Genes Dev.* 1989;3(12A):1991-2002. <doi:10.1101/gad.3.12a.1991>

6.  Ren FJ, Cai XY, Yao Y, Fang GY. JunB: a paradigm for Jun family in immune response and cancer. *Front Cell Infect Microbiol.* 2023;13:1222265. <doi:10.3389/fcimb.2023.1222265>

7.  Zhang H, Taylor WR, Joseph G, et al. mRNA-binding protein ZFP36 is expressed in atherosclerotic lesions and reduces inflammation in aortic endothelial cells. *Arterioscler Thromb Vasc Biol.* 2013;33(6):1212-20. <doi:10.1161/ATVBAHA.113.301496>

8.  Arce A, Altman R, Badolian A, et al. Heat Shock-Induced PI(4)P Increase Drives HSPA1A Translocation to the Plasma Membrane. *bioRxiv.* 2025. <doi:10.1101/2025.02.16.638537>

9.  Frisch SM. E1a induces the expression of epithelial characteristics. *J Cell Biol.* 1994;127(4):1085-96. <doi:10.1083/jcb.127.4.1085>

10. Elhamamsy AR, Metge BJ, Alsheikh HA, Shevde LA, Samant RS. Ribosome biogenesis: a central player in cancer metastasis and therapeutic resistance. *Cancer Res.* 2022;82:2344-53. <doi:10.1158/0008-5472.CAN-21-4087>

11. Virag P, Fischer-Fodor E, Perde-Schrepler M, et al. Oxaliplatin induces different cellular and molecular chemoresistance patterns in colorectal cancer cell lines of identical origins. *BMC Genomics.* 2013;14:480. <doi:10.1186/1471-2164-14-480>

12. Calibasi-Kocal G, Kurter H, Isik Z. Multifaceted transcriptional reprogramming supports oxaliplatin chemoresistance in colorectal cancer cells. *Anticancer Drugs.* 2026;37(1):16-27. <doi:10.1097/CAD.0000000000001768>

13. T. Pungsrinont, J. Kallenbach, and A. Baniahmad. “Role of PI3K-AKT-mTOR Pathway as a Pro-Survival Signaling and Resistance-Mediating Mechanism to Therapy of Prostate Cancer,” International Journal of Molecular Sciences, vol. 22, no. 20, Oct., 11088, 2021. <https://doi.org/10.3390/ijms222011088>

14. A. M. Kozlova, A. V. Morshneva, O. O. Gnedina, and M. V. Igotti, “Optimization of the Doxycycline-Induced Gene Expression System in HCT116 and A549 Cells,” Cell and Tissue Biology, vol. 19, pp. 151-160, 2025. <https://doi.org/10.1134/S1990519X24600777>
