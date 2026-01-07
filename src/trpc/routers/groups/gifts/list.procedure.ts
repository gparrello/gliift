import { getGroupGifts } from '@/lib/api'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const listGroupGiftsProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
    }),
  )
  .query(async ({ input: { groupId } }) => {
    const gifts = await getGroupGifts(groupId)
    return gifts
  })
