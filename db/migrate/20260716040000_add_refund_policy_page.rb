class AddRefundPolicyPage < ActiveRecord::Migration[8.1]
  # Footer links to /refund-policy; adds the client-supplied copy behind it.
  # Skips the slug if it already exists, so admin edits are never overwritten.
  BODY = <<~HTML.freeze
    <p>This Refund &amp; Cancellation Policy governs the purchase of tickets and registrations for events, shows, cultural and other heritage experiences operated by Sabhyata Foundation pursuant to its engagement by the Madhya Pradesh Tourism Board (&ldquo;MPTB&rdquo;).</p>

    <h2>1. General Policy</h2>
    <p>All event bookings, registrations, and ticket purchases made through the website or its authorized ticketing partners are final.</p>
    <p>Tickets once booked are non-refundable, non-cancellable, and non-transferable, except as expressly provided in this Policy.</p>

    <h2>2. Customer-Initiated Cancellation</h2>
    <p>No refund shall be provided if a participant:</p>
    <ul>
      <li>Chooses not to attend the event;</li>
      <li>Misses the event for any reason;</li>
      <li>Arrives late and is denied entry in accordance with the event rules and venue regulations;</li>
      <li>Is unable to attend due to personal, travel, medical, or scheduling reasons.</li>
    </ul>
    <p>Requests for transfer of bookings, rescheduling of attendance, change of participant details, or exchange of tickets shall not be permitted.</p>

    <h2>3. Event Cancellation by Organizer</h2>
    <p>In the event that an event is cancelled by the organizers, or the concerned authorities, ticket holders shall be entitled to a 100% refund of the ticket amount paid.</p>
    <p>The refund shall be processed to the original mode of payment used at the time of booking.</p>
    <p>No refund shall be payable for any ancillary expenses incurred by the participant, including but not limited to travel, accommodation, convenience fees charged by third-party providers, or any other incidental costs, unless otherwise required by applicable law.</p>

    <h2>4. Refund Processing Timeline</h2>
    <p>Eligible refunds will be initiated within seven (7) working days from the date of cancellation of the event.</p>
    <p>The actual time taken for the refund to be credited to the customer&rsquo;s account may vary depending on the payment gateway, bank, card issuer, or financial institution involved. The event organizer shall not be responsible for delays attributable to such third parties.</p>

    <h2>5. Event Modifications and Rescheduling</h2>
    <p>The organizer reserves the right to modify, postpone, reschedule, relocate, or make reasonable changes to any event, including but not limited to changes in timings, route, guide, venue, format, or other operational aspects.</p>
    <p>In the event of rescheduling, tickets shall remain valid for the revised date unless otherwise communicated to the customer.</p>

    <h2>6. Force Majeure</h2>
    <p>The organizer reserves the right to cancel, postpone, reschedule, modify, or suspend any event due to circumstances beyond its reasonable control, including but not limited to acts of government, court orders, public safety requirements, natural disasters, adverse weather conditions, strikes, civil disturbances, epidemics, pandemics, technical failures, or venue restrictions.</p>
    <p>Where an event is cancelled and not rescheduled, refunds shall be governed by Clause 3 of this Policy.</p>

    <h2>7. Contact for Refund Queries</h2>
    <p>For any queries regarding refunds or cancellations, please contact:</p>
    <p>Email: <a href="mailto:contact@orchha.com">contact@orchha.com</a></p>

    <p>By purchasing a ticket or registering for an event, the participant acknowledges that they have read, understood, and agree to be bound by this Refund &amp; Cancellation Policy.</p>
  HTML

  def up
    return if Page.exists?(slug: "refund-policy")

    Page.create!(slug: "refund-policy", title: "Refund & Cancellation Policy",
                 body: BODY, published: true)
  end

  def down
    Page.where(slug: "refund-policy").destroy_all
  end
end
