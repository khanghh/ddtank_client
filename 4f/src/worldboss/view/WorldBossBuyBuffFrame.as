package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import worldboss.WorldBossManager;
   import worldboss.model.WorldBossBuffInfo;
   
   public class WorldBossBuyBuffFrame extends Sprite implements Disposeable
   {
      
      public static var IsAutoShow:Boolean = true;
      
      private static var _autoBuyBuffItem:DictionaryData = new DictionaryData();
       
      
      private var _notAgainBtn:SelectedCheckButton;
      
      private var _selectedArr:Array;
      
      private var _cartList:VBox;
      
      private var _cartScroll:ScrollPanel;
      
      private var _frame:Frame;
      
      private var _innerBg:Image;
      
      private var _moneyTip:FilterFrameText;
      
      private var _moneyBg:Image;
      
      private var _money:FilterFrameText;
      
      private var _bottomBg:Image;
      
      public function WorldBossBuyBuffFrame(){super();}
      
      private function drawFrame() : void{}
      
      private function drawItemCountField() : void{}
      
      protected function drawPayListField() : void{}
      
      protected function init() : void{}
      
      private function setList() : void{}
      
      private function addEvent() : void{}
      
      protected function __onPropertyChanged(param1:PlayerPropertyEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __itemSelected(param1:Event = null) : void{}
      
      private function updatePrice() : void{}
      
      private function __againChange(param1:Event) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __getBuff(param1:CrazyTankSocketEvent) : void{}
      
      public function dispose() : void{}
   }
}
