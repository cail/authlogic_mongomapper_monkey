
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

      acts_as_authentic

    end
  end


end
