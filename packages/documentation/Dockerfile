FROM node:lts

# The dockerfile folder has to match the documentation folder name as
# Docusaurus uses the top folder (documentation) to find the docs foler
WORKDIR /documentation

EXPOSE 3000 35729
COPY . /documentation
RUN npm install

CMD ["npm", "start"]
