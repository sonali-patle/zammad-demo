// Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

import type { RequiredPermission } from '@shared/types/permission'
import { type Props as LinkProps } from './CommonSectionMenuLink.vue'

export interface MenuItem extends LinkProps {
  type: 'link'
  permission?: RequiredPermission
  onClick?(event: MouseEvent): void
}
