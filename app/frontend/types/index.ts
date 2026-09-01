export interface Auth {
  user: User | null
  session: Pick<Session, "id"> | null
}

export interface FlashData {
  alert?: string
  notice?: string
}

export interface SharedProps {
  auth: Auth
}

export interface User {
  id: number
  name: string
  email: string
  bio: string
  avatar_url: string
  background_url: string
  verified: boolean
  created_at: string
  updated_at: string
}

export interface Session {
  id: number
  user_agent: string
  ip_address: string
  created_at: string
}

export interface ProfileData {
  name: string
  bio: string | null
  private_email: boolean
  avatar_url: string
  background_url: string
}
