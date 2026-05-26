import os
import time
from datetime import datetime
import sys

# Remove the current folder to avoid importing the local 'mastodon' package instead of the library
script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path = [p for p in sys.path if p not in (script_dir, '', '.')]
from mastodon import Mastodon
# Restore sys.path after importing
sys.path.insert(0, script_dir)
from markdownify import markdownify as md

# --- CONFIGURATION ---
# Replace these with your own Mastodon instance and access token
INSTANCE_URL = os.environ.get("MASTODON_INSTANCE_URL", "https://mastodon.social")
TOKEN = os.environ.get("MASTODON_ACCESS_TOKEN", "YOUR_ACCESS_TOKEN_HERE")
OUTPUT_DIR = os.environ.get("MASTODON_OUTPUT_DIR", "./mastodon_history")
MAX_POSTS_PER_USER = 100  # Safety limit for fetching history

# List of accounts to back up (Format: username@domain or just username if local to the instance)
TARGET_ACCOUNTS = [
    "user1@instance.social",
    "user2@anotherinstance.org"
]

os.makedirs(OUTPUT_DIR, exist_ok=True)

def fetch_account_history(mastodon_client, account_handle):
    print(f"\n🔎 Searching for account: {account_handle}...")
    try:
        # 1. Look up account details to get the account ID
        account = mastodon_client.account_lookup(account_handle)
        account_id = account['id']
        username = account['username']
        user_dir = os.path.join(OUTPUT_DIR, username)
        os.makedirs(user_dir, exist_ok=True)
        print(f"✅ ID found: {account_id} for @{username}")
    except Exception as e:
        print(f"❌ Could not find account {account_handle}: {e}")
        return

    # Pagination variables
    max_id = None
    posts_downloaded = 0
    
    print(f"📥 Downloading posts (max {MAX_POSTS_PER_USER})...")
    
    while posts_downloaded < MAX_POSTS_PER_USER:
        # 2. API request using the max_id cursor to go back in time
        # Complies with Mastodon's pagination guidelines
        statuses = mastodon_client.account_statuses(
            account_id, 
            max_id=max_id, 
            limit=40
        )
        
        if not statuses:
            print("🏁 Reached the end of history for this account.")
            break
            
        for status in statuses:
            # Skip boosts (reblogs) if you only want their original posts
            if status['reblog'] is not None:
                continue
                
            post_id = str(status['id'])  # Always treat IDs as strings
            created_at = status['created_at']
            date_str = created_at.strftime("%Y-%m-%d")
            
            # Output file
            filename = f"{date_str}_{username}_{post_id}.md"
            filepath = os.path.join(user_dir, filename)
            
            # 3. Convert HTML to Markdown
            markdown_content = md(status['content']).strip()
            
            # 4. Generate the Markdown template
            markdown_template = f"""---
id: "{post_id}"
author: "{username}"
display_name: "{account['display_name'] or username}"
date: {created_at.isoformat()}
url: "{status['url']}"
---

# Post by {account['display_name'] or username}
*Originally published on {created_at.strftime('%Y-%m-%d at %H:%M:%S')}*

{markdown_content}
"""
            
            with open(filepath, "w", encoding="utf-8") as f:
                f.write(markdown_template)
                
            posts_downloaded += 1
            if posts_downloaded >= MAX_POSTS_PER_USER:
                break

        # 5. Update the cursor for the next batch
        # We take the ID of the oldest post in the current batch (the last one in the list)
        max_id = statuses[-1]['id']
        print(f" -> {posts_downloaded} posts downloaded so far...")
        
        # Respect API rate limits
        time.sleep(0.5)

# --- SCRIPT ENTRY POINT ---
if __name__ == "__main__":
    if TOKEN == "YOUR_ACCESS_TOKEN_HERE":
        print("⚠️ Warning: Access token is set to the default placeholder value.")
        print("Please configure the MASTODON_ACCESS_TOKEN environment variable or edit the script.")
        
    print("🚀 Initializing Mastodon REST client...")
    masto_client = Mastodon(
        access_token=TOKEN,
        api_base_url=INSTANCE_URL
    )
    
    for target in TARGET_ACCOUNTS:
        fetch_account_history(masto_client, target)
        
    print(f"\n🎉 Done! All Markdown files are saved in: {OUTPUT_DIR}")