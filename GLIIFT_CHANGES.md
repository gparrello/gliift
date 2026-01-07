# Gliift - Gift Planning & Voting System

## Overview

This application has been modified from a Spliit expense-splitting app into **Gliift**, a collaborative gift planning and voting system. Groups can propose gifts for recipients, vote on them, and split the costs using the same flexible splitting mechanisms originally designed for expenses.

## Key Changes

### Database Schema (Prisma)

Added new models to support gift planning and voting:

1. **Gift Model** - Similar to Expense but for gift proposals
   - `title`, `description`, `amount`, `category`
   - `recipient` - The person receiving the gift (a Participant)
   - `splitMode` - Inherits expense splitting modes (EVENLY, BY_SHARES, BY_PERCENTAGE, BY_AMOUNT)
   - `status` - Tracks gift state (PROPOSED, APPROVED, PURCHASED, REJECTED)
   - `paidFor` - Relations to track who contributes and how much
   - `votes` - Relations to Vote model
   - `documents` - Optional images/attachments
   - `notes` - Additional information

2. **Vote Model** - Allows participants to vote on gifts
   - Linked to Gift and Participant
   - `vote` - Type of vote (UPVOTE, DOWNVOTE, ABSTAIN)
   - Unique constraint per gift/participant pair

3. **GiftPaidFor Model** - Cost splitting (mirrors ExpensePaidFor)
   - Links Gift to Participants with their contribution shares
   - Uses same splitting logic as expenses

4. **GiftDocument Model** - Attachments for gifts

5. **Updated ActivityType enum** - Added:
   - CREATE_GIFT
   - UPDATE_GIFT
   - DELETE_GIFT
   - VOTE_GIFT

### API Layer (`src/lib/api.ts`)

Added complete CRUD operations for gifts:

- `createGift()` - Create new gift proposals
- `getGroupGifts()` - List all gifts for a group with votes
- `getGift()` - Get detailed gift information
- `updateGift()` - Update gift details
- `deleteGift()` - Remove a gift
- `voteOnGift()` - Add or update a vote on a gift

### Schemas (`src/lib/schemas.ts`)

- **giftFormSchema** - Validation for gift forms
  - Similar to expenseFormSchema but adapted for gifts
  - Includes recipient selection
  - Reuses cost-splitting validation logic
  - Type: `GiftFormValues`

### tRPC Routers (`src/trpc/routers/groups/gifts/`)

New gift procedures:
- `create.procedure.ts` - Create gift mutation
- `list.procedure.ts` - List gifts query
- `get.procedure.ts` - Get single gift query
- `update.procedure.ts` - Update gift mutation
- `delete.procedure.ts` - Delete gift mutation
- `vote.procedure.ts` - Vote on gift mutation

Integrated into groups router at `groups.gifts.*`

## Cost Splitting Capabilities

**All expense splitting modes are preserved and work for gifts:**

1. **EVENLY** - Split equally among participants
2. **BY_SHARES** - Split by proportional shares (e.g., 1:2:3 ratio)
3. **BY_PERCENTAGE** - Explicit percentage for each participant
4. **BY_AMOUNT** - Specific dollar amounts per participant

The same validation logic ensures:
- Percentages sum to 100%
- Amounts sum to total cost
- No zero or negative values

## Voting System

Participants can vote on proposed gifts:
- **UPVOTE** - Support for the gift idea
- **DOWNVOTE** - Against the gift idea
- **ABSTAIN** - Neutral/no opinion

Votes are tracked per participant and can be changed at any time.

## Next Steps for UI Implementation

### Priority Tasks

1. **Create Gift Pages** (similar to expense pages):
   - `/groups/[groupId]/gifts/page.tsx` - List gifts
   - `/groups/[groupId]/gifts/create/page.tsx` - New gift form
   - `/groups/[groupId]/gifts/[giftId]/edit/page.tsx` - Edit gift

2. **Gift Form Component** (`gift-form.tsx`):
   - Can be based on `expense-form.tsx`
   - Replace "Paid By" with "Recipient" selector
   - Keep all splitting mode components
   - Add voting UI for display

3. **Gift List Component**:
   - Display gifts with status badges
   - Show vote counts (upvotes/downvotes)
   - Filter by status or recipient

4. **Update Group Navigation**:
   - Add "Gifts" tab to group tabs
   - Update group header/layout

5. **Voting UI Components**:
   - Vote buttons (thumbs up/down/abstain)
   - Vote summary display
   - Participant vote indicators

### Optional Enhancements

- Gift status workflow (approve → purchased)
- Prevent recipients from seeing their own gifts
- Notifications for voting milestones
- Gift cost summaries per participant
- Export gift lists

## Backward Compatibility

- **Expenses are fully preserved** - All existing expense functionality remains
- Groups can use both gifts and expenses
- Activity logs track both types
- Same authentication and permissions model

## Technology Stack

- **Database**: PostgreSQL via Prisma ORM
- **Backend**: Next.js API routes with tRPC
- **Frontend**: React with Next.js 
- **Validation**: Zod schemas
- **Styling**: TailwindCSS + shadcn/UI

## Running the Application

See main README.md for setup instructions. The database schema needs migration:

```bash
npx prisma migrate dev
npx prisma generate
npm run dev
```

## Files Modified

- `prisma/schema.prisma` - Added Gift, Vote, GiftPaidFor, GiftDocument models
- `src/lib/schemas.ts` - Added giftFormSchema
- `src/lib/api.ts` - Added gift CRUD and voting functions
- `src/trpc/routers/groups/index.ts` - Registered gifts router
- `README.md` - Updated project description

## Files Created

- `src/trpc/routers/groups/gifts/` - Complete gift router implementation
  - `index.ts`, `create.procedure.ts`, `list.procedure.ts`
  - `get.procedure.ts`, `update.procedure.ts`, `delete.procedure.ts`
  - `vote.procedure.ts`
