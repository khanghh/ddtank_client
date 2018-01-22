package memoryGame.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.events.Event;
   
   public class MemoryGameBuyView extends BaseAlerFrame
   {
       
      
      private var _selecedItem:DoubleSelectedItem;
      
      private var _timesSelector:NumberSelecter;
      
      private var _txt:FilterFrameText;
      
      public var autoClose:Boolean = true;
      
      public function MemoryGameBuyView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function onMoneyChange(param1:Event) : void{}
      
      private function removeEvnets() : void{}
      
      private function responseHander(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      public function get isBind() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
