# Awesome GitHub Actions Workflows - Personal collection

This repository contains a collection of GitHub Actions workflows that I've found useful. I've also included a brief description of each workflow and some observations and recommendations.

Just add the workflows you want to your repository's `.github/workflows` directory and you're good to go!

## Second Brain workflows

I've recently wrote an article about how I use GitHub Actions to automate my second brain. You can [find the article here](https://medium.com/design-bootcamp/automating-my-second-brain-how-technology-makes-information-management-effortless-afb2a1e4ab11)

### Handle Labels [(handle_labels.yml)](github-actions/notes/handle_labels.yml) 

1. **Triggers**: This action will be triggered when an issue gets labeled.

2. **Jobs**:

   a. `send-epub`: If an issue gets labeled as 'kindle':
      - It will check if the issue does not have the 'summarized' tag and if so, it will wait for 20 seconds.
      - It then installs the necessary software (`pandoc`, `jq`, `ImageMagick`, `sendemail`).
      - It processes the issue data, generating an EPUB file, and sends it to a Kindle device through an email.
      
   b. `save_md`: If an issue gets labeled as 'md':
      - It will check if the issue has the 'md' label and save the issue content as a markdown file to a specific directory based on other tags (like 'article' or 'page'). It will then commit this markdown file to the repository. 

### Append Date to Diary [(append_date_to_diary.yml)](github-actions/notes/append_date_to_diary.yml)

1. **Triggers**: This action will be triggered manually (using `workflow_dispatch`) or automatically every day at midnight.

2. **Job - `append_date`**: 
   - The action will checkout the repository.
   - It will append the current date to the first `journal.md` file it finds.
   - It installs curl and jq.
   - It then makes an API call to OpenAI GPT-3.5 Turbo to generate a daily briefing, which includes an inspiring quote, a fun fact, or something interesting to research that day based on provided topics.
   - This briefing is appended to the `journal.md` file.
   - Finally, it commits these changes to the repository.

### Append Date to Diary [(cron_append_dates.yml)](github-actions/notes/cron_append_dates.yml)

This GitHub Action is designed to automatically append the current date to a `journal.md` file located in any non-hidden directory of the repository. Additionally, this action fetches a daily briefing, which is a short inspiring message crafted using the OpenAI API, and appends it to the same `journal.md` file.

#### Workflow details:
- **Trigger**: 
  - Manually via workflow dispatch
  - Automatically every day at midnight
- **Jobs**:
  1. Checkout the repository.
  2. Append the current date to `journal.md`.
  3. Install `curl` and `jq`.
  4. Generate a day briefing using the OpenAI API.
  5. Append the day briefing to `journal.md`.
  6. Commit and push
