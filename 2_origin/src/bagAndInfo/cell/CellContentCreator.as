package bagAndInfo.cell
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.PropItemView;
   import ddt.view.character.ILayer;
   import ddt.view.character.ILayerFactory;
   import ddt.view.character.LayerFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CellContentCreator extends Sprite implements Disposeable
   {
       
      
      protected var _factory:ILayerFactory;
      
      protected var _loader:ILayer;
      
      protected var _callBack:Function;
      
      protected var _timer:TimerJuggler;
      
      protected var _info:ItemTemplateInfo;
      
      private var _w:Number;
      
      private var _h:Number;
      
      public function CellContentCreator()
      {
         super();
         _factory = LayerFactory.instance;
      }
      
      public function set info(param1:ItemTemplateInfo) : void
      {
         _info = param1;
      }
      
      public function loadSync(param1:Function) : void
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
         if(_timer)
         {
            _timer.removeEventListener("timerComplete",__timerComplete);
            _timer.stop();
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         addChild(PropItemView.createView(_info.Pic) as Bitmap);
      }
      
      protected function loadComplete(param1:ILayer) : void
      {
         addChild(param1.getContent());
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
      
      public function dispose() : void
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
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
