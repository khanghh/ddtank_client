package com.adobe.utils
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AGALMiniAssembler
   {
      
      protected static const REGEXP_OUTER_SPACES:RegExp = /^\s+|\s+$/g;
      
      private static var initialized:Boolean = false;
      
      private static const OPMAP:Dictionary = new Dictionary();
      
      private static const REGMAP:Dictionary = new Dictionary();
      
      private static const SAMPLEMAP:Dictionary = new Dictionary();
      
      private static const MAX_NESTING:int = 4;
      
      private static const MAX_OPCODES:int = 2048;
      
      private static const FRAGMENT:String = "fragment";
      
      private static const VERTEX:String = "vertex";
      
      private static const SAMPLER_TYPE_SHIFT:uint = 8;
      
      private static const SAMPLER_DIM_SHIFT:uint = 12;
      
      private static const SAMPLER_SPECIAL_SHIFT:uint = 16;
      
      private static const SAMPLER_REPEAT_SHIFT:uint = 20;
      
      private static const SAMPLER_MIPMAP_SHIFT:uint = 24;
      
      private static const SAMPLER_FILTER_SHIFT:uint = 28;
      
      private static const REG_WRITE:uint = 1;
      
      private static const REG_READ:uint = 2;
      
      private static const REG_FRAG:uint = 32;
      
      private static const REG_VERT:uint = 64;
      
      private static const OP_SCALAR:uint = 1;
      
      private static const OP_SPECIAL_TEX:uint = 8;
      
      private static const OP_SPECIAL_MATRIX:uint = 16;
      
      private static const OP_FRAG_ONLY:uint = 32;
      
      private static const OP_VERT_ONLY:uint = 64;
      
      private static const OP_NO_DEST:uint = 128;
      
      private static const OP_VERSION2:uint = 256;
      
      private static const OP_INCNEST:uint = 512;
      
      private static const OP_DECNEST:uint = 1024;
      
      private static const MOV:String = "mov";
      
      private static const ADD:String = "add";
      
      private static const SUB:String = "sub";
      
      private static const MUL:String = "mul";
      
      private static const DIV:String = "div";
      
      private static const RCP:String = "rcp";
      
      private static const MIN:String = "min";
      
      private static const MAX:String = "max";
      
      private static const FRC:String = "frc";
      
      private static const SQT:String = "sqt";
      
      private static const RSQ:String = "rsq";
      
      private static const POW:String = "pow";
      
      private static const LOG:String = "log";
      
      private static const EXP:String = "exp";
      
      private static const NRM:String = "nrm";
      
      private static const SIN:String = "sin";
      
      private static const COS:String = "cos";
      
      private static const CRS:String = "crs";
      
      private static const DP3:String = "dp3";
      
      private static const DP4:String = "dp4";
      
      private static const ABS:String = "abs";
      
      private static const NEG:String = "neg";
      
      private static const SAT:String = "sat";
      
      private static const M33:String = "m33";
      
      private static const M44:String = "m44";
      
      private static const M34:String = "m34";
      
      private static const DDX:String = "ddx";
      
      private static const DDY:String = "ddy";
      
      private static const IFE:String = "ife";
      
      private static const INE:String = "ine";
      
      private static const IFG:String = "ifg";
      
      private static const IFL:String = "ifl";
      
      private static const ELS:String = "els";
      
      private static const EIF:String = "eif";
      
      private static const TED:String = "ted";
      
      private static const KIL:String = "kil";
      
      private static const TEX:String = "tex";
      
      private static const SGE:String = "sge";
      
      private static const SLT:String = "slt";
      
      private static const SGN:String = "sgn";
      
      private static const SEQ:String = "seq";
      
      private static const SNE:String = "sne";
      
      private static const VA:String = "va";
      
      private static const VC:String = "vc";
      
      private static const VT:String = "vt";
      
      private static const VO:String = "vo";
      
      private static const VI:String = "vi";
      
      private static const FC:String = "fc";
      
      private static const FT:String = "ft";
      
      private static const FS:String = "fs";
      
      private static const FO:String = "fo";
      
      private static const FD:String = "fd";
      
      private static const D2:String = "2d";
      
      private static const D3:String = "3d";
      
      private static const CUBE:String = "cube";
      
      private static const MIPNEAREST:String = "mipnearest";
      
      private static const MIPLINEAR:String = "miplinear";
      
      private static const MIPNONE:String = "mipnone";
      
      private static const NOMIP:String = "nomip";
      
      private static const NEAREST:String = "nearest";
      
      private static const LINEAR:String = "linear";
      
      private static const ANISOTROPIC2X:String = "anisotropic2x";
      
      private static const ANISOTROPIC4X:String = "anisotropic4x";
      
      private static const ANISOTROPIC8X:String = "anisotropic8x";
      
      private static const ANISOTROPIC16X:String = "anisotropic16x";
      
      private static const CENTROID:String = "centroid";
      
      private static const SINGLE:String = "single";
      
      private static const IGNORESAMPLER:String = "ignoresampler";
      
      private static const REPEAT:String = "repeat";
      
      private static const WRAP:String = "wrap";
      
      private static const CLAMP:String = "clamp";
      
      private static const REPEAT_U_CLAMP_V:String = "repeat_u_clamp_v";
      
      private static const CLAMP_U_REPEAT_V:String = "clamp_u_repeat_v";
      
      private static const RGBA:String = "rgba";
      
      private static const DXT1:String = "dxt1";
      
      private static const DXT5:String = "dxt5";
      
      private static const VIDEO:String = "video";
       
      
      private var _agalcode:ByteArray = null;
      
      private var _error:String = "";
      
      private var debugEnabled:Boolean = false;
      
      public var verbose:Boolean = false;
      
      public function AGALMiniAssembler(debugging:Boolean = false)
      {
         super();
         debugEnabled = debugging;
         if(!initialized)
         {
            init();
         }
      }
      
      private static function init() : void
      {
         initialized = true;
         OPMAP["mov"] = new OpCode("mov",2,0,0);
         OPMAP["add"] = new OpCode("add",3,1,0);
         OPMAP["sub"] = new OpCode("sub",3,2,0);
         OPMAP["mul"] = new OpCode("mul",3,3,0);
         OPMAP["div"] = new OpCode("div",3,4,0);
         OPMAP["rcp"] = new OpCode("rcp",2,5,0);
         OPMAP["min"] = new OpCode("min",3,6,0);
         OPMAP["max"] = new OpCode("max",3,7,0);
         OPMAP["frc"] = new OpCode("frc",2,8,0);
         OPMAP["sqt"] = new OpCode("sqt",2,9,0);
         OPMAP["rsq"] = new OpCode("rsq",2,10,0);
         OPMAP["pow"] = new OpCode("pow",3,11,0);
         OPMAP["log"] = new OpCode("log",2,12,0);
         OPMAP["exp"] = new OpCode("exp",2,13,0);
         OPMAP["nrm"] = new OpCode("nrm",2,14,0);
         OPMAP["sin"] = new OpCode("sin",2,15,0);
         OPMAP["cos"] = new OpCode("cos",2,16,0);
         OPMAP["crs"] = new OpCode("crs",3,17,0);
         OPMAP["dp3"] = new OpCode("dp3",3,18,0);
         OPMAP["dp4"] = new OpCode("dp4",3,19,0);
         OPMAP["abs"] = new OpCode("abs",2,20,0);
         OPMAP["neg"] = new OpCode("neg",2,21,0);
         OPMAP["sat"] = new OpCode("sat",2,22,0);
         OPMAP["m33"] = new OpCode("m33",3,23,16);
         OPMAP["m44"] = new OpCode("m44",3,24,16);
         OPMAP["m34"] = new OpCode("m34",3,25,16);
         OPMAP["ddx"] = new OpCode("ddx",2,26,256 | 32);
         OPMAP["ddy"] = new OpCode("ddy",2,27,256 | 32);
         OPMAP["ife"] = new OpCode("ife",2,28,128 | 256 | 512 | 1);
         OPMAP["ine"] = new OpCode("ine",2,29,128 | 256 | 512 | 1);
         OPMAP["ifg"] = new OpCode("ifg",2,30,128 | 256 | 512 | 1);
         OPMAP["ifl"] = new OpCode("ifl",2,31,128 | 256 | 512 | 1);
         OPMAP["els"] = new OpCode("els",0,32,128 | 256 | 512 | 1024 | 1);
         OPMAP["eif"] = new OpCode("eif",0,33,128 | 256 | 1024 | 1);
         OPMAP["kil"] = new OpCode("kil",1,39,128 | 32);
         OPMAP["tex"] = new OpCode("tex",3,40,32 | 8);
         OPMAP["sge"] = new OpCode("sge",3,41,0);
         OPMAP["slt"] = new OpCode("slt",3,42,0);
         OPMAP["sgn"] = new OpCode("sgn",2,43,0);
         OPMAP["seq"] = new OpCode("seq",3,44,0);
         OPMAP["sne"] = new OpCode("sne",3,45,0);
         SAMPLEMAP["rgba"] = new Sampler("rgba",8,0);
         SAMPLEMAP["dxt1"] = new Sampler("dxt1",8,1);
         SAMPLEMAP["dxt5"] = new Sampler("dxt5",8,2);
         SAMPLEMAP["video"] = new Sampler("video",8,3);
         SAMPLEMAP["2d"] = new Sampler("2d",12,0);
         SAMPLEMAP["3d"] = new Sampler("3d",12,2);
         SAMPLEMAP["cube"] = new Sampler("cube",12,1);
         SAMPLEMAP["mipnearest"] = new Sampler("mipnearest",24,1);
         SAMPLEMAP["miplinear"] = new Sampler("miplinear",24,2);
         SAMPLEMAP["mipnone"] = new Sampler("mipnone",24,0);
         SAMPLEMAP["nomip"] = new Sampler("nomip",24,0);
         SAMPLEMAP["nearest"] = new Sampler("nearest",28,0);
         SAMPLEMAP["linear"] = new Sampler("linear",28,1);
         SAMPLEMAP["anisotropic2x"] = new Sampler("anisotropic2x",28,2);
         SAMPLEMAP["anisotropic4x"] = new Sampler("anisotropic4x",28,3);
         SAMPLEMAP["anisotropic8x"] = new Sampler("anisotropic8x",28,4);
         SAMPLEMAP["anisotropic16x"] = new Sampler("anisotropic16x",28,5);
         SAMPLEMAP["centroid"] = new Sampler("centroid",16,1);
         SAMPLEMAP["single"] = new Sampler("single",16,2);
         SAMPLEMAP["ignoresampler"] = new Sampler("ignoresampler",16,4);
         SAMPLEMAP["repeat"] = new Sampler("repeat",20,1);
         SAMPLEMAP["wrap"] = new Sampler("wrap",20,1);
         SAMPLEMAP["clamp"] = new Sampler("clamp",20,0);
         SAMPLEMAP["clamp_u_repeat_v"] = new Sampler("clamp_u_repeat_v",20,2);
         SAMPLEMAP["repeat_u_clamp_v"] = new Sampler("repeat_u_clamp_v",20,3);
      }
      
      public function get error() : String
      {
         return _error;
      }
      
      public function get agalcode() : ByteArray
      {
         return _agalcode;
      }
      
      public function assemble2(ctx3d:Context3D, version:uint, vertexsrc:String, fragmentsrc:String) : Program3D
      {
         var agalvertex:ByteArray = assemble("vertex",vertexsrc,version);
         var agalfragment:ByteArray = assemble("fragment",fragmentsrc,version);
         var prog:Program3D = ctx3d.createProgram();
         prog.upload(agalvertex,agalfragment);
         return prog;
      }
      
      public function assemble(mode:String, source:String, version:uint = 1, ignorelimits:Boolean = false) : ByteArray
      {
         var i:int = 0;
         var line:* = null;
         var startcomment:int = 0;
         var optsi:int = 0;
         var opts:* = null;
         var opCode:* = null;
         var opFound:* = null;
         var regs:* = null;
         var badreg:Boolean = false;
         var pad:* = 0;
         var regLength:* = 0;
         var j:int = 0;
         var isRelative:Boolean = false;
         var relreg:* = null;
         var res:* = null;
         var regFound:* = null;
         var idxmatch:* = null;
         var regidx:* = 0;
         var regmask:* = 0;
         var maskmatch:* = null;
         var isDest:Boolean = false;
         var isSampler:Boolean = false;
         var reltype:* = 0;
         var relsel:* = 0;
         var reloffset:int = 0;
         var cv:* = 0;
         var maskLength:* = 0;
         var k:int = 0;
         var relname:* = null;
         var regFoundRel:* = null;
         var selmatch:* = null;
         var relofs:* = null;
         var samplerbits:* = 0;
         var optsLength:* = 0;
         var bias:* = NaN;
         var optfound:* = null;
         var dbgLine:* = null;
         var agalLength:* = 0;
         var index:* = 0;
         var byteStr:* = null;
         var start:uint = getTimer();
         _agalcode = new ByteArray();
         _error = "";
         var isFrag:Boolean = false;
         if(mode == "fragment")
         {
            isFrag = true;
         }
         else if(mode != "vertex")
         {
            _error = "ERROR: mode needs to be \"fragment\" or \"vertex\" but is \"" + mode + "\".";
         }
         agalcode.endian = "littleEndian";
         agalcode.writeByte(160);
         agalcode.writeUnsignedInt(version);
         agalcode.writeByte(161);
         agalcode.writeByte(!!isFrag?1:0);
         initregmap(version,ignorelimits);
         var lines:Array = source.replace(/[\f\n\r\v]+/g,"\n").split("\n");
         var nest:int = 0;
         var nops:int = 0;
         var lng:int = lines.length;
         i = 0;
         while(i < lng && _error == "")
         {
            line = new String(lines[i]);
            line = line.replace(REGEXP_OUTER_SPACES,"");
            startcomment = line.search("//");
            if(startcomment != -1)
            {
               line = line.slice(0,startcomment);
            }
            optsi = line.search(/<.*>/g);
            if(optsi != -1)
            {
               opts = line.slice(optsi).match(/([\w\.\-\+]+)/gi);
               line = line.slice(0,optsi);
            }
            opCode = line.match(/^\w{3}/gi);
            if(!opCode)
            {
               if(line.length >= 3)
               {
                  trace("warning: bad line " + i + ": " + lines[i]);
               }
            }
            else
            {
               opFound = OPMAP[opCode[0]];
               if(debugEnabled)
               {
                  trace(opFound);
               }
               if(opFound == null)
               {
                  if(line.length >= 3)
                  {
                     trace("warning: bad line " + i + ": " + lines[i]);
                  }
               }
               else
               {
                  line = line.slice(line.search(opFound.name) + opFound.name.length);
                  if(opFound.flags & 256 && version < 2)
                  {
                     _error = "error: opcode requires version 2.";
                     break;
                  }
                  if(opFound.flags & 64 && isFrag)
                  {
                     _error = "error: opcode is only allowed in vertex programs.";
                     break;
                  }
                  if(opFound.flags & 32 && !isFrag)
                  {
                     _error = "error: opcode is only allowed in fragment programs.";
                     break;
                  }
                  if(verbose)
                  {
                     trace("emit opcode=" + opFound);
                  }
                  agalcode.writeUnsignedInt(opFound.emitCode);
                  nops++;
                  if(nops > 2048)
                  {
                     _error = "error: too many opcodes. maximum is 2048.";
                     break;
                  }
                  regs = line.match(/vc\[([vof][acostdip]?)(\d*)?(\.[xyzw](\+\d{1,3})?)?\](\.[xyzw]{1,4})?|([vof][acostdip]?)(\d*)?(\.[xyzw]{1,4})?/gi);
                  if(!regs || regs.length != opFound.numRegister)
                  {
                     _error = "error: wrong number of operands. found " + regs.length + " but expected " + opFound.numRegister + ".";
                     break;
                  }
                  badreg = false;
                  pad = uint(160);
                  regLength = uint(regs.length);
                  for(j = 0; j < regLength; )
                  {
                     isRelative = false;
                     relreg = regs[j].match(/\[.*\]/gi);
                     if(relreg && relreg.length > 0)
                     {
                        regs[j] = regs[j].replace(relreg[0],"0");
                        if(verbose)
                        {
                           trace("IS REL");
                        }
                        isRelative = true;
                     }
                     res = regs[j].match(/^\b[A-Za-z]{1,2}/gi);
                     if(!res)
                     {
                        _error = "error: could not parse operand " + j + " (" + regs[j] + ").";
                        badreg = true;
                        break;
                     }
                     regFound = REGMAP[res[0]];
                     if(debugEnabled)
                     {
                        trace(regFound);
                     }
                     if(regFound == null)
                     {
                        _error = "error: could not find register name for operand " + j + " (" + regs[j] + ").";
                        badreg = true;
                        break;
                     }
                     if(isFrag)
                     {
                        if(!(regFound.flags & 32))
                        {
                           _error = "error: register operand " + j + " (" + regs[j] + ") only allowed in vertex programs.";
                           badreg = true;
                           break;
                        }
                        if(isRelative)
                        {
                           _error = "error: register operand " + j + " (" + regs[j] + ") relative adressing not allowed in fragment programs.";
                           badreg = true;
                           break;
                        }
                     }
                     else if(!(regFound.flags & 64))
                     {
                        _error = "error: register operand " + j + " (" + regs[j] + ") only allowed in fragment programs.";
                        badreg = true;
                        break;
                     }
                     regs[j] = regs[j].slice(regs[j].search(regFound.name) + regFound.name.length);
                     idxmatch = !!isRelative?relreg[0].match(/\d+/):regs[j].match(/\d+/);
                     regidx = uint(0);
                     if(idxmatch)
                     {
                        regidx = uint(idxmatch[0]);
                     }
                     if(regFound.range < regidx)
                     {
                        _error = "error: register operand " + j + " (" + regs[j] + ") index exceeds limit of " + (regFound.range + 1) + ".";
                        badreg = true;
                        break;
                     }
                     regmask = uint(0);
                     maskmatch = regs[j].match(/(\.[xyzw]{1,4})/);
                     isDest = j == 0 && !(opFound.flags & 128);
                     isSampler = j == 2 && opFound.flags & 8;
                     reltype = uint(0);
                     relsel = uint(0);
                     reloffset = 0;
                     if(isDest && isRelative)
                     {
                        _error = "error: relative can not be destination";
                        badreg = true;
                        break;
                     }
                     if(maskmatch)
                     {
                        regmask = uint(0);
                        maskLength = uint(maskmatch[0].length);
                        for(k = 1; k < maskLength; )
                        {
                           cv = uint(maskmatch[0].charCodeAt(k) - "x".charCodeAt(0));
                           if(cv > 2)
                           {
                              cv = uint(3);
                           }
                           if(isDest)
                           {
                              regmask = uint(regmask | 1 << cv);
                           }
                           else
                           {
                              regmask = uint(regmask | cv << (k - 1 << 1));
                           }
                           k++;
                        }
                        if(!isDest)
                        {
                           while(k <= 4)
                           {
                              regmask = uint(regmask | cv << (k - 1 << 1));
                              k++;
                           }
                        }
                     }
                     else
                     {
                        regmask = uint(!!isDest?15:Number(228));
                     }
                     if(isRelative)
                     {
                        relname = relreg[0].match(/[A-Za-z]{1,2}/gi);
                        regFoundRel = REGMAP[relname[0]];
                        if(regFoundRel == null)
                        {
                           _error = "error: bad index register";
                           badreg = true;
                           break;
                        }
                        reltype = uint(regFoundRel.emitCode);
                        selmatch = relreg[0].match(/(\.[xyzw]{1,1})/);
                        if(selmatch.length == 0)
                        {
                           _error = "error: bad index register select";
                           badreg = true;
                           break;
                        }
                        relsel = uint(selmatch[0].charCodeAt(1) - "x".charCodeAt(0));
                        if(relsel > 2)
                        {
                           relsel = uint(3);
                        }
                        relofs = relreg[0].match(/\+\d{1,3}/gi);
                        if(relofs.length > 0)
                        {
                           reloffset = relofs[0];
                        }
                        if(reloffset < 0 || reloffset > 255)
                        {
                           _error = "error: index offset " + reloffset + " out of bounds. [0..255]";
                           badreg = true;
                           break;
                        }
                        if(verbose)
                        {
                           trace("RELATIVE: type=" + reltype + "==" + relname[0] + " sel=" + relsel + "==" + selmatch[0] + " idx=" + regidx + " offset=" + reloffset);
                        }
                     }
                     if(verbose)
                     {
                        trace("  emit argcode=" + regFound + "[" + regidx + "][" + regmask + "]");
                     }
                     if(isDest)
                     {
                        agalcode.writeShort(regidx);
                        agalcode.writeByte(regmask);
                        agalcode.writeByte(regFound.emitCode);
                        pad = uint(pad - 32);
                     }
                     else if(isSampler)
                     {
                        if(verbose)
                        {
                           trace("  emit sampler");
                        }
                        samplerbits = uint(5);
                        optsLength = uint(opts == null?0:opts.length);
                        bias = 0;
                        for(k = 0; k < optsLength; )
                        {
                           if(verbose)
                           {
                              trace("    opt: " + opts[k]);
                           }
                           optfound = SAMPLEMAP[opts[k]];
                           if(optfound == null)
                           {
                              bias = Number(opts[k]);
                              if(verbose)
                              {
                                 trace("    bias: " + bias);
                              }
                           }
                           else
                           {
                              if(optfound.flag != 16)
                              {
                                 samplerbits = uint(samplerbits & ~(15 << optfound.flag));
                              }
                              samplerbits = uint(samplerbits | uint(optfound.mask) << uint(optfound.flag));
                           }
                           k++;
                        }
                        agalcode.writeShort(regidx);
                        agalcode.writeByte(int(bias * 8));
                        agalcode.writeByte(0);
                        agalcode.writeUnsignedInt(samplerbits);
                        if(verbose)
                        {
                           trace("    bits: " + (samplerbits - 5));
                        }
                        pad = uint(pad - 64);
                     }
                     else
                     {
                        if(j == 0)
                        {
                           agalcode.writeUnsignedInt(0);
                           pad = uint(pad - 32);
                        }
                        agalcode.writeShort(regidx);
                        agalcode.writeByte(reloffset);
                        agalcode.writeByte(regmask);
                        agalcode.writeByte(regFound.emitCode);
                        agalcode.writeByte(reltype);
                        agalcode.writeShort(!!isRelative?relsel | 32768:0);
                        pad = uint(pad - 64);
                     }
                     j++;
                  }
                  j = 0;
                  while(j < pad)
                  {
                     agalcode.writeByte(0);
                     j = j + 8;
                  }
                  if(badreg)
                  {
                     break;
                  }
               }
            }
            i++;
         }
         if(_error != "")
         {
            _error = _error + ("\n  at line " + i + " " + lines[i]);
            agalcode.length = 0;
            trace(_error);
         }
         if(debugEnabled)
         {
            dbgLine = "generated bytecode:";
            agalLength = uint(agalcode.length);
            for(index = uint(0); index < agalLength; )
            {
               if(!(index % 16))
               {
                  dbgLine = dbgLine + "\n";
               }
               if(!(index % 4))
               {
                  dbgLine = dbgLine + " ";
               }
               byteStr = agalcode[index].toString(16);
               if(byteStr.length < 2)
               {
                  byteStr = "0" + byteStr;
               }
               dbgLine = dbgLine + byteStr;
               index++;
            }
            trace(dbgLine);
         }
         if(verbose)
         {
            trace("AGALMiniAssembler.assemble time: " + (getTimer() - start) / 1000 + "s");
         }
         return agalcode;
      }
      
      private function initregmap(version:uint, ignorelimits:Boolean) : void
      {
         REGMAP["va"] = new Register("va","vertex attribute",0,!!ignorelimits?1024:Number(version == 1 || version == 2?7:15),64 | 2);
         REGMAP["vc"] = new Register("vc","vertex constant",1,!!ignorelimits?1024:Number(version == 1?127:Number(249)),64 | 2);
         REGMAP["vt"] = new Register("vt","vertex temporary",2,!!ignorelimits?1024:Number(version == 1?7:25),64 | 1 | 2);
         REGMAP["vo"] = new Register("vo","vertex output",3,!!ignorelimits?1024:0,64 | 1);
         REGMAP["vi"] = new Register("vi","varying",4,!!ignorelimits?1024:Number(version == 1?7:9),64 | 32 | 2 | 1);
         REGMAP["fc"] = new Register("fc","fragment constant",1,!!ignorelimits?1024:Number(version == 1?27:Number(version == 2?63:Number(199))),32 | 2);
         REGMAP["ft"] = new Register("ft","fragment temporary",2,!!ignorelimits?1024:Number(version == 1?7:25),32 | 1 | 2);
         REGMAP["fs"] = new Register("fs","texture sampler",5,!!ignorelimits?1024:7,32 | 2);
         REGMAP["fo"] = new Register("fo","fragment output",3,!!ignorelimits?1024:Number(version == 1?0:3),32 | 1);
         REGMAP["fd"] = new Register("fd","fragment depth output",6,!!ignorelimits?1024:Number(version == 1?-1:0),32 | 1);
         REGMAP["op"] = REGMAP["vo"];
         REGMAP["i"] = REGMAP["vi"];
         REGMAP["v"] = REGMAP["vi"];
         REGMAP["oc"] = REGMAP["fo"];
         REGMAP["od"] = REGMAP["fd"];
         REGMAP["fi"] = REGMAP["vi"];
      }
   }
}

