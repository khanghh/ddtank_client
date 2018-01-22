package dice.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DiceSystemPanel extends Sprite implements Disposeable
   {
       
      
      private var _controller:DiceController;
      
      private var _bg:Bitmap;
      
      private var _startBG:Bitmap;
      
      private var _startArrow:Bitmap;
      
      private var _freeCount:FilterFrameText;
      
      private var _startBtn:ScaleFrameImage;
      
      private var _cellItem:Array;
      
      private var _target:int = -1;
      
      private var _baseAlert:BaseAlerFrame;
      
      private var _selectCheckBtn:SelectedCheckButton;
      
      private var _poorManAlert:BaseAlerFrame;
      
      public function DiceSystemPanel(){super();}
      
      public function set Controller(param1:DiceController) : void{}
      
      private function initialize() : void{}
      
      private function preInitialize() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onPlayerState(param1:DiceEvent) : void{}
      
      private function __getDiceResultData(param1:DiceEvent) : void{}
      
      private function __onStartBtnClick(param1:MouseEvent) : void{}
      
      private function __poorManResponse(param1:FrameEvent) : void{}
      
      private function AlertFeedeductionWindow() : void{}
      
      private function sendStartDataToServer() : void{}
      
      private function openAlertFrame() : void{}
      
      private function __onCheckBtnClick(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __onDicetypeChanged(param1:DiceEvent) : void{}
      
      private function __onFreeCountChanged(param1:DiceEvent) : void{}
      
      private function __onRefreshData(param1:DiceEvent) : void{}
      
      public function dispose() : void{}
   }
}
