import ./types
import results
import ./addresses

proc makeReceipt(vmState: BaseVMState) =
  var contractAddr = default(Address)
  vmState.txCtx.contractAddress = Opt.some(contractAddr)
