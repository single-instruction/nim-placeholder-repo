import results
import ./addresses
import ./op_codes

type
  TxContext* = object
    contractAddress*: Opt[Address]

  BaseVMState* = ref object
    txCtx*: TxContext
