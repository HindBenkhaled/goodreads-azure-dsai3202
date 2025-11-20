# goodreads-azure-dsai3202


A cloud data project for DSAI3202 — building an Azure Lakehouse with the Goodreads dataset.

---

##  Lab 3 – Data Preprocessing  
Built the foundational pipeline (Bronze → Silver → Gold) by:  
- Setting up ADLS Gen2 storage  
- Using Azure Data Factory to convert raw JSON → Parquet  
- Cleaning and transforming data in Databricks with Spark, producing a curated Gold table  

---

##  Lab 4 – Feature Engineering  
Extended the Gold layer into a feature-rich dataset ready for ML:  
- Review text cleansing and normalization  
- Sentiment analysis (VADER)  
- TF-IDF vectorization via Spark ML  
- Semantic embeddings (SentenceTransformer)  
- Readability and complexity metrics  



---

##  Repo Structure 
## Repo Structure
- `notebooks/` – Databricks notebooks for both labs  
- `sql/` – SQL scripts for Data Preprocessing in Microsoft Fabric 
- `README.md` – this overview


## Branches
- `main` – summary and final structure  
- `data_preprocessing` – Lab 3 (cleaning + curated Gold table)  
- `feature_engineering` – Lab 4 (text features + embeddings)


