'use client'

import { useFormCreateMovie } from '@/forms/createMovie'
import { trpcClient } from '@/trpc/clients/client'
import { useToast } from '../molecules/Toaster/use-toast'
import { Label } from '../atoms/label'
import { Input } from '../atoms/input'
import { Genre } from '@prisma/client'
import { HtmlSelect } from '../atoms/select'
import { Button } from '../atoms/button'
import { useRouter } from 'next/navigation'
import { revalidatePath } from '@/util/actions/revalidatePath'
import { ImagePreview } from '../molecules/ImagePreview'
import { useImageUpload } from '@/util/hooks/index'
import { Controller } from 'react-hook-form'
import { ProgressBar } from '../molecules/ProgressBar'

export interface ICreateMovieProps {}

export const CreateMovie = ({}: ICreateMovieProps) => {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
    watch,
    resetField,
    control,
  } = useFormCreateMovie()

  const { isLoading, mutateAsync: createMovie } =
    trpcClient.movies.createMovie.useMutation()
  const { posterUrl } = watch()

  const { toast } = useToast()
  const { replace } = useRouter()

  const [{ percent, uploading }, uploadImages] = useImageUpload()

  return (
    <div>
      <form
        onSubmit={handleSubmit(
          async ({ director, duration, genre, releaseDate, title }) => {
            const uploadedImages = await uploadImages(posterUrl)

            await createMovie({
              director,
              duration,
              genre,
              releaseDate,
              title,
              posterUrl: uploadedImages[0],
            })
            reset()
            toast({ title: 'Movie created successfully.' })
            revalidatePath('admins/movies')
            replace('/admin/movies')
          },
        )}
      >
        <div className="grid grid-cols-2 gap-2">
          <div>
            <Label title="Название" error={errors.title?.message}>
              <Input placeholder="Название" {...register('title')} />
            </Label>
            <Label title="Режиссер" error={errors.director?.message}>
              <Input placeholder="Режиссер" {...register('director')} />
            </Label>
            <Label title="Длительность" error={errors.duration?.message}>
              <Input
                placeholder="Длительность"
                {...register('duration', { valueAsNumber: true })}
              />
            </Label>
            <Label title="Дата выхода в прокат" error={errors.releaseDate?.message}>
              <Input
                placeholder="Дата выхода в прокат"
                type="date"
                {...register('releaseDate', {
                  setValueAs: (value) => {
                    const date = new Date(value)
                    return isNaN(date.getTime()) ? '' : date.toISOString()
                  },
                })}
              />
            </Label>
            <Label title="Жанр" error={errors.genre?.message}>
              <HtmlSelect placeholder="projection type" {...register(`genre`)}>
                {Object.values(Genre).map((type) => (
                  <option key={type} value={type}>
                    {type}
                  </option>
                ))}
              </HtmlSelect>
            </Label>
          </div>
          <Label title="Картинки" error={errors.posterUrl?.message?.toString()}>
            <ImagePreview
              src={posterUrl || ''}
              clearImage={() => resetField('posterUrl')}
            >
              <Controller
                control={control}
                name={`posterUrl`}
                render={({ field }) => (
                  <Input
                    type="file"
                    accept="image/*"
                    multiple={false}
                    onChange={(e) => field.onChange(e?.target?.files)}
                  />
                )}
              />
            </ImagePreview>

            {percent > 0 ? <ProgressBar value={percent} /> : null}
          </Label>
        </div>
        <Button loading={isLoading || uploading} type="submit">
          Подтвердить
        </Button>
      </form>
    </div>
  )
}
