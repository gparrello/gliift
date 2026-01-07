import { createGift } from '@/lib/api'
import { giftFormSchema } from '@/lib/schemas'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const createGroupGiftProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      giftFormValues: giftFormSchema,
      participantId: z.string().optional(),
    }),
  )
  .mutation(
    async ({ input: { groupId, giftFormValues, participantId } }) => {
      const gift = await createGift(
        giftFormValues,
        groupId,
        participantId,
      )
      return { giftId: gift.id }
    },
  )
