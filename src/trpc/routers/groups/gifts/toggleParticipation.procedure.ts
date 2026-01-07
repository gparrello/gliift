import { toggleGiftParticipation } from '@/lib/api'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const toggleGiftParticipationProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      giftId: z.string().min(1),
      participantId: z.string().min(1),
      isParticipating: z.boolean(),
    }),
  )
  .mutation(
    async ({ input: { groupId, giftId, participantId, isParticipating } }) => {
      await toggleGiftParticipation(groupId, giftId, participantId, isParticipating)
    },
  )
