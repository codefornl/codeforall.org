# build environment
FROM starefossen/github-pages:onbuild as build
COPY . /builder
WORKDIR /builder
RUN jekyll build

# production environment
FROM nginx:1.18.0-alpine
COPY --from=build /builder/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]