package consortion.view.club
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.analyze.ReworkNameAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.RequestVairableCreater;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import road7th.utils.StringHelper;
   
   public class CreateConsortionFrame extends Frame
   {
      
      public static const MIN_CREAT_CONSROTIA_LEVEL:int = 17;
      
      public static const MIN_CREAT_CONSORTIA_MONEY:int = 500;
      
      public static const MIN_CREAT_CONSORTIA_GOLD:int = int(ServerConfigManager.instance.CreateGuild);
       
      
      private var _bg:Bitmap;
      
      private var _input:TextInput;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _img:MutipleImage;
      
      private var _conditionText:FilterFrameText;
      
      private var _ticketText1:FilterFrameText;
      
      private var _ticketText2:FilterFrameText;
      
      private var _gradeText1:FilterFrameText;
      
      private var _gradeText2:FilterFrameText;
      
      private var _moneyText1:FilterFrameText;
      
      private var _moneyText2:FilterFrameText;
      
      private var _goldAlertFrame:BaseAlerFrame;
      
      private var _moneyAlertFrame:BaseAlerFrame;
      
      private var _quickBuyFrame:QuickBuyFrame;
      
      public function CreateConsortionFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.club.CreatConsortiaFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.createConsortionFrame.BG");
         _input = ComponentFactory.Instance.creatComponentByStylename("club.createConsortion.input");
         _img = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.img");
         _conditionText = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.conditionText");
         _conditionText.text = LanguageMgr.GetTranslation("createConsortionFrame.conditionText.Text");
         _ticketText1 = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.ticketText1");
         _ticketText1.htmlText = LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text1");
         _gradeText2 = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.gradeText2");
         _gradeText2.htmlText = LanguageMgr.GetTranslation("createConsortionFrame.gradeText.Text2");
         _moneyText1 = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.moneyText1");
         _moneyText1.htmlText = LanguageMgr.GetTranslation("createConsortionFrame.moneyText.Text1",ServerConfigManager.instance.CreateGuild);
         _ticketText2 = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.ticketText2");
         _ticketText2.text = LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2");
         _gradeText1 = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.gradeText1");
         _gradeText1.text = LanguageMgr.GetTranslation("createConsortionFrame.gradeText.Text1");
         _moneyText2 = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.moneyText2");
         _moneyText2.text = LanguageMgr.GetTranslation("gold");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.OKBtn");
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("createConsortionFrame.cancelBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         addToContent(_bg);
         addToContent(_input);
         addToContent(_img);
         addToContent(_conditionText);
         addToContent(_ticketText1);
         addToContent(_ticketText2);
         addToContent(_gradeText1);
         addToContent(_gradeText2);
         addToContent(_moneyText1);
         addToContent(_moneyText2);
         addToContent(_okBtn);
         addToContent(_cancelBtn);
         _okBtn.enable = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("addedToStage",__addToStageHandler);
         addEventListener("response",__responseHandler);
         _okBtn.addEventListener("click",__okFun);
         _cancelBtn.addEventListener("click",__cancelFun);
         _input.addEventListener("change",__inputHandler);
         _input.addEventListener("keyDown",__keyboardHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         removeEventListener("response",__responseHandler);
         if(_okBtn)
         {
            _okBtn.removeEventListener("click",__okFun);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelFun);
         }
         if(_input)
         {
            _input.removeEventListener("change",__inputHandler);
         }
         if(_input)
         {
            _input.removeEventListener("keyDown",__keyboardHandler);
         }
      }
      
      private function createAction() : void
      {
         _input.text = StringHelper.trim(_input.text);
         if(BuriedManager.Instance.checkMoney(false,500))
         {
            return;
         }
         if(PlayerManager.Instance.Self.Gold < MIN_CREAT_CONSORTIA_GOLD)
         {
            _goldAlertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _goldAlertFrame.moveEnable = false;
            _goldAlertFrame.addEventListener("response",__quickBuyResponse);
            _okBtn.enable = true;
            return;
         }
         if(!checkCanCreatConsortia())
         {
            _okBtn.enable = true;
            return;
         }
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["NickName"] = _input.text;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ConsortiaNameCheck.ashx"),6,args);
         loader.analyzer = new ReworkNameAnalyzer(checkCallBack);
         loader.addEventListener("loadError",__onLoadError);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function sendName() : void
      {
         if(_input)
         {
            SocketManager.Instance.out.sendCreateConsortia(_input.text,false);
         }
         dispose();
      }
      
      public function checkCallBack(analyzer:ReworkNameAnalyzer) : void
      {
         var result:XML = analyzer.result;
         if(result.@value == "true")
         {
            sendName();
         }
         else
         {
            _okBtn.enable = true;
            MessageTipManager.getInstance().show(result.@message);
         }
      }
      
      private function __onLoadError(evt:LoaderEvent) : void
      {
      }
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         event.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __quickBuyResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _goldAlertFrame.removeEventListener("response",__quickBuyResponse);
         _goldAlertFrame.dispose();
         _goldAlertFrame = null;
         if(evt.responseCode == 3)
         {
            _quickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quickBuyFrame.itemID = 11233;
            _quickBuyFrame.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(_quickBuyFrame,3,true,1);
         }
      }
      
      private function checkCanCreatConsortia() : Boolean
      {
         if(_input.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.CreatConsortiaFrame.inputPlease"));
            return false;
         }
         if(PlayerManager.Instance.Self.Grade < 17)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.CreatConsortiaFrame.yourGrade"));
            return false;
         }
         if(FilterWordManager.isGotForbiddenWords(_input.text,"name"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.CreatConsortiaFrame.consortiaName"));
            return false;
         }
         return true;
      }
      
      private function __addToStageHandler(event:Event) : void
      {
         _input.setFocus();
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               createAction();
         }
      }
      
      private function __okFun(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         createAction();
      }
      
      private function __cancelFun(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __inputHandler(event:Event) : void
      {
         if(_input.text != "")
         {
            _okBtn.enable = true;
         }
         else
         {
            _okBtn.enable = false;
         }
         StringHelper.checkTextFieldLength(_input.textField,12);
      }
      
      private function __keyboardHandler(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            createAction();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _input = null;
         _img = null;
         _conditionText = null;
         _ticketText1 = null;
         _gradeText1 = null;
         _moneyText1 = null;
         _ticketText2 = null;
         _gradeText2 = null;
         _moneyText2 = null;
         _okBtn = null;
         _cancelBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
