require 'digest/md5'
erics_hash = "b354e9b8c7a5fb1e073670a28f957032"

("a".."z").each do |first|
  ("a".."z").each do |second|
    ("a".."z").each do |third|
      ("a".."z").each do |fourth|
        ("a".."z").each do |fifth|
          ("a".."z").each do |sixth|
            test = "#{first}#{second}#{third}#{fourth}#{fifth}#{sixth}"
            hashed = Digest::MD5.hexdigest(test)
            puts test if hashed == erics_hash
          end
        end
      end
    end
  end
end
