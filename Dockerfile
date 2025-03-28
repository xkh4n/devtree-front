FROM node:22-alpine3.20 as dev-dependencies
WORKDIR /app
COPY ./package.json ./package.json
RUN npm install



FROM node:22-alpine3.20 as builder-dev
WORKDIR /app
COPY --from=dev-dependencies /app/node_modules ./node_modules
COPY --from=dev-dependencies /app/package.json ./package.json
COPY ./src ./src
COPY ./src/index.ts ./src
COPY ./src/server.ts ./src
COPY ./.env ./.env



FROM node:22-alpine3.20 as dev
WORKDIR /app
COPY --from=builder-dev /app .
EXPOSE 3031
CMD [ "npm","run","dev" ]
