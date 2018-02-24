package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.MenoryUtil;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class BaseCharacterLoader implements ICharacterLoader
   {
       
      
      protected var _layers:Vector.<ILayer>;
      
      protected var _layerFactory:ILayerFactory;
      
      protected var _info:PlayerInfo;
      
      protected var _recordStyle:Array;
      
      protected var _recordColor:Array;
      
      protected var _content:BitmapData;
      
      private var _callBack:Function;
      
      private var _completeCount:int;
      
      protected var _wing:MovieClip;
      
      protected var _weapon:MovieClip;
      
      public function BaseCharacterLoader(param1:PlayerInfo){super();}
      
      protected function initLayers() : void{}
      
      protected function getIndexByTemplateId(param1:String) : int{return 0;}
      
      public final function load(param1:Function = null) : void{}
      
      public function getUnCompleteLog() : String{return null;}
      
      private function __layerComplete(param1:ILayer) : void{}
      
      protected function loadComplete() : void{}
      
      protected function drawCharacter() : void{}
      
      public function getContent() : Array{return null;}
      
      public function setFactory(param1:ILayerFactory) : void{}
      
      public function update() : void{}
      
      protected function getCharacterLoader(param1:ItemTemplateInfo, param2:String = "", param3:String = null) : ILayer{return null;}
      
      public function dispose() : void{}
   }
}
