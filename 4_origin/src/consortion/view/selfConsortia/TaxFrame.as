package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class TaxFrame extends Frame
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _ownMoney:FilterFrameText;
      
      private var _moneyForRiches:FilterFrameText;
      
      private var _taxMoney:TextInput;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      private var leaveToFillAlert:BaseAlerFrame;
      
      private var confirmAlert:BaseAlerFrame;
      
      private var _textWord1:FilterFrameText;
      
      private var _textWord2:FilterFrameText;
      
      public function TaxFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         enterEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.TaxFrame.titleText");
         _textWord1 = ComponentFactory.Instance.creat("consortion.taskFrame.textWordI");
         _textWord1.text = LanguageMgr.GetTranslation("consortion.taskFrame.textWordI.text");
         _textWord2 = ComponentFactory.Instance.creat("consortion.taskFrame.textWordII");
         _textWord2.text = LanguageMgr.GetTranslation("consortion.taskFrame.textWordII.text");
         _bg = ComponentFactory.Instance.creat("consortion.MyConsortiaTax.taxBG");
         _ownMoney = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.totalTicketTxt");
         _moneyForRiches = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.totalMoneyTxt");
         _taxMoney = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.input");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("core.TaxFrame.okBtn");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("core.TaxFrame.cancelBtn");
         addToContent(_textWord1);
         addToContent(_textWord2);
         addToContent(_bg);
         addToContent(_ownMoney);
         addToContent(_moneyForRiches);
         addToContent(_taxMoney);
         addToContent(_confirm);
         addToContent(_cancel);
         _taxMoney.textField.restrict = "0-9";
         _taxMoney.textField.maxChars = 8;
         _confirm.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _confirm.enable = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         addEventListener("response",__responseHanlder);
         _confirm.addEventListener("click",__confirmHanlder);
         _cancel.addEventListener("click",__cancelHandler);
         _taxMoney.addEventListener("change",__taxChangeHandler);
         _taxMoney.addEventListener("keyDown",__enterHanlder);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         removeEventListener("response",__responseHanlder);
         _confirm.removeEventListener("click",__confirmHanlder);
         _cancel.removeEventListener("click",__cancelHandler);
         _taxMoney.removeEventListener("change",__taxChangeHandler);
         _taxMoney.removeEventListener("keyDown",__enterHanlder);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _taxMoney.setFocus();
         _ownMoney.text = String(PlayerManager.Instance.Self.Money);
         _moneyForRiches.text = "0";
         _taxMoney.text = "";
      }
      
      private function __responseHanlder(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      private function __confirmHanlder(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = _taxMoney.text;
         if(BuriedManager.Instance.checkMoney(false,_loc2_))
         {
            return;
         }
         if(Number(_taxMoney.text) < 2)
         {
            _taxMoney.text = "";
            _confirm.enable = false;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.input"));
         }
         else
         {
            confirmAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.sure"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            confirmAlert.addEventListener("response",__alertResponse);
         }
      }
      
      private function __alertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_loc2_ == leaveToFillAlert)
            {
               LeavePageManager.leaveToFillPath();
            }
            else if(_loc2_ == confirmAlert)
            {
               sendSocketData();
            }
         }
         _loc2_.removeEventListener("response",__alertResponse);
         ObjectUtils.disposeObject(_loc2_);
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      private function sendSocketData() : void
      {
         var _loc1_:int = 0;
         if(_taxMoney != null)
         {
            _loc1_ = _taxMoney.text;
            SocketManager.Instance.out.sendConsortiaRichOffer(_loc1_);
            dispose();
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __taxChangeHandler(param1:Event) : void
      {
         if(_taxMoney.text == "")
         {
            _confirm.enable = false;
            _moneyForRiches.text = "0";
            return;
         }
         if(_taxMoney.text == "0")
         {
            _taxMoney.text = "";
            return;
         }
         _confirm.enable = true;
         var _loc2_:int = _taxMoney.text;
         if(_loc2_ >= PlayerManager.Instance.Self.Money)
         {
            _taxMoney.text = String(PlayerManager.Instance.Self.Money);
         }
         _moneyForRiches.text = String(int(Math.floor(_taxMoney.text / 2)));
      }
      
      private function __enterHanlder(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         if(param1.keyCode == 13)
         {
            __confirmHanlder(null);
         }
         if(param1.keyCode == 27)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _textWord1 = null;
         _textWord2 = null;
         _bg.dispose();
         _bg = null;
         _ownMoney = null;
         _moneyForRiches = null;
         _taxMoney = null;
         _confirm = null;
         _cancel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
