# Transcriptomic Analysis of Oxaliplatin-resistant Colorectal Adenocarcinoma HCT116 Cells to Identify Markers Associated With Platinum Resistance

## Project goal

To identify transcriptomic markers and biological pathways associated with oxaliplatin resistance and E1A‑induced reprogramming in HCT116 colorectal cancer cells.

## Project structure

The work was divided into four parts:

| Part | Description | Design | Report |
|------|-------------|--------|--------|
| **I** | Oxaliplatin‑resistant vs sensitive cells (baseline) | HCT116_oxpl_R vs HCT116 (no E1A, no oxaliplatin) | [HTML](results/BI-PROJECT-TRANSCRIPTOME-6-samples.html) |
| **II** | General E1A effect | All 24 samples, contrast on doxycycline effect | [HTML](results/BI-PROJECT-TRANSCRIPTOME-E1A-effects-for-github.html) |
| **III** | E1A‑induced chemosensitisation | All 24 samples, contrast on oxaliplatin and doxycycline effect | |
| **IV** | E1A in resistant cells | Full DESeq2 model with all factors (e1a_status * condition * cell_line) | [HTML](/results/BI-PROJECT-TRANSCRIPTOME-allfactors.html) |

---

## Part I. Oxaliplatin‑resistant vs sensitive cells (baseline comparison)

### Experimental design
- **Samples**: 3 HCT116 (sensitive) vs 3 HCT116_oxpl_R (resistant)
- **Conditions**: baseline, without E1A and without oxaliplatin treatment

### Results

#### Differential expression
At thresholds `padj < 0.05, |log2FC| > 1` we detected **2091 differentially expressed genes**:
- **Upregulated in resistant cells**: 1380 genes
- **Downregulated in resistant cells**: 711 genes

#### PCA
PCA shows clear separation between resistant and sensitive samples.  
**PC1 explains 89% of variance**, indicating that the resistant phenotype is associated with a strong, reproducible transcriptional shift.

#### Top differentially expressed genes
**Upregulated**: `BCL2L15`, `LOXL4`, `ANO1`, `CYP4F3` and others
**Downregulated**: `CYP24A1` and others

#### GSEA (GO and KEGG)

**Activated pathways in resistant cells:**
- Oxidative phosphorylation (mitochondrial metabolism)
- ECM‑receptor interaction (cell adhesion, signalling)
- Ribosome biogenesis
- Parathyroid hormone pathway
- Huntington disease pathway (proteotoxic stress)

**Suppressed pathways in resistant cells:**
- Spliceosome (RNA processing)
- Nucleocytoplasmic transport
- ATP‑dependent chromatin remodelling
- mRNA surveillance pathway
- Adherens junction (cell‑cell adhesion)

#### KEGG summary (resistant vs sensitive)

| Activated | Suppressed |
|-----------|------------|
| Oxidative phosphorylation | Spliceosome |
| Ribosome | Nucleocytoplasmic transport |
| ECM‑receptor interaction | Chromatin remodelling |
| Huntington disease | mRNA surveillance |

#### TRED transcription factor analysis

**Activated in resistant cells:**
`FOS`, `JUN`, `JUND`, `EGR1`, `SMAD1`, `RARA`, `SP1`, `TP53`

**Suppressed in resistant cells:**
`E2F4`, `E2F2`

**Interpretation:** Resistant cells already exhibit a distinct transcriptional landscape under baseline conditions. They show activation of stress‑response (AP‑1, p53), metabolic (oxidative phosphorylation) and adhesion pathways, while suppressing RNA processing, transport and chromatin remodelling.

---

## Part II. General E1A effect (all 24 samples)

- **DEGs**: 117 (109 up, 8 down)
- E1A predominantly activates transcription, consistent with its known mechanism via p300/CBP and Rb/E2F pathways.
- **Top activated genes**: `JUNB`, `ARC`, `CIRBP-AS1`, `SP110`, `ZFP36`, `HSPA1A`

