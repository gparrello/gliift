-- AlterEnum: Update GiftStatus values
ALTER TYPE "GiftStatus" RENAME TO "GiftStatus_old";
CREATE TYPE "GiftStatus" AS ENUM ('PLANNING', 'BUYING', 'BOUGHT', 'COMPLETED');
ALTER TABLE "Gift" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Gift" ALTER COLUMN "status" TYPE "GiftStatus" USING "status"::text::"GiftStatus";
ALTER TABLE "Gift" ALTER COLUMN "status" SET DEFAULT 'PLANNING';
DROP TYPE "GiftStatus_old";

-- AlterEnum: Add new activity types
ALTER TYPE "ActivityType" ADD VALUE 'OPT_IN_GIFT';
ALTER TYPE "ActivityType" ADD VALUE 'OPT_OUT_GIFT';

-- AlterTable: Add isActive to Participant
ALTER TABLE "Participant" ADD COLUMN "isActive" BOOLEAN NOT NULL DEFAULT true;

-- AlterTable: Add isParticipating to GiftPaidFor
ALTER TABLE "GiftPaidFor" ADD COLUMN "isParticipating" BOOLEAN NOT NULL DEFAULT true;
