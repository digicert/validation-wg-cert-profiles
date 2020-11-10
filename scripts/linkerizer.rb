#!/usr/bin/env ruby

def filter_for_rfc(content)
    r = /RFC+\s(?<rfcnum>\d+),\s+(?<secprefix>(Appendix|Section))\s+(?<secnum>((\d|\w)+\.?){1,4})/
    content.gsub(r) {|m| "[#{$&}](https://tools.ietf.org/html/rfc#{$1}##{$2.downcase}-#{$3})"}
end

content = ARGF.read

printf filter_for_rfc(content)
