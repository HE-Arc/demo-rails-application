ActiveAdmin.register Product do

  permit_params do
   permitted = [:title,
                :description,
                :price,
                :image,
                size_ids: []]
  end

  form do |f|
    f.semantic_errors
    f.inputs "Description" do
      f.input :title
      f.input :description
      f.input :price
      f.input :sizes, as: :check_boxes
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end
    f.inputs "Illustration", multipart: true do
      f.input :image, required: false,
                      as: :file,
                      hint: image_tag(f.object.image.url(:thumb))
    end
    f.actions
  end

  show do |f|
    attributes_table do
      row :title
      row :description
      row :thumbnail do
        image_tag(f.image.url(:thumb))
      end
      row :sizes do |product|
        product.sizes.each do |size|
          a size.name, href: admin_size_url(size)
          text_node "&nbsp;".html_safe
        end
        nil  # .each leaks
      end
    end
    active_admin_comments
  end

end
