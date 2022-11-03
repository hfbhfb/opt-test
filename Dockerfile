FROM busybox:uclibc
WORKDIR /
COPY mygoapp /
CMD ["/mygoapp"]
