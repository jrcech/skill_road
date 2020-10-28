# frozen_string_literal: true

crumb :root do
  link t('controller.dashboard'), admin_root_path
end

crumb :items do
  link(
    tooltip(
      t("models.#{model_plural_symbol}.more"),
      model_icon(model_plural_symbol)
    ),
    path_for(:index)
  )
end

crumb :item do |item|
  link item.title, path_for(:show)
  parent :items
end

crumb :new do
  link t('actions.new', item: model_singular), path_for(:new)
  parent :items
end

crumb :edit do |item|
  link t('actions.edit'), path_for(:edit)
  parent :item, item
end
