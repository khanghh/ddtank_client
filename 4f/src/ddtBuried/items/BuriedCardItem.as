package ddtBuried.items
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BuriedCardItem extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      public var id:int;
      
      private var _tempID:int;
      
      private var _count:int;
      
      private var _isPress:Boolean;
      
      public function BuriedCardItem(){super();}
      
      private function iniEvents() : void{}
      
      private function removeEvents() : void{}
      
      public function setGoodsInfo(param1:int, param2:int) : void{}
      
      public function set isPress(param1:Boolean) : void{}
      
      private function mouseClickHander(param1:MouseEvent) : void{}
      
      private function clickCallBack(param1:Boolean) : void{}
      
      public function play() : void{}
      
      private function payForCardHander(param1:Boolean) : void{}
      
      private function initView() : void{}
      
      private function initCard() : void{}
      
      private function takeOver() : void{}
      
      public function dispose() : void{}
   }
}