class OpCode
{
    
   
   private var _emitCode:uint;
   
   private var _flags:uint;
   
   private var _name:String;
   
   private var _numRegister:uint;
   
   function OpCode(name:String, numRegister:uint, emitCode:uint, flags:uint)
   {
      super();
      _name = name;
      _numRegister = numRegister;
      _emitCode = emitCode;
      _flags = flags;
   }
   
   public function get emitCode() : uint
   {
      return _emitCode;
   }
   
   public function get flags() : uint
   {
      return _flags;
   }
   
   public function get name() : String
   {
      return _name;
   }
   
   public function get numRegister() : uint
   {
      return _numRegister;
   }
   
   public function toString() : String
   {
      return "[OpCode name=\"" + _name + "\", numRegister=" + _numRegister + ", emitCode=" + _emitCode + ", flags=" + _flags + "]";
   }
}

class Register
{
    
   
   private var _emitCode:uint;
   
   private var _name:String;
   
   private var _longName:String;
   
   private var _flags:uint;
   
   private var _range:uint;
   
   function Register(name:String, longName:String, emitCode:uint, range:uint, flags:uint)
   {
      super();
      _name = name;
      _longName = longName;
      _emitCode = emitCode;
      _range = range;
      _flags = flags;
   }
   
   public function get emitCode() : uint
   {
      return _emitCode;
   }
   
   public function get longName() : String
   {
      return _longName;
   }
   
   public function get name() : String
   {
      return _name;
   }
   
   public function get flags() : uint
   {
      return _flags;
   }
   
   public function get range() : uint
   {
      return _range;
   }
   
   public function toString() : String
   {
      return "[Register name=\"" + _name + "\", longName=\"" + _longName + "\", emitCode=" + _emitCode + ", range=" + _range + ", flags=" + _flags + "]";
   }
}

class Sampler
{
    
   
   private var _flag:uint;
   
   private var _mask:uint;
   
   private var _name:String;
   
   function Sampler(name:String, flag:uint, mask:uint)
   {
      super();
      _name = name;
      _flag = flag;
      _mask = mask;
   }
   
   public function get flag() : uint
   {
      return _flag;
   }
   
   public function get mask() : uint
   {
      return _mask;
   }
   
   public function get name() : String
   {
      return _name;
   }
   
   public function toString() : String
   {
      return "[Sampler name=\"" + _name + "\", flag=\"" + _flag + "\", mask=" + mask + "]";
   }
}
