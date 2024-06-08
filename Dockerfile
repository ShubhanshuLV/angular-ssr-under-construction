FROM node:hydrogen-alpine3.20 as build
WORKDIR /app
COPY package*.json ./
RUN npm ci --legacy-peer-deps
COPY . ./
RUN npm run build --omit=dev

FROM node:hydrogen-alpine3.20
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/package*.json ./
ENV NODE_ENV production
ENV PORT 80
EXPOSE 80
CMD ["npm", "start"]
