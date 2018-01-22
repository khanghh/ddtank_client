package starling.display.cell
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.ILayer;
   import ddt.view.character.ILayerFactory;
   import ddt.view.character.LayerFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import road7th.DDTAssetManager;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CellContent3D extends Sprite
   {
       
      
      protected var _factory:ILayerFactory;
      
      protected var _info:ItemTemplateInfo;
      
      protected var _loader:ILayer;
      
      protected var _callBack:Function;
      
      protected var _timer:TimerJuggler;
      
      private var _w:Number;
      
      private var _h:Number;
      
      public function CellContent3D(param1:ItemTemplateInfo = null){super();}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function loadSync(param1:Function = null) : void{}
      
      public function clearLoader() : void{}
      
      protected function __timerComplete(param1:Event) : void{}
      
      protected function loadComplete(param1:ILayer) : void{}
      
      public function setColor(param1:*) : Boolean{return false;}
      
      public function get editLayer() : int{return 0;}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      override public function dispose() : void{}
   }
}
