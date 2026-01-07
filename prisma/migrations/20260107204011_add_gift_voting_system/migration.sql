-- CreateEnum
CREATE TYPE "GiftStatus" AS ENUM ('PROPOSED', 'APPROVED', 'PURCHASED', 'REJECTED');

-- CreateEnum
CREATE TYPE "VoteType" AS ENUM ('UPVOTE', 'DOWNVOTE', 'ABSTAIN');

-- AlterEnum
ALTER TYPE "ActivityType" ADD VALUE 'CREATE_GIFT';
ALTER TYPE "ActivityType" ADD VALUE 'UPDATE_GIFT';
ALTER TYPE "ActivityType" ADD VALUE 'DELETE_GIFT';
ALTER TYPE "ActivityType" ADD VALUE 'VOTE_GIFT';

-- CreateTable
CREATE TABLE "Gift" (
    "id" TEXT NOT NULL,
    "groupId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "categoryId" INTEGER NOT NULL DEFAULT 0,
    "amount" INTEGER NOT NULL,
    "recipientId" TEXT NOT NULL,
    "splitMode" "SplitMode" NOT NULL DEFAULT 'EVENLY',
    "status" "GiftStatus" NOT NULL DEFAULT 'PROPOSED',
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Gift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GiftDocument" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "width" INTEGER NOT NULL,
    "height" INTEGER NOT NULL,
    "giftId" TEXT,

    CONSTRAINT "GiftDocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GiftPaidFor" (
    "giftId" TEXT NOT NULL,
    "participantId" TEXT NOT NULL,
    "shares" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "GiftPaidFor_pkey" PRIMARY KEY ("giftId","participantId")
);

-- CreateTable
CREATE TABLE "Vote" (
    "id" TEXT NOT NULL,
    "giftId" TEXT NOT NULL,
    "participantId" TEXT NOT NULL,
    "vote" "VoteType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Vote_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Gift_groupId_idx" ON "Gift"("groupId");

-- CreateIndex
CREATE INDEX "Gift_recipientId_idx" ON "Gift"("recipientId");

-- CreateIndex
CREATE INDEX "Vote_giftId_idx" ON "Vote"("giftId");

-- CreateIndex
CREATE UNIQUE INDEX "Vote_giftId_participantId_key" ON "Vote"("giftId", "participantId");

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Gift" ADD CONSTRAINT "Gift_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "Participant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GiftDocument" ADD CONSTRAINT "GiftDocument_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GiftPaidFor" ADD CONSTRAINT "GiftPaidFor_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GiftPaidFor" ADD CONSTRAINT "GiftPaidFor_participantId_fkey" FOREIGN KEY ("participantId") REFERENCES "Participant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vote" ADD CONSTRAINT "Vote_participantId_fkey" FOREIGN KEY ("participantId") REFERENCES "Participant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
