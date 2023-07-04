import jwt from 'jsonwebtoken'
import sgMail from '@sendgrid/mail'

function generateInvitationLink(companyUrl: string): string {
  const payload = {
    companyUrl,
  }

  const options = {
    expiresIn: process.env.JWT_LIFETIME,
  }

  const token = jwt.sign(payload, process.env.JWT_SECRET, options)

  const invitationLink = `${companyUrl}/invitations/${token}`
  return invitationLink
}

sgMail.setApiKey(process.env.SENDGRID_API_KEY)

// Send the invitation email
function sendInvitationEmail(email: string, invitationLink: string): void {
  const msg = {
    to: email,
    from: 'your-email@example.com',
    subject: 'Invitation to join our company',
    text: `You have been invited to join our company. Please click the following link to accept the invitation and access our platform: ${invitationLink}`,
    html: `<p>You have been invited to join our company. Please click the following link to accept the invitation and access our platform:</p><a href="${invitationLink}">${invitationLink}</a>`,
  }

  sgMail
    .send(msg)
    .then(() => {
      console.log('Email sent')
    })
    .catch((error: Error) => {
      console.error('Error sending email:', error)
    })
}

// Usage example
const companyUrl = 'https://example.com' // need to change later
const invitationLink = generateInvitationLink(companyUrl)

const email = 'recipient@example.com' // need to change later
sendInvitationEmail(email, invitationLink)
