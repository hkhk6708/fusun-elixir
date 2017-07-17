# Fusun Admin System

##### App Release Deployment
1. Install all deps `MIX_ENV=prod mix deps.get`
2. Compile them `MIX_ENV=prod mix compile`
3. Compiling your application assets `brunch build --production` && `MIX_ENV=prod mix phoenix.digest`
4. Deploy locally `MIX_ENV=prod mix deploy.local` and move the rel folder under the current release folder

##### Local Development
First Time install the app
1. Go to the project source directory `cd <project_repo>/source`
2. Copy the dev.exs setting `cp /config/dev.exs.sample /config/dev.exs`

Every Time run the app
1. Install all deps `mix dpes.get`
2. Install npm dependencys `npm install`
3. Compile them `mix compile`
4. Run the app `mix phoenix.server`

##### Learn more
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Deployment: http://www.phoenixframework.org/docs/deployment
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
