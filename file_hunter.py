# -*- coding: utf-8 -*-
"""
Created on Sun Nov 17 19:26:23 2024

@author: Indranil Seal
"""

import os

def get_files_and_sizes(folder_path):
    # List of file extensions to look for
    file_extensions = ['.doc', '.docx', '.pdf', '.ppt', '.pptx']
    total_size = 0
    
    print(f"{'File Name':<50} {'Size (KB)':>10}")
    print("-" * 60)
    
    # Traverse the folder
    for root, _, files in os.walk(folder_path):
        for file in files:
            # Check if file has one of the desired extensions
            if any(file.lower().endswith(ext) for ext in file_extensions):
                file_path = os.path.join(root, file)
                file_size = os.path.getsize(file_path) / 1024  # Convert size to KB
                total_size += file_size
                print(f"{file:<50} {file_size:>10.2f}")
    
    print("-" * 60)
    print(f"{'Total Size (KB)':<50} {total_size:>10.2f}")

# Provide the folder path
#folder_path = input("Enter the folder path: ").strip()
folder_path = input("D:\DREAM\library").strip()
if os.path.isdir(folder_path):
    get_files_and_sizes(folder_path)
else:
    print("Invalid folder path.")