---

## E1A effect on sensitive cells (HCT116, ctrl vs dox+)

- **DEGs**: 183 (149 up, 34 down) — stronger effect than in full model
- **GSEA**:
  - Suppressed: ribosome biogenesis, rRNA processing
  - Activated: ECM‑receptor interaction, oxidative phosphorylation, neuroactive ligand‑receptor interaction
- **TRED analysis**: activation of `SMAD4`, `FOS`, `ATF2`, `TP53`, `ETS2`, `WT1`

---

## E1A in resistant cells (HCT116_oxpl_R, ctrl vs dox+)

- **DEGs**: 46 (43 up, 3 down) — much weaker response
- E1A retains only the core activation signature (`JUNB`, `EGR1`, `ARC`, `HSPA1B`)

---

## Conclusions

1. Oxaliplatin‑resistant cells already have a distinct transcriptomic profile (2091 DEGs) under baseline conditions, with activated stress‑response and metabolic pathways.
2. E1A induces strong reprogramming in sensitive HCT116 cells (183 DEGs), activating stress‑response and ECM‑related pathways while suppressing ribosome biogenesis.
3. The effect is dramatically weaker in resistant cells (46 DEGs), suggesting that the resistant phenotype attenuates E1A‑mediated reprogramming.


## Literature

1. Berk AJ. Functions of adenovirus E1A. *Cancer Surv.* 1986;5(2):367-87. PMID: 2946406.

2. Lundblad JR, Kwok RP, Laurance ME, Harter ML, Goodman RH. Adenoviral E1A-associated protein p300 as a functional homologue of the transcriptional co-activator CBP. *Nature.* 1995;374(6517):85-8. doi:10.1038/374085a0

3. Müller U, Roberts MP, Engel DA, Doerfler W, Shenk T. Induction of transcription factor AP-1 by adenovirus E1A protein and cAMP. *Genes Dev.* 1989;3(12A):1991-2002. doi:10.1101/gad.3.12a.1991

4. Ren FJ, Cai XY, Yao Y, Fang GY. JunB: a paradigm for Jun family in immune response and cancer. *Front Cell Infect Microbiol.* 2023;13:1222265. doi:10.3389/fcimb.2023.1222265

5. Zhang H, Taylor WR, Joseph G, et al. mRNA-binding protein ZFP36 is expressed in atherosclerotic lesions and reduces inflammation in aortic endothelial cells. *Arterioscler Thromb Vasc Biol.* 2013;33(6):1212-20. doi:10.1161/ATVBAHA.113.301496

6. Arce A, Altman R, Badolian A, et al. Heat Shock-Induced PI(4)P Increase Drives HSPA1A Translocation to the Plasma Membrane. *bioRxiv.* 2025. doi:10.1101/2025.02.16.638537

7. Frisch SM. E1a induces the expression of epithelial characteristics. *J Cell Biol.* 1994;127(4):1085-96. doi:10.1083/jcb.127.4.1085

8. Elhamamsy AR, Metge BJ, Alsheikh HA, Shevde LA, Samant RS. Ribosome biogenesis: a central player in cancer metastasis and therapeutic resistance. *Cancer Res.* 2022;82:2344-53. doi:10.1158/0008-5472.CAN-21-4087

9. Virag P, Fischer-Fodor E, Perde-Schrepler M, et al. Oxaliplatin induces different cellular and molecular chemoresistance patterns in colorectal cancer cell lines of identical origins. *BMC Genomics.* 2013;14:480. doi:10.1186/1471-2164-14-480

10. Calibasi-Kocal G, Kurter H, Isik Z. Multifaceted transcriptional reprogramming supports oxaliplatin chemoresistance in colorectal cancer cells. *Anticancer Drugs.* 2026;37(1):16-27. doi:10.1097/CAD.0000000000001768
