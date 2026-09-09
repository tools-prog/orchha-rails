class RemoveContactAndAccessibilityFooterLinks < ActiveRecord::Migration[8.1]
  # The Contact Us and Accessibility Statement footer links never had pages
  # behind them and are being dropped. Contact details still show in the
  # footer's own "Contact Us:" block, so nothing is lost. Matched on the exact
  # seeded label+url pair so a relabelled/re-pointed admin link is left alone.
  DOOMED = [
    { "label" => "Contact Us",             "url" => "/contact" },
    { "label" => "Accessibility Statement", "url" => "/accessibility" }
  ].freeze

  def up
    block = ContentBlock.find_by(key: "homePage")
    return unless block && block.data.is_a?(Hash)

    data = block.data
    links = data.dig("footer", "links")
    return unless links.is_a?(Array)

    kept = links.reject do |link|
      link.is_a?(Hash) &&
        DOOMED.any? { |d| link["label"] == d["label"] && link["url"] == d["url"] }
    end
    return if kept.length == links.length

    data["footer"]["links"] = kept
    block.update!(data: data)
  end

  def down; end
end
