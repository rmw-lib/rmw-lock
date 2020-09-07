import os from 'os'


export default (max=os.cpus().length*2)=>
  n = 0
  todo = []
  (func, ...args)=>
    if func
      return new Promise((resolve, reject)=>
        _ = =>
          ++n
          resolve()
          try
            resolve await func.apply func, args
          catch err
            reject err
          --n
          todo.pop()?()

        if n < max
          _()
        else
          todo.push _
        return
      )
    Promise.all todo
