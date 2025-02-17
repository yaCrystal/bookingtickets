import 'server-only'

import { createTRPCContext } from '../server'
import { cache } from 'react'
import { headers } from 'next/headers'
import { observable } from '@trpc/server/observable'
import { type TRPCErrorResponse } from '@trpc/server/rpc'
import { callProcedure } from '@trpc/server'

import { createTRPCProxyClient, TRPCClientError } from '@trpc/client'
import { appRouter, AppRouter } from '../server/routers'

const createContext = cache(() => {
    const heads = new Headers(headers())
    heads.set('x-trpc-source', 'rsc')
  
    return createTRPCContext({
      headers: heads,
    })
  })

export const trpcServer = createTRPCProxyClient<AppRouter>({
  links: [
    () =>
      ({ op: { path, type, input } }) =>
        observable((observer) => {
          createContext()
            .then((ctx) => {
              console.log(
                `path, type , input,appRouter._def.procedures

                  `,
                path,
                type,
                input,
                appRouter._def.procedures,
              )
              return callProcedure({
                ctx,
                path,
                type,
                rawInput: input,
                procedures: appRouter._def.procedures,
              })
            })
            .then((data) => {
              observer.next({ result: { data } })
              observer.complete()
            })
            .catch((cause: TRPCErrorResponse) => {
              observer.error(TRPCClientError.from(cause))
            })
        }),
  ],
})