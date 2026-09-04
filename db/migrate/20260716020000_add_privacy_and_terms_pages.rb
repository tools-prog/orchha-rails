class AddPrivacyAndTermsPages < ActiveRecord::Migration[8.1]
  # The footer has always linked to /privacy-policy and /terms, but no Page
  # record backed either slug, so both 404'd. Create them with the client's
  # supplied copy. Existing pages (i.e. admin edits) are never overwritten.
  PRIVACY_BODY = <<~HTML.freeze
    <p>At Sabhyata Foundation, we value and respect the privacy of our visitors. This Privacy Policy outlines how we collect, use, protect, and disclose your information when you interact with our website, <a href="https://www.sabhyatafoundation.com" target="_blank" rel="noopener">www.sabhyatafoundation.com</a>. By accessing or using our website, you consent to the terms of this Privacy Policy.</p>

    <h2>1. Information We Collect</h2>
    <p>We may collect two types of information when you visit our website:</p>
    <h3>Personal Information</h3>
    <p>When you choose to engage with us, for instance by subscribing to our newsletter, donating, or contacting us, we may collect personal information such as your name, email address, phone number, and mailing address.</p>
    <h3>Non-Personal Information</h3>
    <p>We automatically collect non-personal information, such as browser type, device type, IP address, and website usage data, to help us better understand how users interact with our site. This information is collected through cookies and analytics tools.</p>

    <h2>2. Use of Information</h2>
    <p>We use the information we collect to:</p>
    <ul>
      <li>Improve user experience on our website</li>
      <li>Respond to your inquiries and provide the services you request</li>
      <li>Send you newsletters, updates, or other communications, where you have subscribed</li>
      <li>Process donations and issue receipts</li>
      <li>Ensure the security of our website</li>
    </ul>
    <p>We do not sell, rent, or share your personal information with third parties without your consent, except as necessary to provide the services you have requested or as required by law.</p>

    <h2>3. Cookies</h2>
    <p>Our website uses cookies to enhance your experience. Cookies are small files that are placed on your device by your browser. These files help us remember your preferences and analyze site traffic. You can disable cookies in your browser settings, though this may affect your ability to use certain features of our site.</p>

    <h2>4. Data Security</h2>
    <p>We are committed to ensuring the security of your personal information. We take reasonable measures to protect your information from unauthorized access, disclosure, alteration, or destruction. However, no data transmission over the internet can be guaranteed as completely secure.</p>

    <h2>5. Third-Party Links</h2>
    <p>Our website may contain links to third-party websites. Sabhyata Foundation is not responsible for the privacy practices or content of these external sites. We encourage you to review their privacy policies before providing any personal information.</p>

    <h2>6. Your Rights</h2>
    <p>You have the right to access, correct, or delete your personal information. You may also opt out of receiving our communications at any time by clicking the unsubscribe link in our emails or by contacting us directly.</p>

    <h2>7. Changes to This Policy</h2>
    <p>We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. Any updates will be posted on this page, and we encourage you to review it periodically.</p>

    <h2>8. Contact Us</h2>
    <p>If you have any questions about this Privacy Policy or how we handle your information, please contact us at:</p>
    <p><strong>Sabhyata Foundation</strong><br>
    <a href="mailto:contact@orchha.com">contact@orchha.com</a></p>
  HTML

  TERMS_BODY = <<~HTML.freeze
    <p>Welcome to the Sabhyata Foundation website (<a href="https://www.sabhyatafoundation.com" target="_blank" rel="noopener">www.sabhyatafoundation.com</a>). By accessing or using our website, you agree to comply with the following terms and conditions. Please read these carefully, as they govern your use of our website and the services we provide. If you do not agree with these terms, you should refrain from using our website.</p>

    <h2>1. Acceptance of Terms</h2>
    <p>By accessing this website, you confirm that you have read, understood, and agree to be bound by these terms and conditions, as well as our <a href="/privacy-policy">Privacy Policy</a>. These terms apply to all visitors, users, and others who access or use the website.</p>

    <h2>2. Changes to Terms</h2>
    <p>Sabhyata Foundation reserves the right to update or modify these Terms &amp; Conditions at any time without prior notice. Any changes will be effective immediately upon posting. It is your responsibility to review these terms periodically. Your continued use of the website after any modifications signifies your acceptance of the updated terms.</p>

    <h2>3. Use of Website</h2>
    <p>You agree to use the website for lawful purposes only. You are prohibited from using this website to:</p>
    <ul>
      <li>Violate any local, state, national, or international law or regulation.</li>
      <li>Post, transmit, or distribute any harmful, disruptive, or offensive content, including viruses or malicious software.</li>
      <li>Attempt to interfere with the proper functioning of the website.</li>
      <li>Misuse any information from the website or use it for unauthorized commercial purposes.</li>
    </ul>
    <p>Sabhyata Foundation reserves the right to terminate or restrict your access to the website if you violate these terms.</p>

    <h2>4. Intellectual Property</h2>
    <p>All content on this website, including but not limited to text, images, logos, graphics, and multimedia, is the property of Sabhyata Foundation or its licensors and is protected by intellectual property laws. Unauthorized use of any content from the website is prohibited unless explicitly permitted by Sabhyata Foundation. You may not reproduce, distribute, or create derivative works from the content without prior written consent.</p>

    <h2>5. Donations and Payments</h2>
    <p>If you choose to donate or make payments through our website, you agree to provide accurate and complete information. All donations are voluntary and non-refundable, unless otherwise stated. Sabhyata Foundation does not warrant or guarantee that your donations will result in any specific outcomes or uses unless explicitly mentioned in the donation campaign.</p>

    <h2>6. Third-Party Links</h2>
    <p>Our website may contain links to third-party websites that are not controlled or operated by Sabhyata Foundation. These links are provided for your convenience, and Sabhyata Foundation is not responsible for the content, accuracy, or privacy practices of those websites. Your interaction with third-party websites is at your own risk, and you should review their terms and conditions before engaging with them.</p>

    <h2>7. Disclaimer of Warranties</h2>
    <p>While we strive to ensure that the information provided on our website is accurate and up-to-date, Sabhyata Foundation makes no warranties or representations regarding the accuracy, reliability, or completeness of the content. Your use of the website is at your own risk. The website and all content are provided &ldquo;as is&rdquo; and &ldquo;as available&rdquo; without any warranties of any kind, either express or implied.</p>

    <h2>8. Limitation of Liability</h2>
    <p>To the fullest extent permitted by law, Sabhyata Foundation shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising from your use of the website, including any errors, omissions, or interruptions in service. This includes damages to your computer or device from downloading content from the website.</p>

    <h2>9. Governing Law</h2>
    <p>These terms and conditions are governed by and construed in accordance with the laws of India. Any disputes arising from the use of this website shall be subject to the exclusive jurisdiction of the courts of [Insert City/State], India.</p>

    <h2>10. Contact Information</h2>
    <p>If you have any questions or concerns about these Terms &amp; Conditions, please <a href="https://sabhyatafoundation.com/contact-us/" target="_blank" rel="noopener">contact us</a>.</p>
  HTML

  def up
    create_page("privacy-policy", "Privacy Policy", PRIVACY_BODY)
    # Title matches the footer link wording ("and" would render as "And"
    # under the page title's capitalize styling).
    create_page("terms", "Terms & Conditions", TERMS_BODY)
  end

  def down
    Page.where(slug: %w[privacy-policy terms]).destroy_all
  end

  private

  def create_page(slug, title, body)
    return if Page.exists?(slug: slug)

    Page.create!(slug: slug, title: title, body: body, published: true)
  end
end
