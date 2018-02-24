package BombTurnTable.view
{
   import BombTurnTable.event.TurnTableEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LotteryPointer extends Sprite implements Disposeable
   {
       
      
      private var _curType:int;
      
      private var _bg:Bitmap;
      
      private var _pointer:Bitmap;
      
      private var _pointerBorder:Bitmap;
      
      private var _lotteryBtn:BaseButton;
      
      private var _continuousBtn:BaseButton;
      
      private var _stopBtn:BaseButton;
      
      private var _curStatus:int;
      
      private var _clickNum:Number = 0;
      
      public function LotteryPointer(param1:int, param2:int){super();}
      
      private function initView() : void{}
      
      private function initLotteryBtn() : void{}
      
      private function initBtnStatus() : void{}
      
      private function clickLottery_Handler(param1:MouseEvent) : void{}
      
      private function continuousLottery_Handler(param1:MouseEvent) : void{}
      
      private function stopLottery_Handler(param1:MouseEvent) : void{}
      
      public function updateBtnStatus(param1:Boolean) : void{}
      
      private function updatePointer(param1:int) : void{}
      
      private function updatePointerBorder() : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
