
module MongoMapper::Document::ClassMethods

  def acts_as_authentic

    class_eval do
      #
      # authorization stuff
      #

      include  Authlogic::ActsAsAuthentic::Base
      include  Authlogic::ActsAsAuthentic::Email
      include  Authlogic::ActsAsAuthentic::LoggedInStatus
      include  Authlogic::ActsAsAuthentic::Login
      include  Authlogic::ActsAsAuthentic::MagicColumns
      include  Authlogic::ActsAsAuthentic::Password
      include  Authlogic::ActsAsAuthentic::PerishableToken
      include  Authlogic::ActsAsAuthentic::PersistenceToken
      include  Authlogic::ActsAsAuthentic::RestfulAuthentication
      include  Authlogic::ActsAsAuthentic::SessionMaintenance
      include  Authlogic::ActsAsAuthentic::SingleAccessToken
      include  Authlogic::ActsAsAuthentic::ValidationsScope

      begin
        include  AuthlogicOpenid::ActsAsAuthentic
      rescue => e
      end
      
      acts_as_authentic

    end
  end


end


# Bad authlogic interface! patching!
module Authlogic::Session::UnauthorizedRecord
  def credentials=(value)
    super
    values = value.is_a?(Array) ? value : [value]
    if ![String, Symbol, Hash].find{|e| values.first.kind_of? e }
#     !values.first.kind_of? String and !values.first.kind_of? Symbol and !values.first.kind_of? Hash
      self.unauthorized_record = values.first
    end
  end
end
