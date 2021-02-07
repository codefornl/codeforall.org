# build environment
FROM jekyll/builder:3.8 as build
ENV extra_params --o:net.proto=IPv4
COPY . /builder
WORKDIR /builder
RUN jekyll build

# production environment
FROM nginx:1.18.0-alpine
COPY --from=build /builder/_site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]