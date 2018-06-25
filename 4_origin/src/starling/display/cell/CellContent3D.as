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
      
      public function CellContent3D($info:ItemTemplateInfo = null)
      {
         super();
         _factory = LayerFactory.instance;
         _info = $info;
      }
      
      public function set info($info:ItemTemplateInfo) : void
      {
         _info = $info;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _info;
      }
      
      public function loadSync(callBack:Function = null) : void
      {
         var color:* = null;
         _callBack = callBack;
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
               color = EquipType.isEditable(_info) && InventoryItemInfo(_info).Color != null?InventoryItemInfo(_info).Color:"";
               _loader = _factory.createLayer(_info,_info.NeedSex == 1,color,"icon");
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
      
      protected function __timerComplete(evt:Event) : void
      {
         var image:* = null;
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__timerComplete);
            _timer.stop();
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         if(_info.Pic == "wish")
         {
            image = StarlingMain.instance.createImage("game_wishBtn");
         }
         else
         {
            image = StarlingMain.instance.createImage("game_prop_" + _info.Pic);
         }
         addChild(image);
         if(_callBack)
         {
            _callBack();
         }
      }
      
      protected function loadComplete(layer:ILayer) : void
      {
         if((layer.getContent() as DisplayObjectContainer).numChildren == 0)
         {
            return;
         }
         var obj:Bitmap = (layer.getContent() as DisplayObjectContainer).getChildAt(0) as Bitmap;
         var texture:Texture = Texture.fromBitmap(obj,false);
         DDTAssetManager.instance.addTexture("gameusingItemPic" + _info.Pic,texture,"fighting3d");
         var img:Image = new Image(texture);
         var _loc5_:int = 64;
         img.height = _loc5_;
         img.width = _loc5_;
         img.x = img.x - 10;
         addChild(img);
         if(_callBack)
         {
            _callBack();
         }
      }
      
      public function setColor(color:*) : Boolean
      {
         if(_loader != null)
         {
            return _loader.setColor(color);
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
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _w = value;
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _h = value;
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
