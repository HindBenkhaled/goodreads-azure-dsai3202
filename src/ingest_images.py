import os
from azure.storage.blob import BlobServiceClient

# -------------------------------
# CONFIGURATION
# -------------------------------

# Local dataset path (you will fill this later)
LOCAL_DATASET_PATH = "data/mri_dataset"   # contains /yes and /no folders

# Replace with your actual storage account name
STORAGE_ACCOUNT_URL = "https://goodreadsreviews60305805.blob.core.windows.net"


# Your ADLS Gen2 container for Lab 5
CONTAINER_NAME = "lab5tumor"

# Folder structure in ADLS
BRONZE_PATH = "raw/tumor_images"

# -------------------------------
# AUTHENTICATION
# -------------------------------
blob_service_client = BlobServiceClient(account_url=STORAGE_ACCOUNT_URL)
container_client = blob_service_client.get_container_client(CONTAINER_NAME)


def upload_file(local_path, remote_path):
    """
    Upload a single file only if it does not already exist (IDEMPOTENT).
    """
    blob_client = container_client.get_blob_client(remote_path)

    if blob_client.exists():
        print(f"SKIPPED (exists): {remote_path}")
        return

    with open(local_path, "rb") as data:
        blob_client.upload_blob(data)
        print(f"UPLOADED → {remote_path}")


def upload_folder(label):
    """
    Upload all images from either /yes or /no folders.
    """
    folder_path = os.path.join(LOCAL_DATASET_PATH, label)

    for file_name in os.listdir(folder_path):
        local_path = os.path.join(folder_path, file_name)

        if not os.path.isfile(local_path):
            continue

        remote_path = f"{BRONZE_PATH}/{label}/{file_name}"
        upload_file(local_path, remote_path)


def main():
    print("=== Starting MRI dataset ingestion to ADLS Gen2 ===")

    print("\nUploading YES images...")
    upload_folder("yes")

    print("\nUploading NO images...")
    upload_folder("no")

    print("\nDONE: All images uploaded.")
    print("ADLS path:", f"{CONTAINER_NAME}/{BRONZE_PATH}")


if __name__ == "__main__":
    main()
