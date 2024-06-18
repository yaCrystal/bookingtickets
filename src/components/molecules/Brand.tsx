import Link from 'next/link'

import { cn } from '@/util/styles'

export interface IBrandProps {}

export const Brand = () => {
  return (
    <div>
      <Link
        href="/"
        className={cn(
          'hover:underline font-semibold font-serif text-2xl underline-offset-4 text-primary-500',
        )}
      >
        Booking Tickets
      </Link>
    </div>
  )
}
