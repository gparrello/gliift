import { getGift } from '@/lib/api'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const getGroupGiftProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      giftId: z.string().min(1),
    }),
  )
  .query(async ({ input: { groupId, giftId } }) => {
    const gift = await getGift(groupId, giftId)
    return { gift }
  })
