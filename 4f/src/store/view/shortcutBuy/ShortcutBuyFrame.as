package store.view.shortcutBuy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ShortcutBuyFrame extends Frame
   {
      
      public static const ADDFrameHeight:int = 60;
      
      public static const ADD_OKBTN_Y:int = 53;
       
      
      private var _view:ShortCutBuyView;
      
      private var _panelIndex:int;
      
      private var _showRadioBtn:Boolean;
      
      private var okBtn:TextButton;
      
      public function ShortcutBuyFrame(){super();}
      
      public function show(param1:Array, param2:Boolean, param3:String, param4:int, param5:int = -1, param6:Number = 30, param7:Number = 40) : void{}
      
      private function relocationView(param1:int, param2:Number, param3:Number) : void{}
      
      private function initII() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function _numberClose(param1:Event) : void{}
      
      private function _numberEnter(param1:Event) : void{}
      
      private function changeHandler(param1:Event) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function okFun(param1:MouseEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function buyGoods() : void{}
      
      private function showToLayer() : void{}
      
      override public function dispose() : void{}
   }
}
