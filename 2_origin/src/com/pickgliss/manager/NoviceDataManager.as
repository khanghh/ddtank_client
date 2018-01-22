package com.pickgliss.manager
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLVariables;
   
   public class NoviceDataManager extends EventDispatcher
   {
      
      private static var _instance:NoviceDataManager;
       
      
      public var firstEnterGame:Boolean = false;
      
      public function NoviceDataManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : NoviceDataManager
      {
         if(!_instance)
         {
            _instance = new NoviceDataManager();
         }
         return _instance;
      }
      
      public function saveNoviceData(param1:int, param2:String, param3:String) : void
      {
         var _loc5_:URLVariables = new URLVariables();
         _loc5_["nodeID"] = param1;
         _loc5_["userName"] = param2;
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(param3 + "NoviceNodeData.ashx",6,_loc5_);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
   }
}
