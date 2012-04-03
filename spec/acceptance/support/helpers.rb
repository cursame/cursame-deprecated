module NavigationHelpers
  def sign_in_with user, opts = {}
    user.confirm!

    if opts[:subdomain]
      visit new_user_session_url(:subdomain => opts[:subdomain])
    else
      visit new_user_session_path
    end

    within '#user_new' do
      fill_in 'user[email]',    :with => user.email
      fill_in 'user[password]', :with => opts[:password] || 'password'
      click_button I18n.t('forms.sign_in_btn')
    end
  end

  def sign_out opts = {}
    if opts[:subdomain]
      visit root_url(:subdomain => opts[:subdomain])
    else
      visit root_path
    end
    click_link 'Logout'
  end
end

module HelperMethods
  include NavigationHelpers
  include I18n

  def t *args
    I18n.t *args
  end
  
  def month_number_to_name(month)
    case month
      when 1 then return "enero"
      when 2 then return "febrero"
      when 3 then return "marzo"
      when 4 then return "abril"
      when 5 then return "mayo"
      when 6 then return "junio"
      when 7 then return "julio"
      when 8 then return "agosto"
      when 9 then return "septiembre"
      when 10 then return "octubre"
      when 11 then return "noviembre"
      when 12 then return "diciembre"
    end
  end

  def add_question_with_answers text, opts = {}
    click_link t('surveys.question_fields.add_question')

    within 'fieldset.question:last' do
      fill_in Question.human_attribute_name(:text), :with => text
      fill_in Question.human_attribute_name(:value), :with => 2
      %w(A B C None).each do |answer|
        click_link t('surveys.answer_fields.add_answer')
        within 'fieldset.answer:last' do
          fill_in Answer.human_attribute_name(:text), :with => answer
          # find("input[type='radio']").set(true)
        end
      end
    end
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
