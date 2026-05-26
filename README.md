# Aletheia: The First-Principles AI

Aletheia is a suite of tools structured around Google Antigravity CLI and the Model Context Protocol (MCP). Designed as an ecosystem, Aletheia aims to build a semi-autonomous (and eventually fully autonomous) AI assistant capable of reasoning, acting, and querying complex data with surgical precision.

# Vision & Philosophy

Aletheia's goal is to drastically reduce the friction between a complex question and the truth. By combining advanced LLM capabilities with knowledge bases and real-time APIs, the system acts as a personal "Jarvis". The architecture is designed according to first principles: modular, OS-agnostic, yet deeply integrated, with absolute respect for data security and privacy 

# Features & Integrations 

Aletheia integrates a network of diverse tools to provide high-quality contextual responses:

### Productivity & Tools

* Google Workspace: Read/write access to Gmail, Calendar, Docs, Sheets, Slides, and Google Drive with the official MCP Server.
* Google Maps and Google Weather: Integrated geographical context, route calculations, and weather conditions with the official MCP Server.
* GitHub: Reading repositories, code analysis, managing issues and PRs directly from the terminal with the official MCP Server.

### Social media, news, macro data and markets  

* Mastodon: fetch the lastest posts of a list of Mastodon accounts through the official API.
* Reddit: fetch relevant subreddits according to a selected topic through the skill "Last 30 Days".
* Hacker News: fetch relevant blogs according to a selected topic through the skill "Last 30 Days".
* Polymarket: Access to predictive markets through a MCP Server.
* Data Commons: Querying raw macroeconomic data (GDP, inflation, demographics, life expectancy...) through a MCP Server.

### You will find links to all GitHub repositories in links.md so you can install it on your own device. 
### I will upload tutorials to install everything that is needed besides what is already on GitHub. 

# Automations:

First we connect the data sources. However the magic is not yet fully developed. Now we need to automate data retrieval and exploitation. 

### Social media, news, macro data and markets

- Reddit and Hacker News: the script "antigravity_cli_last30days_auto.sh" automates the fetch of Reddit and Hacker news, through the skill Last 30 days, for one topic that you need to write in the terminal after launching the script. For now it just loops an Antigravity CLI then prompts it until the markdown file with the data is written. Only works on macOS for now, the script will be available on Linux and Windows very soon. You will be able to loop over a list of topics also. More options are in development.
- Mastodon: the script "mastodon_history_to_markdown.py" automates the fetch of Mastodon posts from a list of accounts. You need to add the official Mastodon API key. Works on any OS for any Mastodon instance.

What we are going to add in the future :

* Scraping on websites and blogs (prototypes on Anthropic and Terrence Tao blogs are already working fine! )
* WhatsApp, Apple Messages (iMessage & SMS), Slack, Discord, Signal, Telegram so you can read your messages through AI
* YouTube
* X, Threads, Mastodon, Bluesky
* Other social media through Scrape Creators (Facebook, Instagram, Tik Tok, Linkedin...)
* Financial markets data : stocks, Forex, oil, gold, T-bills, bonds, cryptocurrencies...
* Anything that is publicly available and/or on the Internet ( as far as it is legal content and legal to get access to it ).

# Roadmap

- [x] Phase 1: Basic architecture (gemini-cli + connection of MCP servers like Google Workspace and GitHub)
- [ ] Phase 2: Connection of more MCP servers and skills : Social media (X, Threads, Mastodon, Bluesky..), Financial markets, ShadowBroker data (planes, boats, trains, CCTV cameras, satellites, and other OSINT data)... 
- [ ] Phase 3: Integration of databases (relational SQL, vector databases, and graph-based like Cognee) to build a RAG architecture. This is to connect personal and local data, instead of public one. 
- [ ] Phase 4: Implementing shell and python scripts to loop the AI, like Ralph. I am currently working on it, and partially automating some tasks with scripts. The goal is to implement Ralph and self-made scripts to create at least semi-autonomous AIs, so we don't have to monitor them and can automate and parallel tasks while having truthful and reliable up-to-date data. 

⚠️ DISCLAIMER ⚠️

I try to do my best to make it great. This is a personal project for now. Everything is open source and free to use for everyone under MIT licence.
If there is something that is illegal, regarding the content or the access to it, I'm not personnaly responsible. I try to do my best to follow the law and GDPR regulations in France and in the EU.
As far as I am aware of, I do think that everything is completely okay to use. If there is anything that we can't access or use, I will remove it as soon as I know it should be removed. 
Please be indulgent, I am an individual, I'm absolutely not profiting in any ways financially on this project. I am sharing what I use on my own computer and what I like to do, id est, programming.

I hope you will like this piece of software that I spend hours crafting with passion. 

ENJOY!!
