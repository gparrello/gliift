import { deleteGift } from '@/lib/api'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const deleteGroupGiftProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      giftId: z.string().min(1),
      participantId: z.string().optional(),
    }),
  )
  .mutation(async ({ input: { groupId, giftId, participantId } }) => {
    await deleteGift(groupId, giftId, participantId)
  })
