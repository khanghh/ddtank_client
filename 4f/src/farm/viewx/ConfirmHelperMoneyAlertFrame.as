package farm.viewx
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class ConfirmHelperMoneyAlertFrame extends BaseAlerFrame
   {
       
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _bg3:Scale9CornerImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _payTxt:FilterFrameText;
      
      private var _bgTitle:DisplayObject;
      
      private var _secondBtnGroup:SelectedButtonGroup;
      
      private var _oneBtn:SelectedCheckButton;
      
      private var _twoBtn:SelectedCheckButton;
      
      private var _showPayMoneyBG:Image;
      
      private var _showPayMoney:FilterFrameText;
      
      private var payNum:int = 0;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      public function ConfirmHelperMoneyAlertFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __framePesponse(param1:FrameEvent) : void{}
      
      private function __moneyConfirmHandler(param1:FrameEvent) : void{}
      
      private function __upPayNum(param1:Event) : void{}
      
      protected function upPayMoneyText() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
