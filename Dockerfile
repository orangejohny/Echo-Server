ARG PORT=4000

FROM --platform=$BUILDPLATFORM node:lts-alpine AS build
WORKDIR /build
# COPY package.json .
# COPY package-lock.json .
COPY . .
RUN npm install
RUN npm run build

FROM node:lts-alpine
WORKDIR /app
COPY --from=build /build/src/global.json .
COPY --from=build /build/dist/webserver.js .

ENV PORT=${PORT}

ENTRYPOINT [ "node", "webserver" ]
