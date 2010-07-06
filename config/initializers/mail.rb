ActionMailer::Base.delivery_method=:smtp
ActionMailer::Base.smtp_settings={
:address=>"smtp.sef-chiapas.gob.mx",
:port=>25,
:domain=>"sef-chiapas.gob.mx"
}