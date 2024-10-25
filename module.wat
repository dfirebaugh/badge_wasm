(module
 (type $0 (func (param i32 i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32)))
 (type $4 (func (param i32 i32 i32 i32)))
 (type $5 (func (param i32 i32 i64)))
 (type $6 (func (param i32 i32 i32)))
 (type $7 (func (result f32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "Math" "random" (func $choppa/Math_random (result f32)))
 (import "Fb" "clear" (func $choppa/FbClear))
 (import "Fb" "color" (func $choppa/FbColor (param i32)))
 (import "Fb" "move" (func $choppa/FbMove (param i32 i32)))
 (import "Fb" "filledRectangle" (func $choppa/FbFilledRectangle (param i32 i32)))
 (import "Fb" "writeCharacter" (func $choppa/FbWriteCharacter (param i32)))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tcms/total (mut i32) (i32.const 0))
 (global $choppa/chopper (mut i32) (i32.const 0))
 (global $choppa/bullets (mut i32) (i32.const 0))
 (global $choppa/enemies (mut i32) (i32.const 0))
 (global $choppa/score (mut i32) (i32.const 0))
 (global $choppa/nextBullet (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 1036) "<")
 (data $0.1 (i32.const 1048) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $1 (i32.const 1100) "<")
 (data $1.1 (i32.const 1112) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00c\00m\00s\00.\00t\00s")
 (data $2 (i32.const 1164) "<")
 (data $2.1 (i32.const 1176) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $4 (i32.const 1260) ",")
 (data $4.1 (i32.const 1272) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $5 (i32.const 1308) "<")
 (data $5.1 (i32.const 1320) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $6 (i32.const 1372) "<")
 (data $6.1 (i32.const 1384) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $7 (i32.const 1436) "|")
 (data $7.1 (i32.const 1448) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (export "update" (func $choppa/update))
 (export "render" (func $choppa/render))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/tlsf/removeBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.load
  local.tee $3
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1184
   i32.const 268
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const -4
  i32.and
  local.tee $3
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 1184
   i32.const 270
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $3
   i32.const 4
   i32.shr_u
  else
   i32.const 31
   i32.const 1073741820
   local.get $3
   local.get $3
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.tee $4
   i32.const 7
   i32.sub
   local.set $2
   local.get $3
   local.get $4
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
  end
  local.tee $3
  i32.const 16
  i32.lt_u
  local.get $2
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1184
   i32.const 284
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load offset=8
  local.set $5
  local.get $1
  i32.load offset=4
  local.tee $4
  if
   local.get $4
   local.get $5
   i32.store offset=8
  end
  local.get $5
  if
   local.get $5
   local.get $4
   i32.store offset=4
  end
  local.get $1
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.tee $1
  i32.load offset=96
  i32.eq
  if
   local.get $1
   local.get $5
   i32.store offset=96
   local.get $5
   i32.eqz
   if
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    local.tee $1
    i32.load offset=4
    i32.const -2
    local.get $3
    i32.rotl
    i32.and
    local.set $3
    local.get $1
    local.get $3
    i32.store offset=4
    local.get $3
    i32.eqz
    if
     local.get $0
     local.get $0
     i32.load
     i32.const -2
     local.get $2
     i32.rotl
     i32.and
     i32.store
    end
   end
  end
 )
 (func $~lib/rt/tlsf/insertBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 1184
   i32.const 201
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load
  local.tee $3
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1184
   i32.const 203
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  local.get $1
  i32.load
  i32.const -4
  i32.and
  i32.add
  local.tee $4
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  if
   local.get $0
   local.get $4
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $3
   i32.const 4
   i32.add
   local.get $2
   i32.const -4
   i32.and
   i32.add
   local.tee $3
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.get $1
   i32.load
   i32.const -4
   i32.and
   i32.add
   local.tee $4
   i32.load
   local.set $2
  end
  local.get $3
  i32.const 2
  i32.and
  if
   local.get $1
   i32.const 4
   i32.sub
   i32.load
   local.tee $1
   i32.load
   local.tee $6
   i32.const 1
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 1184
    i32.const 221
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $6
   i32.const 4
   i32.add
   local.get $3
   i32.const -4
   i32.and
   i32.add
   local.tee $3
   i32.store
  end
  local.get $4
  local.get $2
  i32.const 2
  i32.or
  i32.store
  local.get $3
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 1184
   i32.const 233
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  local.get $1
  i32.const 4
  i32.add
  local.get $2
  i32.add
  i32.ne
  if
   i32.const 0
   i32.const 1184
   i32.const 234
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 4
  i32.sub
  local.get $1
  i32.store
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $2
   i32.clz
   i32.sub
   local.tee $3
   i32.const 7
   i32.sub
   local.set $5
   local.get $2
   local.get $3
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
  end
  local.tee $2
  i32.const 16
  i32.lt_u
  local.get $5
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1184
   i32.const 251
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $5
  i32.const 4
  i32.shl
  local.get $2
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  local.set $3
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  local.get $3
  i32.store offset=8
  local.get $3
  if
   local.get $3
   local.get $1
   i32.store offset=4
  end
  local.get $0
  local.get $5
  i32.const 4
  i32.shl
  local.get $2
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store offset=96
  local.get $0
  local.get $0
  i32.load
  i32.const 1
  local.get $5
  i32.shl
  i32.or
  i32.store
  local.get $0
  local.get $5
  i32.const 2
  i32.shl
  i32.add
  local.tee $0
  local.get $0
  i32.load offset=4
  i32.const 1
  local.get $2
  i32.shl
  i32.or
  i32.store offset=4
 )
 (func $~lib/rt/tlsf/addMemory (param $0 i32) (param $1 i32) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $2
  local.get $1
  i64.extend_i32_u
  i64.lt_u
  if
   i32.const 0
   i32.const 1184
   i32.const 382
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.set $1
  local.get $0
  i32.load offset=1568
  local.tee $3
  if
   local.get $3
   i32.const 4
   i32.add
   local.get $1
   i32.gt_u
   if
    i32.const 0
    i32.const 1184
    i32.const 389
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $3
   local.get $1
   i32.const 16
   i32.sub
   local.tee $5
   i32.eq
   if
    local.get $3
    i32.load
    local.set $4
    local.get $5
    local.set $1
   end
  else
   local.get $0
   i32.const 1572
   i32.add
   local.get $1
   i32.gt_u
   if
    i32.const 0
    i32.const 1184
    i32.const 402
    i32.const 5
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $2
  i32.wrap_i64
  i32.const -16
  i32.and
  local.get $1
  i32.sub
  local.tee $3
  i32.const 20
  i32.lt_u
  if
   return
  end
  local.get $1
  local.get $4
  i32.const 2
  i32.and
  local.get $3
  i32.const 8
  i32.sub
  local.tee $3
  i32.const 1
  i32.or
  i32.or
  i32.store
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  i32.const 0
  i32.store offset=8
  local.get $1
  i32.const 4
  i32.add
  local.get $3
  i32.add
  local.tee $3
  i32.const 2
  i32.store
  local.get $0
  local.get $3
  i32.store offset=1568
  local.get $0
  local.get $1
  call $~lib/rt/tlsf/insertBlock
 )
 (func $~lib/rt/tlsf/searchBlock (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $1
  i32.const 256
  i32.lt_u
  if
   local.get $1
   i32.const 4
   i32.shr_u
   local.set $1
  else
   local.get $1
   i32.const 536870910
   i32.lt_u
   if
    local.get $1
    i32.const 1
    i32.const 27
    local.get $1
    i32.clz
    i32.sub
    i32.shl
    i32.add
    i32.const 1
    i32.sub
    local.set $1
   end
   local.get $1
   i32.const 31
   local.get $1
   i32.clz
   i32.sub
   local.tee $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $1
   local.get $2
   i32.const 7
   i32.sub
   local.set $2
  end
  local.get $1
  i32.const 16
  i32.lt_u
  local.get $2
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 1184
   i32.const 334
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=4
  i32.const -1
  local.get $1
  i32.shl
  i32.and
  local.tee $1
  if (result i32)
   local.get $0
   local.get $1
   i32.ctz
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
  else
   local.get $0
   i32.load
   i32.const -1
   local.get $2
   i32.const 1
   i32.add
   i32.shl
   i32.and
   local.tee $1
   if (result i32)
    local.get $0
    local.get $1
    i32.ctz
    local.tee $1
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    local.tee $2
    i32.eqz
    if
     i32.const 0
     i32.const 1184
     i32.const 347
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $2
    i32.ctz
    local.get $1
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
   else
    i32.const 0
   end
  end
 )
 (func $~lib/rt/tcms/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $0
  i32.const 1073741804
  i32.gt_u
  if
   i32.const 1056
   i32.const 1120
   i32.const 125
   i32.const 30
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   memory.size
   local.tee $3
   i32.const 0
   i32.le_s
   if (result i32)
    i32.const 1
    local.get $3
    i32.sub
    memory.grow
    i32.const 0
    i32.lt_s
   else
    i32.const 0
   end
   if
    unreachable
   end
   i32.const 1568
   i32.const 0
   i32.store
   i32.const 3136
   i32.const 0
   i32.store
   loop $for-loop|0
    local.get $2
    i32.const 23
    i32.lt_u
    if
     local.get $2
     i32.const 2
     i32.shl
     i32.const 1568
     i32.add
     i32.const 0
     i32.store offset=4
     i32.const 0
     local.set $3
     loop $for-loop|1
      local.get $3
      i32.const 16
      i32.lt_u
      if
       local.get $2
       i32.const 4
       i32.shl
       local.get $3
       i32.add
       i32.const 2
       i32.shl
       i32.const 1568
       i32.add
       i32.const 0
       i32.store offset=96
       local.get $3
       i32.const 1
       i32.add
       local.set $3
       br $for-loop|1
      end
     end
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $for-loop|0
    end
   end
   i32.const 1568
   i32.const 3140
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   i32.const 1568
   global.set $~lib/rt/tlsf/ROOT
  end
  global.get $~lib/rt/tlsf/ROOT
  local.set $4
  local.get $0
  i32.const 16
  i32.add
  local.tee $2
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 1056
   i32.const 1184
   i32.const 461
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  local.get $2
  i32.const 12
  i32.le_u
  if (result i32)
   i32.const 12
  else
   local.get $2
   i32.const 19
   i32.add
   i32.const -16
   i32.and
   i32.const 4
   i32.sub
  end
  local.tee $5
  call $~lib/rt/tlsf/searchBlock
  local.tee $2
  i32.eqz
  if
   memory.size
   local.tee $2
   local.get $5
   i32.const 256
   i32.ge_u
   if (result i32)
    local.get $5
    i32.const 536870910
    i32.lt_u
    if (result i32)
     local.get $5
     i32.const 1
     i32.const 27
     local.get $5
     i32.clz
     i32.sub
     i32.shl
     i32.add
     i32.const 1
     i32.sub
    else
     local.get $5
    end
   else
    local.get $5
   end
   i32.const 4
   local.get $4
   i32.load offset=1568
   local.get $2
   i32.const 16
   i32.shl
   i32.const 4
   i32.sub
   i32.ne
   i32.shl
   i32.add
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $3
   local.get $2
   local.get $3
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $3
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $4
   local.get $2
   i32.const 16
   i32.shl
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   local.get $4
   local.get $5
   call $~lib/rt/tlsf/searchBlock
   local.tee $2
   i32.eqz
   if
    i32.const 0
    i32.const 1184
    i32.const 499
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $5
  local.get $2
  i32.load
  i32.const -4
  i32.and
  i32.gt_u
  if
   i32.const 0
   i32.const 1184
   i32.const 501
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  local.get $2
  call $~lib/rt/tlsf/removeBlock
  local.get $2
  i32.load
  local.set $6
  local.get $5
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 1184
   i32.const 361
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $6
  i32.const -4
  i32.and
  local.get $5
  i32.sub
  local.tee $3
  i32.const 16
  i32.ge_u
  if
   local.get $2
   local.get $5
   local.get $6
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $2
   i32.const 4
   i32.add
   local.get $5
   i32.add
   local.tee $5
   local.get $3
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $4
   local.get $5
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $2
   local.get $6
   i32.const -2
   i32.and
   i32.store
   local.get $2
   i32.const 4
   i32.add
   local.get $2
   i32.load
   i32.const -4
   i32.and
   i32.add
   local.tee $3
   local.get $3
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
  local.get $2
  local.get $1
  i32.store offset=12
  local.get $2
  local.get $0
  i32.store offset=16
  global.get $~lib/rt/tcms/fromSpace
  local.tee $0
  i32.load offset=8
  local.set $1
  local.get $2
  local.get $0
  i32.store offset=4
  local.get $2
  local.get $1
  i32.store offset=8
  local.get $1
  local.get $2
  local.get $1
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
  local.get $0
  local.get $2
  i32.store offset=8
  global.get $~lib/rt/tcms/total
  local.get $2
  i32.load
  i32.const -4
  i32.and
  i32.const 4
  i32.add
  i32.add
  global.set $~lib/rt/tcms/total
  local.get $2
  i32.const 20
  i32.add
 )
 (func $~lib/staticarray/StaticArray<choppa/Bullet>#__set (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 1392
   i32.const 1328
   i32.const 93
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
 )
 (func $choppa/Enemy#reset (param $0 i32)
  local.get $0
  i32.const 118
  i32.store8
  local.get $0
  call $choppa/Math_random
  f32.const 150
  f32.mul
  i32.trunc_sat_f32_u
  i32.store8 offset=1
  local.get $0
  call $choppa/Math_random
  f32.const -2
  f32.mul
  i32.trunc_sat_f32_s
  i32.const 1
  i32.sub
  i32.store8 offset=2
  local.get $0
  i32.const 1
  i32.store8 offset=3
 )
 (func $~lib/staticarray/StaticArray<choppa/Bullet>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 1392
   i32.const 1328
   i32.const 78
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.tee $0
  i32.eqz
  if
   i32.const 1456
   i32.const 1328
   i32.const 82
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $choppa/update
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  global.get $choppa/chopper
  local.set $1
  i32.const 0
  i32.load
  i32.const 4
  i32.and
  if (result i32)
   local.get $1
   i32.load8_u
  else
   i32.const 0
  end
  if
   local.get $1
   local.get $1
   i32.load8_u
   i32.const 1
   i32.sub
   i32.store8
  else
   i32.const 0
   i32.load
   i32.const 8
   i32.and
   if (result i32)
    local.get $1
    i32.load8_u
    i32.const 20
    i32.add
    i32.const 255
    i32.and
    i32.const 128
    i32.lt_u
   else
    i32.const 0
   end
   if
    local.get $1
    local.get $1
    i32.load8_u
    i32.const 1
    i32.add
    i32.store8
   end
  end
  i32.const 0
  i32.load
  i32.const 1
  i32.and
  if
   local.get $1
   i32.const 254
   i32.store8 offset=2
  else
   local.get $1
   i32.const 1
   i32.store8 offset=2
  end
  local.get $1
  local.get $1
  i32.load8_u offset=1
  local.get $1
  i32.load8_s offset=2
  i32.add
  i32.store8 offset=1
  local.get $1
  i32.load8_u offset=1
  i32.const 0
  i32.lt_u
  if
   local.get $1
   i32.const 0
   i32.store8 offset=1
  end
  local.get $1
  i32.load8_u offset=1
  i32.const 10
  i32.add
  i32.const 255
  i32.and
  i32.const 160
  i32.gt_u
  if
   local.get $1
   i32.const 150
   i32.store8 offset=1
  end
  i32.const 0
  i32.load
  i32.const 64
  i32.and
  if (result i32)
   global.get $choppa/bullets
   global.get $choppa/nextBullet
   call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
   i32.load8_u offset=2
  else
   i32.const 1
  end
  i32.eqz
  if
   global.get $choppa/bullets
   global.get $choppa/nextBullet
   call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
   local.set $1
   global.get $choppa/chopper
   i32.load8_u offset=1
   i32.const 4
   i32.add
   local.set $2
   local.get $1
   global.get $choppa/chopper
   i32.load8_u
   i32.const 20
   i32.add
   i32.store8
   local.get $1
   local.get $2
   i32.store8 offset=1
   local.get $1
   i32.const 1
   i32.store8 offset=2
   global.get $choppa/nextBullet
   i32.const 1
   i32.add
   i32.const 5
   i32.rem_s
   global.set $choppa/nextBullet
  end
  loop $for-loop|0
   local.get $0
   i32.const 5
   i32.lt_s
   if
    global.get $choppa/bullets
    local.get $0
    call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
    local.tee $1
    i32.load8_u offset=2
    if
     local.get $1
     local.get $1
     i32.load8_u
     i32.const 2
     i32.add
     i32.store8
     local.get $1
     i32.load8_u
     i32.const 128
     i32.gt_u
     if
      local.get $1
      i32.const 0
      i32.store8 offset=2
     end
    end
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  i32.const 0
  local.set $0
  loop $for-loop|1
   local.get $0
   i32.const 5
   i32.lt_s
   if
    global.get $choppa/enemies
    local.get $0
    call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
    local.tee $1
    i32.load8_u offset=3
    if
     local.get $1
     local.get $1
     i32.load8_u
     local.get $1
     i32.load8_s offset=2
     i32.add
     i32.store8
     local.get $1
     i32.load8_u
     i32.const 0
     i32.lt_u
     if
      local.get $1
      call $choppa/Enemy#reset
     end
    end
    i32.const 0
    local.set $1
    loop $for-loop|2
     local.get $1
     i32.const 5
     i32.lt_s
     if
      block $for-break2
       block $__inlined_func$choppa/Enemy#isHit$153 (result i32)
        global.get $choppa/enemies
        local.get $0
        call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
        local.set $2
        global.get $choppa/bullets
        local.get $1
        call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
        local.set $3
        local.get $2
        i32.load8_u offset=3
        if (result i32)
         local.get $3
         i32.load8_u offset=2
        else
         i32.const 0
        end
        if (result i32)
         local.get $2
         i32.load8_u
         local.get $3
         i32.load8_u
         i32.const 4
         i32.add
         i32.const 255
         i32.and
         i32.le_u
        else
         i32.const 0
        end
        if (result i32)
         local.get $3
         i32.load8_u
         local.get $2
         i32.load8_u
         i32.const 10
         i32.add
         i32.const 255
         i32.and
         i32.le_u
        else
         i32.const 0
        end
        if (result i32)
         local.get $2
         i32.load8_u offset=1
         local.get $3
         i32.load8_u offset=1
         i32.const 2
         i32.add
         i32.const 255
         i32.and
         i32.le_u
        else
         i32.const 0
        end
        if (result i32)
         local.get $3
         i32.load8_u offset=1
         local.get $2
         i32.load8_u offset=1
         i32.const 10
         i32.add
         i32.const 255
         i32.and
         i32.le_u
        else
         i32.const 0
        end
        if
         local.get $2
         i32.const 0
         i32.store8 offset=3
         local.get $3
         i32.const 0
         i32.store8 offset=2
         i32.const 1
         br $__inlined_func$choppa/Enemy#isHit$153
        end
        i32.const 0
       end
       if
        global.get $choppa/score
        i32.const 1
        i32.add
        i32.const 255
        i32.and
        global.set $choppa/score
        global.get $choppa/enemies
        local.get $0
        call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
        call $choppa/Enemy#reset
        br $for-break2
       end
       local.get $1
       i32.const 1
       i32.add
       local.set $1
       br $for-loop|2
      end
     end
    end
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|1
   end
  end
 )
 (func $choppa/render
  (local $0 i32)
  (local $1 i32)
  call $choppa/FbClear
  global.get $choppa/chopper
  local.tee $1
  i32.load16_u offset=4
  call $choppa/FbColor
  local.get $1
  i32.load8_u
  local.get $1
  i32.load8_u offset=1
  call $choppa/FbMove
  i32.const 20
  i32.const 10
  call $choppa/FbFilledRectangle
  loop $for-loop|0
   local.get $0
   i32.const 5
   i32.lt_s
   if
    global.get $choppa/bullets
    local.get $0
    call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
    local.tee $1
    i32.load8_u offset=2
    if
     i32.const 65535
     call $choppa/FbColor
     local.get $1
     i32.load8_u
     local.get $1
     i32.load8_u offset=1
     call $choppa/FbMove
     i32.const 4
     i32.const 2
     call $choppa/FbFilledRectangle
    end
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  i32.const 0
  local.set $0
  loop $for-loop|1
   local.get $0
   i32.const 5
   i32.lt_s
   if
    global.get $choppa/enemies
    local.get $0
    call $~lib/staticarray/StaticArray<choppa/Bullet>#__get
    local.tee $1
    i32.load8_u offset=3
    if
     i32.const 63488
     call $choppa/FbColor
     local.get $1
     i32.load8_u
     local.get $1
     i32.load8_u offset=1
     call $choppa/FbMove
     i32.const 10
     i32.const 10
     call $choppa/FbFilledRectangle
    end
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|1
   end
  end
  i32.const 65535
  call $choppa/FbColor
  global.get $choppa/score
  i32.const 255
  i32.and
  local.tee $0
  i32.const 10
  i32.div_u
  local.set $1
  i32.const 5
  i32.const 5
  call $choppa/FbMove
  local.get $1
  if
   local.get $1
   i32.const 48
   i32.add
   call $choppa/FbWriteCharacter
  end
  local.get $0
  i32.const 10
  i32.rem_u
  i32.const 48
  i32.add
  call $choppa/FbWriteCharacter
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  i32.const 1236
  i32.const 1232
  i32.store
  i32.const 1240
  i32.const 1232
  i32.store
  i32.const 1232
  global.set $~lib/rt/tcms/fromSpace
  i32.const 6
  i32.const 4
  call $~lib/rt/tcms/__new
  local.tee $1
  i32.const 0
  i32.store8
  local.get $1
  i32.const 0
  i32.store8 offset=1
  local.get $1
  i32.const 0
  i32.store8 offset=2
  local.get $1
  i32.const 0
  i32.store16 offset=4
  local.get $1
  i32.const 54
  i32.store8
  local.get $1
  i32.const 80
  i32.store8 offset=1
  local.get $1
  i32.const 0
  i32.store8 offset=2
  local.get $1
  i32.const 65535
  i32.store16 offset=4
  local.get $1
  global.set $choppa/chopper
  i32.const 20
  i32.const 6
  call $~lib/rt/tcms/__new
  local.tee $1
  i32.const 0
  i32.const 20
  memory.fill
  local.get $1
  global.set $choppa/bullets
  i32.const 20
  i32.const 8
  call $~lib/rt/tcms/__new
  local.tee $1
  i32.const 0
  i32.const 20
  memory.fill
  local.get $1
  global.set $choppa/enemies
  loop $for-loop|0
   local.get $0
   i32.const 5
   i32.lt_s
   if
    global.get $choppa/bullets
    local.set $1
    i32.const 3
    i32.const 5
    call $~lib/rt/tcms/__new
    local.tee $2
    i32.const 0
    i32.store8
    local.get $2
    i32.const 0
    i32.store8 offset=1
    local.get $2
    i32.const 0
    i32.store8 offset=2
    local.get $2
    i32.const 0
    i32.store8
    local.get $2
    i32.const 0
    i32.store8 offset=1
    local.get $2
    i32.const 1
    i32.store8 offset=2
    local.get $1
    local.get $0
    local.get $2
    call $~lib/staticarray/StaticArray<choppa/Bullet>#__set
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  i32.const 0
  local.set $0
  loop $for-loop|1
   local.get $0
   i32.const 5
   i32.lt_s
   if
    global.get $choppa/enemies
    local.set $1
    i32.const 4
    i32.const 7
    call $~lib/rt/tcms/__new
    local.tee $2
    i32.const 0
    i32.store8
    local.get $2
    i32.const 0
    i32.store8 offset=1
    local.get $2
    i32.const 0
    i32.store8 offset=2
    local.get $2
    i32.const 0
    i32.store8 offset=3
    local.get $2
    call $choppa/Enemy#reset
    local.get $1
    local.get $0
    local.get $2
    call $~lib/staticarray/StaticArray<choppa/Bullet>#__set
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|1
   end
  end
 )
)
