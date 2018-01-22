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
      
      public function CellContent3D(param1:ItemTemplateInfo = null)
      {
         super();
         _factory = LayerFactory.instance;
         _info = param1;
      }
      
      public function set info(param1:ItemTemplateInfo) : void
      {
         _info = param1;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _info;
      }
      
      public function loadSync(param1:Function = null) : void
      {
         var _loc2_:* = null;
         _callBack = param1;
         if(_info.CategoryID == 10)
         {
            _timer = TimerManager.getInstance().addTimerJuggler(100,1);
            _timer.addEventListener("timerComplete",__timerComplete);
            _timer.start();
         }
         else
         {
            if(_info is InventoryItemInfo)
            {
               _loc2_ = EquipType.isEditable(_info) && InventoryItemInfo(_info).Color != null?InventoryItemInfo(_info).Color:"";
               _loader = _factory.createLayer(_info,_info.NeedSex == 1,_loc2_,"icon");
            }
            else
            {
               _loader = _factory.createLayer(_info,_info.NeedSex == 1,"","icon");
            }
            _loader.load(loadComplete);
         }
      }
      
      public function clearLoader() : void
      {
         if(_loader != null)
         {
            _loader.dispose();
            _loader = null;
         }
      }
      
      protected function __timerComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__timerComplete);
            _timer.stop();
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         if(_info.Pic == "wish")
         {
            _loc2_ = StarlingMain.instance.createImage("game_wishBtn");
         }
         else
         {
            _loc2_ = StarlingMain.instance.createImage("game_prop_" + _info.Pic);
         }
         addChild(_loc2_);
         if(_callBack)
         {
            _callBack();
         }
      }
      
      protected function loadComplete(param1:ILayer) : void
      {
         if((param1.getContent() as DisplayObjectContainer).numChildren == 0)
         {
            return;
         }
         var _loc4_:Bitmap = (param1.getContent() as DisplayObjectContainer).getChildAt(0) as Bitmap;
         var _loc2_:Texture = Texture.fromBitmap(_loc4_,false);
         DDTAssetManager.instance.addTexture("gameusingItemPic" + _info.Pic,_loc2_,"fighting3d");
         var _loc3_:Image = new Image(_loc2_);
         var _loc5_:int = 64;
         _loc3_.height = _loc5_;
         _loc3_.width = _loc5_;
         _loc3_.x = _loc3_.x - 10;
         addChild(_loc3_);
         if(_callBack)
         {
            _callBack();
         }
      }
      
      public function setColor(param1:*) : Boolean
      {
         if(_loader != null)
         {
            return _loader.setColor(param1);
         }
         return false;
      }
      
      public function get editLayer() : int
      {
         if(_loader == null)
         {
            return 1;
         }
         return _loader.currentEdit;
      }
      
      override public function set width(param1:Number) : void
      {
         .super.width = param1;
         _w = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         .super.height = param1;
         _h = param1;
      }
      
      override public function dispose() : void
      {
         _factory = null;
         if(_loader != null)
         {
            _loader.dispose();
         }
         _loader = null;
         if(_timer != null)
         {
            _timer.removeEventListener("timerComplete",__timerComplete);
            _timer.stop();
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         _callBack = null;
         StarlingObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
