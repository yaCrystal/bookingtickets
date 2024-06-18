'use client'
import { Loading } from '@/components/molecules/Loading'
import { trpcClient } from '@/trpc/clients/client'
import { useHandleSearch } from '@/util/hooks'
import { CinemaSelectCard } from './CinemaSelectCard'

export const SelectMovie = ({ cinemaId }: { cinemaId: number }) => {
  const { data, isLoading } = trpcClient.movies.moviesPerCinema.useQuery({
    cinemaId,
  })

  const { params, addParam, deleteParam } = useHandleSearch()

  if (data?.length === 0) {
    return <div>В данный момент в этом кинотеатре нет сеансов.</div>
  }

  return (
    <div>
      <div>Выберите фильм</div>
      {isLoading ? <Loading /> : null}

      <div className="grid grid-cols-3 gap-2">
        {data?.map((movie) => (
          <button
            key={movie.id}
            onClick={() => {
              deleteParam('showtimeId')
              deleteParam('screenId')
              addParam('movieId', movie.id)
            }}
          >
            <CinemaSelectCard
              movie={movie}
              selected={params.get('movieId') === movie.id.toString()}
            />
          </button>
        ))}
      </div>
    </div>
  )
}
