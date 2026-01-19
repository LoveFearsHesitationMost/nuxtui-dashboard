export interface Auth {
  user: User
  session: Pick<Session, "id">
}


export interface FlashData {
  alert?: string
  notice?: string
}

export type SharedProps = {
  auth: Auth
}

export interface User {
  id: number
  name: string
  email: string
  avatar?: string
  verified: boolean
  created_at: string
  updated_at: string
}

export interface Session {
  id: string
  user_agent: string
  ip_address: string
  created_at: string
}
