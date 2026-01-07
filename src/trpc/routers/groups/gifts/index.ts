import { createTRPCRouter } from '@/trpc/init'
import { createGroupGiftProcedure } from '@/trpc/routers/groups/gifts/create.procedure'
import { deleteGroupGiftProcedure } from '@/trpc/routers/groups/gifts/delete.procedure'
import { getGroupGiftProcedure } from '@/trpc/routers/groups/gifts/get.procedure'
import { listGroupGiftsProcedure } from '@/trpc/routers/groups/gifts/list.procedure'
import { updateGroupGiftProcedure } from '@/trpc/routers/groups/gifts/update.procedure'
import { voteGroupGiftProcedure } from '@/trpc/routers/groups/gifts/vote.procedure'
import { toggleGiftParticipationProcedure } from '@/trpc/routers/groups/gifts/toggleParticipation.procedure'

export const groupGiftsRouter = createTRPCRouter({
  list: listGroupGiftsProcedure,
  get: getGroupGiftProcedure,
  create: createGroupGiftProcedure,
  update: updateGroupGiftProcedure,
  delete: deleteGroupGiftProcedure,
  vote: voteGroupGiftProcedure,
  toggleParticipation: toggleGiftParticipationProcedure,
})
