import { voteOnGift } from '@/lib/api'
import { baseProcedure } from '@/trpc/init'
import { VoteType } from '@prisma/client'
import { z } from 'zod'

export const voteGroupGiftProcedure = baseProcedure
  .input(
    z.object({
      groupId: z.string().min(1),
      giftId: z.string().min(1),
      participantId: z.string().min(1),
      voteType: z.enum<VoteType, [VoteType, ...VoteType[]]>(
        Object.values(VoteType) as any,
      ),
    }),
  )
  .mutation(async ({ input: { groupId, giftId, participantId, voteType } }) => {
    await voteOnGift(groupId, giftId, participantId, voteType)
  })
