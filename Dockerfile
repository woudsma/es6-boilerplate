FROM node:14-alpine as builder

ARG PUBLIC_URL
ENV PUBLIC_URL=${PUBLIC_URL}

ADD package*.json ./
RUN npm install --only=production
ADD . .
RUN npm run-script build

FROM nginx:alpine
COPY nginx.default.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
COPY --from=builder /build .

EXPOSE 5000
