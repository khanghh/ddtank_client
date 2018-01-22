package draft.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DraftVoteView extends Component implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _infoText:FilterFrameText;
      
      private var _ticketInfo:FilterFrameText;
      
      private var _ticketBg:Scale9CornerImage;
      
      private var _ticketNum:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _noticeInfo:FilterFrameText;
      
      private var _confirmBtn:SimpleBitmapButton;
      
      private var _selectBtnGroup:SelectedButtonGroup;
      
      private var _selectBtn1:SelectedButton;
      
      private var _selectBtn2:SelectedButton;
      
      private var _selectBtn3:SelectedButton;
      
      private var _selectBtn4:SelectedButton;
      
      private var _voteNum:int = 1;
      
      private var _userId:int;
      
      public function DraftVoteView(param1:int, param2:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onTextInput(param1:Event) : void{}
      
      protected function __onResponse(param1:KeyboardEvent) : void{}
      
      protected function __onSelectedChange(param1:Event) : void{}
      
      private function setMoneyText() : void{}
      
      protected function __onConfirmClick(param1:MouseEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      protected function __onCloseClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
      
      private function removeEvent() : void{}
   }
}
