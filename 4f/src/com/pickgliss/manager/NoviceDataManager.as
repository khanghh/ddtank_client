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
      
      public function NoviceDataManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : NoviceDataManager{return null;}
      
      public function saveNoviceData(param1:int, param2:String, param3:String) : void{}
   }
}
