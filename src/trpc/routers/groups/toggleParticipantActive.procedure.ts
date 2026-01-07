import { toggleParticipantActive } from '@/lib/api'
import { baseProcedure } from '@/trpc/init'
import { z } from 'zod'

export const toggleParticipantActiveProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      participantId: z.string().min(1),
      isActive: z.boolean(),
    }),
  )
  .mutation(async ({ input: { groupId, participantId, isActive } }) => {
    await toggleParticipantActive(groupId, participantId, isActive)
  })
