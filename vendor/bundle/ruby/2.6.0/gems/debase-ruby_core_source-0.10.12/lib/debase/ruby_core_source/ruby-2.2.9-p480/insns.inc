/** -*-c-*-
  This file contains YARV instructions list.

  ----
  This file is auto generated by insns2vm.rb
  DO NOT TOUCH!

  If you want to fix something, you must edit 'template/insns.inc.tmpl'
  or tool/insns2vm.rb
 */


/* BIN : Basic Instruction Name */
#define BIN(n) YARVINSN_##n

enum ruby_vminsn_type {
  BIN(nop)                       = 0,
  BIN(getlocal)                  = 1,
  BIN(setlocal)                  = 2,
  BIN(getspecial)                = 3,
  BIN(setspecial)                = 4,
  BIN(getinstancevariable)       = 5,
  BIN(setinstancevariable)       = 6,
  BIN(getclassvariable)          = 7,
  BIN(setclassvariable)          = 8,
  BIN(getconstant)               = 9,
  BIN(setconstant)               = 10,
  BIN(getglobal)                 = 11,
  BIN(setglobal)                 = 12,
  BIN(putnil)                    = 13,
  BIN(putself)                   = 14,
  BIN(putobject)                 = 15,
  BIN(putspecialobject)          = 16,
  BIN(putiseq)                   = 17,
  BIN(putstring)                 = 18,
  BIN(concatstrings)             = 19,
  BIN(tostring)                  = 20,
  BIN(toregexp)                  = 21,
  BIN(newarray)                  = 22,
  BIN(duparray)                  = 23,
  BIN(expandarray)               = 24,
  BIN(concatarray)               = 25,
  BIN(splatarray)                = 26,
  BIN(newhash)                   = 27,
  BIN(newrange)                  = 28,
  BIN(pop)                       = 29,
  BIN(dup)                       = 30,
  BIN(dupn)                      = 31,
  BIN(swap)                      = 32,
  BIN(reput)                     = 33,
  BIN(topn)                      = 34,
  BIN(setn)                      = 35,
  BIN(adjuststack)               = 36,
  BIN(defined)                   = 37,
  BIN(checkmatch)                = 38,
  BIN(checkkeyword)              = 39,
  BIN(trace)                     = 40,
  BIN(defineclass)               = 41,
  BIN(send)                      = 42,
  BIN(opt_str_freeze)            = 43,
  BIN(opt_send_without_block)    = 44,
  BIN(invokesuper)               = 45,
  BIN(invokeblock)               = 46,
  BIN(leave)                     = 47,
  BIN(throw)                     = 48,
  BIN(jump)                      = 49,
  BIN(branchif)                  = 50,
  BIN(branchunless)              = 51,
  BIN(getinlinecache)            = 52,
  BIN(setinlinecache)            = 53,
  BIN(once)                      = 54,
  BIN(opt_case_dispatch)         = 55,
  BIN(opt_plus)                  = 56,
  BIN(opt_minus)                 = 57,
  BIN(opt_mult)                  = 58,
  BIN(opt_div)                   = 59,
  BIN(opt_mod)                   = 60,
  BIN(opt_eq)                    = 61,
  BIN(opt_neq)                   = 62,
  BIN(opt_lt)                    = 63,
  BIN(opt_le)                    = 64,
  BIN(opt_gt)                    = 65,
  BIN(opt_ge)                    = 66,
  BIN(opt_ltlt)                  = 67,
  BIN(opt_aref)                  = 68,
  BIN(opt_aset)                  = 69,
  BIN(opt_aset_with)             = 70,
  BIN(opt_aref_with)             = 71,
  BIN(opt_length)                = 72,
  BIN(opt_size)                  = 73,
  BIN(opt_empty_p)               = 74,
  BIN(opt_succ)                  = 75,
  BIN(opt_not)                   = 76,
  BIN(opt_regexpmatch1)          = 77,
  BIN(opt_regexpmatch2)          = 78,
  BIN(opt_call_c_function)       = 79,
  BIN(bitblt)                    = 80,
  BIN(answer)                    = 81,
  BIN(getlocal_OP__WC__0)        = 82,
  BIN(getlocal_OP__WC__1)        = 83,
  BIN(setlocal_OP__WC__0)        = 84,
  BIN(setlocal_OP__WC__1)        = 85,
  BIN(putobject_OP_INT2FIX_O_0_C_) = 86,
  BIN(putobject_OP_INT2FIX_O_1_C_) = 87,
  VM_INSTRUCTION_SIZE            = 88
};
