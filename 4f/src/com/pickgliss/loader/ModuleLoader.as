package com.pickgliss.loader
{
   import cmodule.decry.CLibInit;
   import com.crypto.NewCrypto;
   import com.pickgliss.ui.ComponentSetting;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class ModuleLoader extends DisplayLoader
   {
      
      private static var loader:CLibInit = new CLibInit();
       
      
      private var _isEqual:Boolean;
      
      private var _name:String;
      
      private var _isSecondLoad:Boolean = false;
      
      public function ModuleLoader(param1:int, param2:String, param3:ApplicationDomain){super(null,null);}
      
      public static function decry(param1:ByteArray) : ByteArray{return null;}
      
      public static function getDefinition(param1:String) : *{return null;}
      
      public static function hasDefinition(param1:String) : Boolean{return false;}
      
      override public function loadFromBytes(param1:ByteArray) : void{}
      
      override protected function __onDataLoadComplete(param1:Event) : void{}
      
      public function analyMd5(param1:ByteArray) : void{}
      
      private function reload() : void{}
      
      private function getName() : String{return null;}
      
      private function compareMD5(param1:ByteArray, param2:String) : Boolean{return false;}
      
      private function hasHead(param1:ByteArray) : Boolean{return false;}
      
      private function handleModule(param1:ByteArray) : void{}
      
      override public function get type() : int{return 0;}
   }
}
