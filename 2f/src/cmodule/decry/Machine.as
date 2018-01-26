package cmodule.decry
{
   public class Machine extends MemUser
   {
      
      public static var dbgFrameBreakLow:int = 0;
      
      public static const dbgFileNames:Array = [];
      
      public static const dbgFuncs:Array = [];
      
      public static const dbgGlobals:Array = [];
      
      public static const dbgScopes:Array = [];
      
      public static const dbgLabels:Array = [];
      
      public static var sMS:uint;
      
      public static const dbgBreakpoints:Object = {};
      
      public static const dbgFuncNames:Array = [];
      
      public static const dbgLocs:Array = [];
      
      public static var dbgFrameBreakHigh:int = -1;
       
      
      public var dbgFileId:int = 0;
      
      public var mstate:MState;
      
      public var dbgLabel:int = 0;
      
      public var caller:Machine;
      
      public var state:int = 0;
      
      public var dbgLineNo:int = 0;
      
      public function Machine(){super();}
      
      public static function debugTraverseScope(param1:Object, param2:int, param3:Function) : void{}
      
      public function debugTraceMem(param1:int, param2:int) : void{}
      
      public function get dbgFuncId() : int{return 0;}
      
      public function work() : void{}
      
      public function stringFromPtr(param1:int) : String{return null;}
      
      public function get dbgLoc() : Object{return null;}
      
      public function get dbgDepth() : int{return 0;}
      
      public function get dbgTrace() : String{return null;}
      
      public function debugTraverseCurrentScope(param1:Function) : void{}
      
      public function debugLabel(param1:int) : void{}
      
      public function stringToPtr(param1:int, param2:int, param3:String) : int{return 0;}
      
      public function debugBreak(param1:Object) : void{}
      
      public function debugLoc(param1:int, param2:int) : void{}
      
      public function get dbgFileName() : String{return null;}
      
      public function getSecsSetMS() : uint{return null;}
      
      public function get dbgFuncName() : String{return null;}
      
      public function backtrace() : void{}
   }
}
