import { Link } from '../molecules/CustomLink'

export const ManagerMenu = () => {
  return (
    <div className="flex flex-col w-full max-w-xs gap-2">
      <Link href="/manager/cinemas">Фильмы</Link>
      <Link className="pl-4" href="/manager/cinemas/new-showtime">
        Добавить сеанс
      </Link>
    </div>
  )
}
