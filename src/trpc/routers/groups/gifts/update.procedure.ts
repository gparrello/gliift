import { updateGift } from '@/lib/api'
import { giftFormSchema } from '@/lib/schemas'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const updateGroupGiftProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      giftId: z.string().min(1),
      giftFormValues: giftFormSchema,
      participantId: z.string().optional(),
    }),
  )
  .mutation(
    async ({ input: { groupId, giftId, giftFormValues, participantId } }) => {
      await updateGift(giftId, giftFormValues, groupId, participantId)
      return { giftId }
    },
  )
