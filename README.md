# Aletheia: The First-Principles AI

Aletheia is a suite of tools structured around Google gemini-cli and the Model Context Protocol (MCP). Designed as an ecosystem, Aletheia aims to build a semi-autonomous (and eventually fully autonomous) AI assistant capable of reasoning, acting, and querying complex data with surgical precision.

# Vision & Philosophy

Aletheia's goal is to drastically reduce the friction between a complex question and the truth. By combining advanced LLM capabilities with knowledge bases and real-time APIs, the system acts as a personal "Jarvis.". The architecture is designed according to first principles: modular, surface-agnostic, yet deeply integrated, with absolute respect for data security and privacy 

# Features & Integrations (Skills & MCP Servers)

Aletheia integrates a network of diverse tools to provide high-quality contextual responses:

### Productivity & Personal Ecosystem

* Google Workspace (Official): Read/write access to Gmail, Calendar, Docs, Sheets, Slides, and Google Drive.
* Google Maps & Weather (Official): Integrated geographical context, route calculations, and weather conditions.

### Engineering & Development

* GitHub MCP Server (Official): Reading repositories, code analysis, managing issues and PRs directly from the terminal.

### Social media, news, macro data and markets  (Truth-Seeking)

* Skill "Last 30 Days": Real-time aggregation and analysis, includes a lot of things, but for now only Reddit and Hacker News work well.
* Polymarket MCP Server: Access to predictive markets to assess the probabilities of future events based on collective intelligence.
* Data Commons: Querying raw macroeconomic data (GDP, inflation, demographics, life expectancy) to support reasoning with real facts.

# Roadmap

- [x] Phase 1: Basic architecture (gemini-cli + connection of MCP servers like Google Workspace and GitHub)
- [ ] Phase 2: Connection of more MCP servers and skills : Social media (X, Threads, Mastodon, Bluesky..), Financial markets, ShadowBroker data (planes, boats, trains, CCTV cameras, satellites, and other OSINT data)... 
- [ ] Phase 3: Integration of databases (relational SQL, vector databases, and graph-based like Cognee) to buil a RAG architecture. This is to connect personal and local data, instead of public one. 
- [ ] Phase 4: Implementing shell and python scripts to loop the AI, like Ralph. I am currently working on it, and partially automating some tasks with scripts. The goal is to implement Ralph and self-made scripts to create at least semi-autonomous AIs, so we don't have to monitor them and can automate and parallel tasks while having truthful and reliable up-to-date data. 

