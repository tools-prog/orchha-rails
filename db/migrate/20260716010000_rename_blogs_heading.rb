class RenameBlogsHeading < ActiveRecord::Migration[8.1]
  # The blogs page heading shipped as "Orchha Blogs"; the client wants just
  # "Blogs". Only the untouched seed value is rewritten.
  def up
    block = ContentBlock.find_by(key: "blogsPage")
    return unless block && block.data.is_a?(Hash) && block.data["heading"] == "Orchha Blogs"

    block.update!(data: block.data.merge("heading" => "Blogs"))
  end

  def down; end
end
