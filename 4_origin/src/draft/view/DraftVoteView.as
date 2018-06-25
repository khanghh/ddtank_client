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
      
      public function DraftVoteView(userid:int, id:int)
      {
         super();
         _userId = userid;
         _id = id;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.draft.voteView.bg");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.roundClosebt");
         PositionUtils.setPos(_closeBtn,"voteView.closeBtn.Pos");
         addChild(_closeBtn);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.textInfo");
         _infoText.text = LanguageMgr.GetTranslation("draftView.voteView.infoTxt");
         addChild(_infoText);
         _ticketInfo = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.ticketInfo");
         _ticketInfo.text = LanguageMgr.GetTranslation("draftView.voteView.ticketInfo");
         addChild(_ticketInfo);
         _ticketBg = ComponentFactory.Instance.creatComponentByStylename("draftView.pageInput");
         PositionUtils.setPos(_ticketBg,"voteView.ticketBg.Pos");
         addChild(_ticketBg);
         _ticketNum = ComponentFactory.Instance.creatComponentByStylename("draftView.pageTxt");
         _ticketNum.restrict = "0-9";
         PositionUtils.setPos(_ticketNum,"voteView.ticketNum.Pos");
         addChild(_ticketNum);
         _money = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.ticketInfo");
         PositionUtils.setPos(_money,"voteView.money.Pos");
         addChild(_money);
         setMoneyText();
         _noticeInfo = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.noticeInfo");
         _noticeInfo.text = LanguageMgr.GetTranslation("draftView.voteView.noticeInfo");
         addChild(_noticeInfo);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.confirmBtn");
         addChild(_confirmBtn);
         _selectBtn1 = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.ticketSelect");
         PositionUtils.setPos(_selectBtn1,"voteView.selectBtn.Pos1");
         addChild(_selectBtn1);
         _selectBtn2 = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.ticketSelect");
         PositionUtils.setPos(_selectBtn2,"voteView.selectBtn.Pos2");
         addChild(_selectBtn2);
         _selectBtn3 = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.ticketSelect");
         PositionUtils.setPos(_selectBtn3,"voteView.selectBtn.Pos3");
         addChild(_selectBtn3);
         _selectBtn4 = ComponentFactory.Instance.creatComponentByStylename("draftView.vote.ticketSelect");
         PositionUtils.setPos(_selectBtn4,"voteView.selectBtn.Pos4");
         addChild(_selectBtn4);
         _selectBtnGroup = new SelectedButtonGroup();
         _selectBtnGroup.addSelectItem(_selectBtn1);
         _selectBtnGroup.addSelectItem(_selectBtn2);
         _selectBtnGroup.addSelectItem(_selectBtn3);
         _selectBtnGroup.addSelectItem(_selectBtn4);
         _selectBtnGroup.selectIndex = 0;
         this.width = this.displayWidth;
         this.height = this.displayHeight;
      }
      
      private function initEvent() : void
      {
         addEventListener("keyDown",__onResponse);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _closeBtn.addEventListener("click",__onCloseClick);
         _ticketNum.addEventListener("change",__onTextInput);
         _selectBtnGroup.addEventListener("change",__onSelectedChange);
      }
      
      protected function __onTextInput(event:Event) : void
      {
         _voteNum = int(_ticketNum.text);
         if(_voteNum >= 999)
         {
            _ticketNum.text = "999";
            _voteNum = 999;
         }
         setMoneyText();
      }
      
      protected function __onResponse(event:KeyboardEvent) : void
      {
         if(event.keyCode == 27)
         {
            __onCloseClick(null);
         }
      }
      
      protected function __onSelectedChange(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         _ticketNum.type = "dynamic";
         if(_selectBtnGroup.selectIndex == 0)
         {
            _voteNum = 1;
         }
         else if(_selectBtnGroup.selectIndex == 1)
         {
            _voteNum = 10;
         }
         else if(_selectBtnGroup.selectIndex == 2)
         {
            _voteNum = 50;
         }
         else
         {
            _ticketNum.type = "input";
            _voteNum = 1;
            _ticketNum.text = _voteNum.toString();
         }
         setMoneyText();
      }
      
      private function setMoneyText() : void
      {
         _money.text = (300 * _voteNum).toString();
      }
      
      protected function __onConfirmClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         CheckMoneyUtils.instance.checkMoney(false,int(_money.text),onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         dispose();
         SocketManager.Instance.out.sendDraftVoteTicket(_voteNum,_id);
      }
      
      protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_infoText);
         _infoText = null;
         ObjectUtils.disposeObject(_ticketInfo);
         _ticketInfo = null;
         ObjectUtils.disposeObject(_ticketBg);
         _ticketBg = null;
         ObjectUtils.disposeObject(_ticketNum);
         _ticketNum = null;
         ObjectUtils.disposeObject(_money);
         _money = null;
         ObjectUtils.disposeObject(_noticeInfo);
         _noticeInfo = null;
         ObjectUtils.disposeObject(_selectBtn1);
         _selectBtn1 = null;
         ObjectUtils.disposeObject(_selectBtn2);
         _selectBtn2 = null;
         ObjectUtils.disposeObject(_selectBtn3);
         _selectBtn3 = null;
         ObjectUtils.disposeObject(_selectBtn4);
         _selectBtn4 = null;
         ObjectUtils.disposeObject(_selectBtnGroup);
         _selectBtnGroup = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("keyDown",__onResponse);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
         _closeBtn.removeEventListener("click",__onCloseClick);
         _ticketNum.removeEventListener("textInput",__onTextInput);
         _selectBtnGroup.removeEventListener("change",__onSelectedChange);
      }
   }
}
