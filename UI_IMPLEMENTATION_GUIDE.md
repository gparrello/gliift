# UI Implementation Quick Start

This guide helps you implement the gift voting interface using the existing expense UI as a template.

## Step 1: Create Gift List Page

**File**: `src/app/groups/[groupId]/gifts/page.tsx`

Copy from: `src/app/groups/[groupId]/expenses/page.tsx`

Key changes:
- Use `trpc.groups.gifts.list.useQuery()` instead of expenses
- Display gift status badge (PROPOSED/APPROVED/PURCHASED/REJECTED)
- Show vote counts (👍 X 👎 Y)
- Show recipient name instead of "paid by"
- Link to `/groups/[groupId]/gifts/[giftId]/edit`

## Step 2: Create Gift Form

**File**: `src/app/groups/[groupId]/gifts/gift-form.tsx`

Copy from: `src/app/groups/[groupId]/expenses/expense-form.tsx`

Key changes:
- Import `giftFormSchema` instead of `expenseFormSchema`
- Replace "Paid By" dropdown with "Recipient" dropdown
- Remove "Expense Date" field (gifts use createdAt)
- Remove "Reimbursement" checkbox
- Remove recurrence options
- Keep all splitting mode components (they work identically!)
- Add description textarea
- Display existing votes in view mode

## Step 3: Create Gift Create/Edit Pages

**Files**: 
- `src/app/groups/[groupId]/gifts/create/page.tsx`
- `src/app/groups/[groupId]/gifts/[giftId]/edit/page.tsx`

Copy from corresponding expense pages, use gift mutations:
- `trpc.groups.gifts.create.useMutation()`
- `trpc.groups.gifts.update.useMutation()`
- `trpc.groups.gifts.get.useQuery()` for edit page

## Step 4: Add Voting Component

**File**: `src/app/groups/[groupId]/gifts/vote-buttons.tsx`

```tsx
import { ThumbsUp, ThumbsDown, Minus } from 'lucide-react'
import { Button } from '@/components/ui/button'

interface VoteButtonsProps {
  giftId: string
  participantId: string
  currentVote?: 'UPVOTE' | 'DOWNVOTE' | 'ABSTAIN'
  onVote: (voteType: 'UPVOTE' | 'DOWNVOTE' | 'ABSTAIN') => void
}

export function VoteButtons({ currentVote, onVote }: VoteButtonsProps) {
  return (
    <div className="flex gap-2">
      <Button
        variant={currentVote === 'UPVOTE' ? 'default' : 'outline'}
        size="sm"
        onClick={() => onVote('UPVOTE')}
      >
        <ThumbsUp className="h-4 w-4" />
      </Button>
      <Button
        variant={currentVote === 'DOWNVOTE' ? 'default' : 'outline'}
        size="sm"
        onClick={() => onVote('DOWNVOTE')}
      >
        <ThumbsDown className="h-4 w-4" />
      </Button>
      <Button
        variant={currentVote === 'ABSTAIN' ? 'default' : 'outline'}
        size="sm"
        onClick={() => onVote('ABSTAIN')}
      >
        <Minus className="h-4 w-4" />
      </Button>
    </div>
  )
}
```

Use with: `trpc.groups.gifts.vote.useMutation()`

## Step 5: Update Group Navigation

**File**: `src/app/groups/[groupId]/group-tabs.tsx`

Add a "Gifts" tab:
```tsx
<Tab href={`/groups/${groupId}/gifts`}>
  {t('gifts')} {/* Add translation */}
</Tab>
```

## Step 6: Add Gift Status Badge Component

**File**: `src/components/gift-status-badge.tsx`

```tsx
import { Badge } from '@/components/ui/badge'
import { GiftStatus } from '@prisma/client'

const statusVariants = {
  PROPOSED: 'secondary',
  APPROVED: 'default',
  PURCHASED: 'success',
  REJECTED: 'destructive',
} as const

export function GiftStatusBadge({ status }: { status: GiftStatus }) {
  return (
    <Badge variant={statusVariants[status]}>
      {status}
    </Badge>
  )
}
```

## Step 7: Display Vote Summary

In gift list items, show vote counts:

```tsx
const upvotes = gift.votes.filter(v => v.vote === 'UPVOTE').length
const downvotes = gift.votes.filter(v => v.vote === 'DOWNVOTE').length

<div className="flex gap-2 text-sm">
  <span>👍 {upvotes}</span>
  <span>👎 {downvotes}</span>
</div>
```

## Splitting Modes - Already Work!

The gift form reuses ALL the expense splitting logic:

1. **EVENLY** - Default, equal split
2. **BY_SHARES** - 1:2:3 ratios
3. **BY_PERCENTAGE** - Explicit percentages per person
4. **BY_AMOUNT** - Specific dollar amounts

The UI components in `expense-form.tsx` handle all validation and display. Just replace `expense` with `gift` in variable names!

## tRPC Hooks Available

```tsx
// Queries
trpc.groups.gifts.list.useQuery({ groupId })
trpc.groups.gifts.get.useQuery({ groupId, giftId })

// Mutations
trpc.groups.gifts.create.useMutation()
trpc.groups.gifts.update.useMutation()
trpc.groups.gifts.delete.useMutation()
trpc.groups.gifts.vote.useMutation()
```

## Translation Keys to Add

Add to your i18n files:
- `gifts` - "Gifts"
- `createGift` - "Create Gift"
- `editGift` - "Edit Gift"
- `recipient` - "Recipient"
- `recipientRequired` - "Please select a recipient"
- `giftStatus` - "Status"
- `votes` - "Votes"
- `voteOnGift` - "Vote on this gift"

## Testing Checklist

- [ ] Create a gift with EVENLY split
- [ ] Create a gift with BY_SHARES split (test validation)
- [ ] Create a gift with BY_PERCENTAGE split (must sum to 100%)
- [ ] Create a gift with BY_AMOUNT split (must equal total)
- [ ] Vote on a gift (upvote/downvote/abstain)
- [ ] Change a vote
- [ ] Edit a gift
- [ ] Delete a gift
- [ ] View gifts list with all statuses
- [ ] Check activity log shows gift actions

## Optional Enhancements

1. **Filter gifts by status**: Add dropdown to filter PROPOSED/APPROVED/etc
2. **Sort by votes**: Order by most upvoted
3. **Hide gifts from recipient**: Don't show gifts where `recipientId === activeUser.id`
4. **Status workflow buttons**: Add "Approve" and "Mark as Purchased" buttons
5. **Gift cost per participant**: Show "You'll pay: $X" based on split mode
6. **Voting notifications**: Badge for unvoted gifts

## Component Structure

```
src/app/groups/[groupId]/gifts/
├── page.tsx              (list all gifts)
├── gift-form.tsx         (create/edit form)
├── vote-buttons.tsx      (voting UI)
├── gift-list-item.tsx    (individual gift in list)
├── create/
│   └── page.tsx          (create new gift)
└── [giftId]/
    └── edit/
        └── page.tsx      (edit existing gift)
```

Follow the same pattern as the expense pages for consistency!
