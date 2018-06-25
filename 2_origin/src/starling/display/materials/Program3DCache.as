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
      
      public static function getProgram3D(context:Context3D, vertexShader:IShader, fragmentShader:IShader) : Program3D
      {
         var vertexShaderUID:int = uidByShaderTable[vertexShader];
         if(vertexShaderUID == 0)
         {
            uid = uid + 1;
            var _loc8_:* = uid + 1;
            uidByShaderTable[vertexShader] = _loc8_;
            vertexShaderUID = _loc8_;
         }
         var fragmentShaderUID:int = uidByShaderTable[fragmentShader];
         if(fragmentShaderUID == 0)
         {
            uid = uid + 1;
            _loc8_ = uid + 1;
            uidByShaderTable[fragmentShader] = _loc8_;
            fragmentShaderUID = _loc8_;
         }
         var program3DUID:String = vertexShaderUID + "_" + fragmentShaderUID;
         var program3D:Program3D = programByUIDTable[program3DUID];
         if(program3D == null)
         {
            _loc8_ = context.createProgram();
            programByUIDTable[program3DUID] = _loc8_;
            program3D = _loc8_;
            uidByProgramTable[program3D] = program3DUID;
            program3D.upload(vertexShader.opCode,fragmentShader.opCode);
            numReferencesByProgramTable[program3D] = 0;
            cacheSize = Number(cacheSize) + 1;
         }
         _loc8_ = numReferencesByProgramTable;
         var _loc9_:* = program3D;
         var _loc10_:* = Number(_loc8_[_loc9_]) + 1;
         _loc8_[_loc9_] = _loc10_;
         if(cacheSize > 8)
         {
            flush();
         }
         return program3D;
      }
      
      public static function releaseProgram3D(program3D:Program3D, forceFlush:Boolean = false) : void
      {
         if(!numReferencesByProgramTable[program3D])
         {
            throw new Error("Program3D is not in cache");
         }
         var _loc3_:* = numReferencesByProgramTable;
         var _loc4_:* = program3D;
         var _loc5_:* = Number(_loc3_[_loc4_]) - 1;
         _loc3_[_loc4_] = _loc5_;
         if(forceFlush)
         {
            flush();
         }
      }
      
      private static function flush() : void
      {
         var program3D:* = null;
         var numReferences:int = 0;
         var program3DUID:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = programByUIDTable;
         for(var uid in programByUIDTable)
         {
            program3D = programByUIDTable[uid];
            numReferences = numReferencesByProgramTable[program3D];
            if(numReferences <= 0)
            {
               program3D.dispose();
               delete numReferencesByProgramTable[program3D];
               program3DUID = uidByProgramTable[program3D];
               delete programByUIDTable[program3DUID];
               delete uidByProgramTable[program3D];
               cacheSize = Number(cacheSize) - 1;
               return;
            }
         }
      }
   }
}
