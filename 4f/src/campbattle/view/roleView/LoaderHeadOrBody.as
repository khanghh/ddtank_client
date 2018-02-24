package campbattle.view.roleView
{
   import campbattle.data.RoleData;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   
   public class LoaderHeadOrBody
   {
       
      
      private var _loaders:Array;
      
      private var _content:BitmapData;
      
      private var _completeCount:int;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      private var _callBack:Function;
      
      private var _consBatPlayerData:RoleData;
      
      private var _equipType:int;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      public function LoaderHeadOrBody(param1:RoleData, param2:int){super();}
      
      public function load(param1:Function = null) : void{}
      
      private function initLoaders() : void{}
      
      private function drawCharacter() : void{}
      
      private function layerComplete(param1:ILayer) : void{}
      
      private function loadComplete() : void{}
      
      public function getContent() : Array{return null;}
      
      public function dispose() : void{}
   }
}
