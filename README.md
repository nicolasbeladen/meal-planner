# Meal Planner

> Find healthy and diverse recipes effortlessly for the week.

An AI assistant for busy people who cook and want to eat well. From a short brief, Meal Planner generates a set of recipes tailored to your tastes, household size and cooking habits with ingredients lists ready for shopping.

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

## Tech stack

- **Framework:** Ruby on Rails 8.1 (Ruby 3.3.5)
- **Database:** PostgreSQL
- **Front:** ERB + Bootstrap, importmap
- **Authentication:** Devise
- **AI:** LLM calls via the [RubyLLM](https://github.com/crmne/ruby_llm) gem
- **Deployment:** Heroku

## Team

- [Yassir](https://github.com/ya55ir)
- [Youssef](https://github.com/Youss2313)
- [Yasmine](https://github.com/yasminemid)
- [Nicolas](https://github.com/nicolasbeladen)

## Getting started

### Prerequisites

- Ruby 3.3.5 (see `.ruby-version`)
- PostgreSQL running locally
- Bundler

### Setup

\`\`\`bash
git clone git@github.com:nicolasbeladen/meal-planner.git
cd meal-planner
bundle install
rails db:create db:migrate
\`\`\`

### Environment variables

Secrets are loaded from a `.env` file (git-ignored) via `dotenv-rails`.

### Run

\`\`\`bash
rails server
\`\`\`

Then open http://localhost:3000.
