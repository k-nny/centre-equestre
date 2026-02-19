import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://sruaalaxmjdbaehjfrch.supabase.co'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNydWFhbGF4bWpkYmFlaGpmcmNoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE1MzcwMTUsImV4cCI6MjA4NzExMzAxNX0.b2OmZ-i5951egT2ZESwW-kAXYtQmLJwbQOtogwGRd6w'

export const APP_KEY = 'CLE_SECRETE_FRONTOFFICE'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)