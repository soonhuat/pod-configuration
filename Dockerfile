FROM node:12

COPY package*.json ./
RUN npm install

RUN groupmod -g 1001 node \
  && usermod -u 1001 -g 1001 node

RUN useradd -u 1000 operatorjob
USER operatorjob

COPY . .

ENTRYPOINT node src/index.js \
  --workflow "$WORKFLOW" \
  --node "$NODE" \
  --credentials "$CREDENTIALS" \
  --password "$PASSWORD" \
  --path "$VOLUME" \
  --verbose \
  # > "$VOLUME/pod-configuration-logs.txt" | tee file
