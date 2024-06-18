import { Role } from '@/util/types'
import { AlertBox } from './AlertBox'
import { CopyToClipboard } from './CopyToClipboard'

export interface ITellThemProps {
  uid: string
  role: Role
}

export const TellThem = ({ uid, role }: ITellThemProps) => {
  return (
    <AlertBox>
      <div className="max-w-sm">
        <div className="my-6 font-serif text-2xl font-semibold">Ошибка! 🤔</div>
        <div>
          Вы не являетесь {' '}
          <span className="font-bold">{role}</span> в нашей системе. 🤷
        </div>
        <div className="mt-6 mb-2">
          Вы должны связаться с администраторами.
        </div>
        <CopyToClipboard text={uid} />
      </div>
    </AlertBox>
  )
}
