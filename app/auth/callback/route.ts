import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function GET(request: Request) {
  const requestUrl = new URL(request.url)
  const code = requestUrl.searchParams.get('code')
  // if "next" is in param, use it as the redirect URL
  const next = requestUrl.searchParams.get('next') ?? '/'

  if (code) {
    const supabase = await createClient()
    const { error } = await supabase.auth.exchangeCodeForSession(code)

    if (!error) {
      const forwardedHost = request.headers.get('x-forwarded-host')
      const isLocalEnv = process.env.NODE_ENV === 'development'

      // Build a clean redirect URL with no query params
      let redirectUrl: URL

      if (isLocalEnv) {
        redirectUrl = new URL(next, requestUrl.origin)
      } else if (forwardedHost) {
        redirectUrl = new URL(next, `https://${forwardedHost}`)
      } else {
        redirectUrl = new URL(next, requestUrl.origin)
      }

      return NextResponse.redirect(redirectUrl)
    }
  }

  // return the user to an error page with instructions
  const errorUrl = new URL('/auth/auth-code-error', requestUrl.origin)
  return NextResponse.redirect(errorUrl)
}
