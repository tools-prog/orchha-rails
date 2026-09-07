class AddFooterLogosToHomePage < ActiveRecord::Migration[8.1]
  # Footer logos used to be hardcoded in the view. They're CMS-managed now
  # (Home → Page Content → footer → logos), so deployed homePage rows need
  # the key seeded — db:seed skips existing rows. Never overwrites an
  # admin-edited list.
  def up
    block = ContentBlock.find_by(key: "homePage")
    return unless block && block.data.is_a?(Hash)

    data = block.data
    footer = data["footer"]
    return unless footer.is_a?(Hash) && footer["logos"].blank?

    seed = JSON.parse(File.read(Rails.root.join("content.json")))
    logos = seed.dig("homePage", "footer", "logos")
    return if logos.blank?

    footer["logos"] = logos
    block.update!(data: data)
  end

  def down; end
end
