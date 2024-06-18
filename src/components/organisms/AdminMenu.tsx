import { Link } from '../molecules/CustomLink'

export const AdminMenu = () => {
  return (
    <div className="flex flex-col w-full max-w-xs gap-2">
      <Link href="/admin/cinemas">Кинотеатры</Link>
      <Link className="pl-4" href="/admin/cinemas/new">
        Добавить кинотеатр
      </Link>
      <Link href="/admin/movies">Фильмы</Link>
      <Link className="pl-4" href="/admin/movies/new">
        Добавить фильм
      </Link>
      <Link href="/admin/admins">Управление администраторами</Link>
      <Link href="/admin/managers">Управление менеджерами</Link>
    </div>
  )
}
