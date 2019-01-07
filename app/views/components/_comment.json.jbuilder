# frozen_string_literal: true
json.call(comment, :id, :body)
json.created_at comment.created_at.strftime('%d/%m/%Y')
json.commenter do
  if current_user == comment.commenter
    json.full_name I18n.t('activerecord.attributes.comment.you')
  else
    json.full_name comment.commenter.full_name
  end
  json.avatar_url comment.commenter.avatar.url
end
