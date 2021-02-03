require 'spec_helper'
RSpec.describe Haml2Erb do
  let(:haml) do
    %q{
!!!
= content_for :horizontal_status do
  = render  partial: 'insured/families/horizontal_status.html.erb', locals: {step: 1} if show_component(request.path)
.container
  .row
    .col-lg-2.col-md-2.col-sm-2.col-xs-12
      = render  partial: 'shared/left_nav'
    .col-lg-10.col-md-10.col-sm-10.col-xs-12.row
      .col-lg-9.col-md-9.col-sm-9.col-xs-12
        %h2=l10n("verify_identity")
        %h4=l10n(".answer_the_following_questions_when_you_finish")
        = form_for(@interactive_verification, :as => :interactive_verification, :url => insured_interactive_identity_verifications_path, :method => :post) do |f|
          = f.hidden_field :session_id
          = f.hidden_field :transaction_id
          = f.fields_for :questions do |qf|
            = qf.hidden_field :question_id
            = qf.hidden_field :question_text
            = qf.fields_for :responses do |qr|
              = qr.hidden_field :response_id
              = qr.hidden_field :response_text
            .form-group
              %p= qf.object.question_text
              - qf.object.responses.each do |r|
                .row.row-form-wrapper.no-buffer
                  .radio.skinned-form-controls.skinned-form-controls-mac{ :style => "height: auto;" }
                    = qf.radio_button :response_id, r.response_id, class: 'required floatlabel'
                    = qf.label "response_id_#{r.response_id.downcase}" do
                      %span= ""
                      = r.response_text
              %br
          %br
          = f.submit l10n("submit"), class: 'btn btn-lg btn-primary ' + pundit_class(Family, :updateable?)
      .col-lg-3.col-md-3.col-sm-3.col-xs-12
        = render  partial: 'shared/individual_progress', locals: {step: '2'}

}
  end
  let(:erb) do
    "<!DOCTYPE html>\n<%= content_for :horizontal_status do %>\n  <%= render  partial: 'insured/families/horizontal_status.html.erb', locals: {step: 1} if show_component(request.path) %>\n<% end %>\n\n<div class='container'>\n  <div class='row'>\n    <div class='col-lg-2 col-md-2 col-sm-2 col-xs-12'>\n      <%= render  partial: 'shared/left_nav' %>\n    </div>\n    <div class='col-lg-10 col-md-10 col-sm-10 col-xs-12 row'>\n      <div class='col-lg-9 col-md-9 col-sm-9 col-xs-12'>\n        <h2><%= l10n(\"verify_identity\") %></h2>\n        <h4><%= l10n(\".answer_the_following_questions_when_you_finish\") %></h4>\n        <%= form_for(@interactive_verification, :as => :interactive_verification, :url => insured_interactive_identity_verifications_path, :method => :post) do |f| %>\n          <%= f.hidden_field :session_id %>\n          <%= f.hidden_field :transaction_id %>\n          <%= f.fields_for :questions do |qf| %>\n            <%= qf.hidden_field :question_id %>\n            <%= qf.hidden_field :question_text %>\n            <%= qf.fields_for :responses do |qr| %>\n              <%= qr.hidden_field :response_id %>\n              <%= qr.hidden_field :response_text %>\n            <% end %>\n\n            <div class='form-group'>\n              <p><%= qf.object.question_text %></p>\n              <% qf.object.responses.each do |r| %>\n                <div class='row row-form-wrapper no-buffer'>\n                  <div class='radio skinned-form-controls skinned-form-controls-mac' style='height: auto;'>\n                    <%= qf.radio_button :response_id, r.response_id, class: 'required floatlabel' %>\n                    <%= qf.label \"response_id_\#{r.response_id.downcase}\" do %>\n                      <span><%= \"\" %></span>\n                      <%= r.response_text %>\n                    <% end %>\n\n                  </div>\n                </div>\n              <% end %>\n              <br>\n            </div>\n          <% end %>\n\n          <br>\n          <%= f.submit l10n(\"submit\"), class: 'btn btn-lg btn-primary ' + pundit_class(Family, :updateable?) %>\n        <% end %>\n\n      </div>\n      <div class='col-lg-3 col-md-3 col-sm-3 col-xs-12'>\n        <%= render  partial: 'shared/individual_progress', locals: {step: '2'} %>\n      </div>\n    </div>\n  </div>\n</div>\n"
  end

  describe 'haml2erb' do
    it 'converts to ERB' do
      Haml2Erb.convert(haml).should eq(erb)
    end
  end
end
