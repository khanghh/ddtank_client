package ddt.view.common.church
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ChurchProposeFrame extends BaseAlerFrame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _alertInfo:AlertInfo;
      
      private var _txtInfo:TextArea;
      
      private var _chkSysMsg:SelectedIconButton;
      
      private var _maxChar:FilterFrameText;
      
      private var _buyRingFrame:ChurchBuyRingFrame;
      
      private var _spouseID:int;
      
      private var useBugle:Boolean;
      
      private var _bgTitleText:FilterFrameText;
      
      private var _surplusCharText:FilterFrameText;
      
      private var _noticeText:FilterFrameText;
      
      private var _blessingText:FilterFrameText;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      public function ChurchProposeFrame()
      {
         super();
         initialize();
         addEvent();
      }
      
      public function get spouseID() : int
      {
         return _spouseID;
      }
      
      public function set spouseID(param1:int) : void
      {
         _spouseID = param1;
      }
      
      private function initialize() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.view.common.church.ProposeResponseFrame.titleText");
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("church.ChurchProposeFrame.bg");
         addToContent(_bg);
         _bgTitleText = ComponentFactory.Instance.creat("church.ChurchProposeFrame.bgTitleText");
         _bgTitleText.text = LanguageMgr.GetTranslation("church.ChurchProposeFrame.bgTitleText.text");
         addToContent(_bgTitleText);
         _surplusCharText = ComponentFactory.Instance.creat("church.ChurchProposeFrame.surplusCharText");
         _surplusCharText.text = LanguageMgr.GetTranslation("church.ChurchProposeFrame.surplusCharText.text");
         addToContent(_surplusCharText);
         _noticeText = ComponentFactory.Instance.creat("church.ChurchProposeFrame.noticeText");
         _noticeText.text = LanguageMgr.GetTranslation("church.ChurchProposeFrame.noticeText.text");
         addToContent(_noticeText);
         _blessingText = ComponentFactory.Instance.creat("church.ChurchProposeFrame.blessingText");
         _blessingText.text = LanguageMgr.GetTranslation("church.ChurchProposeFrame.blessingText.text");
         addToContent(_blessingText);
         _txtInfo = ComponentFactory.Instance.creat("common.church.txtChurchProposeFrameAsset");
         _txtInfo.maxChars = 300;
         addToContent(_txtInfo);
         _chkSysMsg = ComponentFactory.Instance.creat("common.church.chkChurchProposeFrameAsset");
         _chkSysMsg.selected = true;
         addToContent(_chkSysMsg);
         _maxChar = ComponentFactory.Instance.creat("common.church.churchProposeMaxCharAsset");
         _maxChar.text = "300";
         addToContent(_maxChar);
         useBugle = _chkSysMsg.selected;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",onFrameResponse);
         _chkSysMsg.addEventListener("select",__checkClick);
         _chkSysMsg.addEventListener("click",getFocus);
         _txtInfo.addEventListener("change",__input);
         _txtInfo.addEventListener("addedToStage",__addToStages);
      }
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               SoundManager.instance.play("008");
               if(PathManager.solveChurchEnable())
               {
                  confirmSubmit();
                  break;
               }
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",onFrameResponse);
         _chkSysMsg.removeEventListener("change",__checkClick);
         _chkSysMsg.removeEventListener("click",getFocus);
         _txtInfo.removeEventListener("change",__input);
         _txtInfo.removeEventListener("addedToStage",__addToStages);
      }
      
      private function __checkClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
         useBugle = _chkSysMsg.selected;
      }
      
      private function getFocus(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(stage)
         {
            stage.focus = this;
         }
      }
      
      private function __addToStages(param1:Event) : void
      {
         _txtInfo.stage.focus = _txtInfo;
         _txtInfo.text = "";
      }
      
      private function __input(param1:Event) : void
      {
         var _loc2_:int = _txtInfo.text.length;
         _maxChar.text = String(300 - _loc2_);
      }
      
      private function confirmSubmit() : void
      {
         var _loc1_:* = null;
         if(!PlayerManager.Instance.Self.getBag(1).findFistItemByTemplateId(11103))
         {
            _loc1_ = FilterWordManager.filterWrod(_txtInfo.text);
            _buyRingFrame = ComponentFactory.Instance.creat("common.church.ChurchBuyRingFrame");
            _buyRingFrame.addEventListener("close",buyRingFrameClose);
            _buyRingFrame.spouseID = spouseID;
            _buyRingFrame.proposeStr = _loc1_;
            _buyRingFrame.useBugle = _chkSysMsg.selected;
            _buyRingFrame.titleText = "Gợi ý";
            _buyRingFrame.show();
            dispose();
            return;
         }
         sendPropose();
      }
      
      private function sendPropose() : void
      {
         var _loc1_:String = FilterWordManager.filterWrod(_txtInfo.text);
         SocketManager.Instance.out.sendPropose(_spouseID,_loc1_,useBugle,false);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1,true);
      }
      
      private function buyRingFrameClose(param1:Event) : void
      {
         if(_buyRingFrame)
         {
            _buyRingFrame.removeEventListener("close",buyRingFrameClose);
            if(_buyRingFrame.parent)
            {
               _buyRingFrame.parent.removeChild(_buyRingFrame);
            }
            _buyRingFrame.dispose();
         }
         _buyRingFrame = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bg)
         {
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
         }
         _bg = null;
         _bgTitleText = null;
         _surplusCharText = null;
         _noticeText = null;
         _blessingText = null;
         _txtInfo = null;
         if(_chkSysMsg)
         {
            if(_chkSysMsg.parent)
            {
               _chkSysMsg.parent.removeChild(_chkSysMsg);
            }
            _chkSysMsg.dispose();
         }
         _chkSysMsg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
   }
}
