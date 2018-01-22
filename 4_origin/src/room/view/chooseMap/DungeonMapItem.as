package room.view.chooseMap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DungeonMapItem extends BaseMapItem
   {
      
      private static const SHINE_DELAY:int = 200;
       
      
      private var _timer:Timer;
      
      private var _isNightmare:Boolean;
      
      private var _isDouble:Boolean;
      
      private var _doubleBmp:Bitmap;
      
      public function DungeonMapItem()
      {
         super();
         _timer = new Timer(200);
         _timer.addEventListener("timer",__onTimer);
      }
      
      override protected function initView() : void
      {
         super.initView();
      }
      
      public function shine() : void
      {
         _timer.start();
      }
      
      public function stopShine() : void
      {
         _timer.stop();
         _timer.reset();
         _selectedBg.visible = _selected;
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         _selectedBg.visible = _timer.currentCount % 2 == 1;
      }
      
      override public function set mapId(param1:int) : void
      {
         _mapId = param1;
         updateMapIcon();
         buttonMode = mapId == -1?false:true;
         _limitLevel.visible = buttonMode;
      }
      
      override protected function updateMapIcon() : void
      {
         var _loc1_:Object = PlayerManager.Instance.Self.dungeonFlag;
         if(_mapId == -1)
         {
            ObjectUtils.disposeAllChildren(_mapIconContaioner);
            if(_loader != null)
            {
               _loader.removeEventListener("complete",__onComplete);
            }
            return;
         }
         super.updateMapIcon();
      }
      
      override protected function solvePath() : String
      {
         if(isNightmare)
         {
            return PathManager.SITE_MAIN + "image/map/" + _mapId.toString() + "/samll_map_s_e.jpg";
         }
         return super.solvePath();
      }
      
      public function get isNightmare() : Boolean
      {
         return _isNightmare;
      }
      
      public function set isNightmare(param1:Boolean) : void
      {
         _isNightmare = param1;
      }
      
      public function get isDouble() : Boolean
      {
         return _isDouble;
      }
      
      public function set isDouble(param1:Boolean) : void
      {
         _isDouble = param1;
         if(_isDouble)
         {
            addDoulbeBmp();
         }
         else
         {
            ObjectUtils.disposeObject(_doubleBmp);
         }
      }
      
      private function addDoulbeBmp() : void
      {
         ObjectUtils.disposeObject(_doubleBmp);
         _doubleBmp = ComponentFactory.Instance.creatBitmap("ddt.ddtcore.doubleAwardIcon");
         PositionUtils.setPos(_doubleBmp,"dungeonMapItem.doubleAwardIconPos");
         addChild(_doubleBmp);
      }
      
      override public function dispose() : void
      {
         stopShine();
         ObjectUtils.disposeObject(_doubleBmp);
         _doubleBmp = null;
         super.dispose();
      }
   }
}
