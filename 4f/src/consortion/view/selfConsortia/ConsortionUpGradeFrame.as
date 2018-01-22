package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.command.QuickBuyFrame;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionUpGradeFrame extends Frame
   {
       
      
      private var _level:SelectedButton;
      
      private var _store:SelectedButton;
      
      private var _shop:SelectedButton;
      
      private var _bank:SelectedButton;
      
      private var _skill:SelectedButton;
      
      private var _wordAndbmp1:MutipleImage;
      
      private var _wordAndBmp2:MutipleImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _storeTxt:FilterFrameText;
      
      private var _shopTxt:FilterFrameText;
      
      private var _bankTxt:FilterFrameText;
      
      private var _skillTxt:FilterFrameText;
      
      private var _levelNum:FilterFrameText;
      
      private var _storeNum:FilterFrameText;
      
      private var _shopNum:FilterFrameText;
      
      private var _bankNum:FilterFrameText;
      
      private var _skillNum:FilterFrameText;
      
      private var _explainWord:FilterFrameText;
      
      private var _nextLevel:FilterFrameText;
      
      private var _requireText:FilterFrameText;
      
      private var _consumeText:FilterFrameText;
      
      private var _tiptitle:FilterFrameText;
      
      private var _explain:FilterFrameText;
      
      private var _next:FilterFrameText;
      
      private var _require:FilterFrameText;
      
      private var _consume:FilterFrameText;
      
      private var _ok:TextButton;
      
      private var _cancel:TextButton;
      
      private var _buildId:int;
      
      private var _selectIndex:int;
      
      public function ConsortionUpGradeFrame(param1:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function _consortiaInfoChange(param1:PlayerPropertyEvent) : void{}
      
      private function setLeveText() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function showView(param1:int) : void{}
      
      private function __okHandler(param1:MouseEvent) : void{}
      
      private function __confirmResponse(param1:FrameEvent) : void{}
      
      private function sendUpGradeData() : void{}
      
      private function openRichesTip() : void{}
      
      private function __noEnoughHandler(param1:FrameEvent) : void{}
      
      private function checkGoldOrLevel() : Boolean{return false;}
      
      private function __quickBuyResponse(param1:FrameEvent) : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
