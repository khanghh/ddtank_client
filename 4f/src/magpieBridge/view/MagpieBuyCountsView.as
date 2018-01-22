package magpieBridge.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.Price;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MagpieBuyCountsView extends BaseAlerFrame
   {
       
      
      private var _text:FilterFrameText;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _totalTipText:FilterFrameText;
      
      private var _totalText:FilterFrameText;
      
      private var _price:int;
      
      public function MagpieBuyCountsView(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __selectedItemChange(param1:Event) : void{}
      
      public function updateTotalCost() : void{}
      
      protected function __okBtnClick(param1:MouseEvent) : void{}
      
      private function reConfirmHandler(param1:FrameEvent) : void{}
      
      protected function __cancelBtnClick(param1:MouseEvent) : void{}
      
      private function __seleterChange(param1:Event) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      private function removeEvents() : void{}
      
      override public function dispose() : void{}
      
      public function set price(param1:int) : void{}
   }
}
