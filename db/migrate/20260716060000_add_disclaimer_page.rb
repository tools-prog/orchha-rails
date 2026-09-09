class AddDisclaimerPage < ActiveRecord::Migration[8.1]
  # Footer links to /disclaimer; adds the client-supplied copy behind it.
  # Skips the slug if it already exists, so admin edits are never overwritten.
  BODY = <<~HTML.freeze
    <p>Sabhyata Foundation respects your privacy and recognizes the need to protect the personally identifiable information (any information by which you can be identified, such as name, address, and telephone number) you share with us. We would like to assure you that we follow appropriate standards when it comes to protecting your privacy on our web sites.</p>
  HTML

  def up
    return if Page.exists?(slug: "disclaimer")

    Page.create!(slug: "disclaimer", title: "Disclaimer & Credits",
                 body: BODY, published: true)
  end

  def down
    Page.where(slug: "disclaimer").destroy_all
  end
end
