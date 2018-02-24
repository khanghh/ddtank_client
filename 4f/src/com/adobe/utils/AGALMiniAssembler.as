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
      
      public function AGALMiniAssembler(param1:Boolean = false){super();}
      
      private static function init() : void{}
      
      public function get error() : String{return null;}
      
      public function get agalcode() : ByteArray{return null;}
      
      public function assemble2(param1:Context3D, param2:uint, param3:String, param4:String) : Program3D{return null;}
      
      public function assemble(param1:String, param2:String, param3:uint = 1, param4:Boolean = false) : ByteArray{return null;}
      
      private function initregmap(param1:uint, param2:Boolean) : void{}
   }
}

class OpCode
{
    
   
   private var _emitCode:uint;
   
   private var _flags:uint;
   
   private var _name:String;
   
   private var _numRegister:uint;
   
   function OpCode(param1:String, param2:uint, param3:uint, param4:uint){super();}
   
   public function get emitCode() : uint{return null;}
   
   public function get flags() : uint{return null;}
   
   public function get name() : String{return null;}
   
   public function get numRegister() : uint{return null;}
   
   public function toString() : String{return null;}
}

class Register
{
    
   
   private var _emitCode:uint;
   
   private var _name:String;
   
   private var _longName:String;
   
   private var _flags:uint;
   
   private var _range:uint;
   
   function Register(param1:String, param2:String, param3:uint, param4:uint, param5:uint){super();}
   
   public function get emitCode() : uint{return null;}
   
   public function get longName() : String{return null;}
   
   public function get name() : String{return null;}
   
   public function get flags() : uint{return null;}
   
   public function get range() : uint{return null;}
   
   public function toString() : String{return null;}
}

class Sampler
{
    
   
   private var _flag:uint;
   
   private var _mask:uint;
   
   private var _name:String;
   
   function Sampler(param1:String, param2:uint, param3:uint){super();}
   
   public function get flag() : uint{return null;}
   
   public function get mask() : uint{return null;}
   
   public function get name() : String{return null;}
   
   public function toString() : String{return null;}
}
