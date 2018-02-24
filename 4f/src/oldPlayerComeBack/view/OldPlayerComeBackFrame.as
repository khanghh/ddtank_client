package oldPlayerComeBack.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DiceRoll;
   import flash.events.MouseEvent;
   import oldPlayerComeBack.OldPlayerComeBackControl;
   import oldPlayerComeBack.OldPlayerComeBackManager;
   import oldPlayerComeBack.view.task.OldPlayerTaskFrame;
   
   public class OldPlayerComeBackFrame extends Frame
   {
      
      private static const DICE_TEMPLATE_ID:int = 12571;
       
      
      private var _view:OldPlayerComeBackView;
      
      private var _dispatchTaskBtn:SimpleBitmapButton;
      
      private var _rollDice:SimpleBitmapButton;
      
      private var _diceCountTxt:FilterFrameText;
      
      private var _diceDecTxt:FilterFrameText;
      
      private var _isStartRollDice:Boolean = false;
      
      private var _diceRollMc:DiceRoll;
      
      private var _control:OldPlayerComeBackControl;
      
      private var _taskFrame:OldPlayerTaskFrame;
      
      public function OldPlayerComeBackFrame(){super();}
      
      public function set initControl(param1:OldPlayerComeBackControl) : void{}
      
      override protected function init() : void{}
      
      public function get diceRollMc() : DiceRoll{return null;}
      
      private function updateDiceDec() : void{}
      
      public function updateDiceCount() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __updateDiceCountHandler(param1:BagEvent) : void{}
      
      private function __rollDiceBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __dispatchTaskBtnClickHandler(param1:MouseEvent) : void{}
      
      public function set rollDiceComplete(param1:Boolean) : void{}
      
      public function get comeBackView() : OldPlayerComeBackView{return null;}
      
      override public function dispose() : void{}
   }
}
