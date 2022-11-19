FROM ghost:5.23

RUN npm install ghost-azure-storage
RUN mkdir -p content/adapters/storage
RUN cp -vR node_modules/ghost-azure-storage content/adapters/storage/ghost-azure-storage
