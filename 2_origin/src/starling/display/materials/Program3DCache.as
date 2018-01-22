package starling.display.materials
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.utils.Dictionary;
   import starling.display.shaders.IShader;
   
   class Program3DCache
   {
      
      private static const LAZY_CACHE_SIZE:uint = 8;
      
      private static var uid:int = 0;
      
      private static var uidByShaderTable:Dictionary = new Dictionary(true);
      
      private static var programByUIDTable:Object = {};
      
      private static var uidByProgramTable:Dictionary = new Dictionary(false);
      
      private static var numReferencesByProgramTable:Dictionary = new Dictionary();
      
      private static var cacheSize:uint;
       
      
      function Program3DCache()
      {
         super();
      }
      
      public static function getProgram3D(param1:Context3D, param2:IShader, param3:IShader) : Program3D
      {
         var _loc7_:int = uidByShaderTable[param2];
         if(_loc7_ == 0)
         {
            uid = uid + 1;
            var _loc8_:* = uid + 1;
            uidByShaderTable[param2] = _loc8_;
            _loc7_ = _loc8_;
         }
         var _loc6_:int = uidByShaderTable[param3];
         if(_loc6_ == 0)
         {
            uid = uid + 1;
            _loc8_ = uid + 1;
            uidByShaderTable[param3] = _loc8_;
            _loc6_ = _loc8_;
         }
         var _loc5_:String = _loc7_ + "_" + _loc6_;
         var _loc4_:Program3D = programByUIDTable[_loc5_];
         if(_loc4_ == null)
         {
            _loc8_ = param1.createProgram();
            programByUIDTable[_loc5_] = _loc8_;
            _loc4_ = _loc8_;
            uidByProgramTable[_loc4_] = _loc5_;
            _loc4_.upload(param2.opCode,param3.opCode);
            numReferencesByProgramTable[_loc4_] = 0;
            cacheSize = Number(cacheSize) + 1;
         }
         _loc8_ = numReferencesByProgramTable;
         var _loc9_:* = _loc4_;
         var _loc10_:* = Number(_loc8_[_loc9_]) + 1;
         _loc8_[_loc9_] = _loc10_;
         if(cacheSize > 8)
         {
            flush();
         }
         return _loc4_;
      }
      
      public static function releaseProgram3D(param1:Program3D, param2:Boolean = false) : void
      {
         if(!numReferencesByProgramTable[param1])
         {
            throw new Error("Program3D is not in cache");
         }
         var _loc3_:* = numReferencesByProgramTable;
         var _loc4_:* = param1;
         var _loc5_:* = Number(_loc3_[_loc4_]) - 1;
         _loc3_[_loc4_] = _loc5_;
         if(param2)
         {
            flush();
         }
      }
      
      private static function flush() : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = programByUIDTable;
         for(var _loc1_ in programByUIDTable)
         {
            _loc3_ = programByUIDTable[_loc1_];
            _loc2_ = numReferencesByProgramTable[_loc3_];
            if(_loc2_ <= 0)
            {
               _loc3_.dispose();
               delete numReferencesByProgramTable[_loc3_];
               _loc4_ = uidByProgramTable[_loc3_];
               delete programByUIDTable[_loc4_];
               delete uidByProgramTable[_loc3_];
               cacheSize = Number(cacheSize) - 1;
               return;
            }
         }
      }
   }
}
