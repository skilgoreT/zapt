require_relative '../lib/zapt'

package do
  names %w{memcached nginx}
end

gem do
  names %w{popen4 json}
end

system do
  commands ['ls -ltr', 'echo yoda']
end
