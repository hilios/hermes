Fabricator(:user) do
  sequence(:name) { |n| "User #{n}" }
  email           { "#{name.underscore.gsub(/\s/, '_')}@host.com" }
  password        "abc123"
  role            :webmaster
end

Fabricator(:admin,        :from => :user) { role :admin }
Fabricator(:webmaster,    :from => :user) { role :webmaster }
Fabricator(:webdesigner,  :from => :user) { role :webdesigner }
Fabricator(:copywriter,   :from => :user) { role :copywriter }
