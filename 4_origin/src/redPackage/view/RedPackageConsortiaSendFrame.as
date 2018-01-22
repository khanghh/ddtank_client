package redPackage.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import redPackage.RedPackageManager;
   
   public class RedPackageConsortiaSendFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _titleBmp:Bitmap;
      
      private var _moneyLabel:FilterFrameText;
      
      private var _moneyBG:Scale9CornerImage;
      
      private var _moneyTextField:FilterFrameText;
      
      private var _pkgNumberLabel:FilterFrameText;
      
      private var _pkgNumberSelecter:NumberSelecter;
      
      private var _wishWordsTextField:FilterFrameText;
      
      private var _wishWordsBG:Bitmap;
      
      private var _sendBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _isAverage:SelectedCheckButton;
      
      private var img:ScaleBitmapImage;
      
      private var _scrollPanel:ListPanel;
      
      private var content:Sprite;
      
      public function RedPackageConsortiaSendFrame()
      {
         super();
      }
      
      override public function set backgound(param1:DisplayObject) : void
      {
         .super.backgound = param1;
         (_backgound as MutipleImage).getChildAt(0)["getChildAt"](1)["alpha"] = 0;
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("redpkg.frameTitle.send");
         var _loc1_:ComponentFactory = ComponentFactory.Instance;
         _bg = _loc1_.creat("redpkg.consortionSend.Back");
         addToContent(_bg);
         img = ComponentFactory.Instance.creat("asset.core.btmBimap");
         img.height = 61;
         img.width = 350;
         img.x = 20;
         img.y = 290;
         addToContent(img);
         _titleBmp = _loc1_.creatBitmap("asset.redpkg.consortionSend.title");
         _titleBmp.x = 34;
         _titleBmp.y = 59;
         addToContent(_titleBmp);
         _moneyBG = _loc1_.creat("core.ddtshop.NumberSelecterTextBg");
         _moneyBG.x = 116;
         _moneyBG.y = 111;
         _moneyBG.width = 188;
         _moneyBG.height = 26;
         addToContent(_moneyBG);
         _moneyLabel = _loc1_.creat("redpkg.consortion.sendMoney.label");
         _moneyLabel.text = LanguageMgr.GetTranslation("redpkg.consortion.sendMoney.label");
         addToContent(_moneyLabel);
         _moneyTextField = _loc1_.creat("redpkg.consortion.sendMoney.txt");
         _moneyTextField.restrict = "0-9";
         _moneyTextField.maxChars = 5;
         _moneyTextField.text = "10";
         addToContent(_moneyTextField);
         _pkgNumberLabel = _loc1_.creat("redpkg.consortion.sendNumber.label");
         _pkgNumberLabel.text = LanguageMgr.GetTranslation("redpkg.consortion.sendNumber.label");
         addToContent(_pkgNumberLabel);
         _pkgNumberSelecter = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         _pkgNumberSelecter.needFocus = false;
         _pkgNumberSelecter.minimum = 1;
         _pkgNumberSelecter.bg.height = 26;
         _pkgNumberSelecter.bg.y = 2;
         _pkgNumberSelecter.x = 175;
         _pkgNumberSelecter.y = 144;
         _pkgNumberSelecter.maximum = 200;
         addToContent(_pkgNumberSelecter);
         _wishWordsBG = _loc1_.creat("asset.consortionSend.detail.bottom");
         _wishWordsBG.x = 32;
         _wishWordsBG.y = 173;
         addToContent(_wishWordsBG);
         _wishWordsTextField = _loc1_.creat("redpkg.consortion.detail.txt");
         _wishWordsTextField.text = LanguageMgr.GetTranslation("redpkg.consortion.send.detail");
         _wishWordsTextField.type = "input";
         _wishWordsTextField.multiline = true;
         _wishWordsTextField.maxChars = 23;
         _wishWordsTextField.selectable = true;
         addToContent(_wishWordsTextField);
         _sendBtn = _loc1_.creat("redpkg.consortionSend.sendBtn");
         addToContent(_sendBtn);
         _isAverage = ComponentFactory.Instance.creatComponentByStylename("redpkg.consortionSend.CheckButton");
         _isAverage.text = LanguageMgr.GetTranslation("ddt.consortion.AverageText");
         addToContent(_isAverage);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("redpkg.help.scrollPanel");
         _scrollPanel.vectorListModel.clear();
         _scrollPanel.vectorListModel.appendAll([{}]);
         _scrollPanel.list.updateListView();
         content = new Sprite();
         content.addChild(_scrollPanel);
         PositionUtils.setPos(content,"redpkg.HelpContentPos");
         addEvents();
      }
      
      private function addEvents() : void
      {
         _sendBtn.addEventListener("click",onSendBtnClick);
         addEventListener("response",_response);
         this.addEventListener("addedToStage",onATS);
      }
      
      protected function onATS(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onATS);
         StageReferance.stage.focus = _sendBtn;
         escEnable = true;
      }
      
      protected function onSendBtnClick(param1:MouseEvent) : void
      {
         e = param1;
         _sendBtn.enable = false;
         SoundManager.instance.play("008");
         TweenLite.delayedCall(1.5,function():void
         {
         });
         if(int(_moneyTextField.text) < 200)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("redpkg.consortion.alart.moneyCount"),0,false,1.5);
            return;
         }
         if(_pkgNumberSelecter.number > Number(_moneyTextField.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("redpkg.consortion.alart.numberError"),0,false,1.5);
            return;
         }
         if(_pkgNumberSelecter.number < 10)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("redpkg.consortion.alart.kgNumberSelecterError"),0,false,1.5);
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_wishWordsTextField.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("redpkg.consortion.alart.useWord"),0,false,1.5);
            return;
         }
         RedPackageManager.getInstance().onConsortionMakePackage(int(_moneyTextField.text),_pkgNumberSelecter.number,_wishWordsTextField.text.replace(/[\t\n]/g,""),_isAverage.selected);
      }
      
      private function removeEvents() : void
      {
         _sendBtn.removeEventListener("click",onSendBtnClick);
         removeEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_titleBmp != null)
         {
            ObjectUtils.disposeObject(_titleBmp);
            _titleBmp = null;
         }
         if(_moneyLabel != null)
         {
            ObjectUtils.disposeObject(_moneyLabel);
            _moneyLabel = null;
         }
         if(_moneyBG != null)
         {
            ObjectUtils.disposeObject(_moneyBG);
            _moneyBG = null;
         }
         if(_moneyTextField != null)
         {
            ObjectUtils.disposeObject(_moneyTextField);
            _moneyTextField = null;
         }
         if(_pkgNumberLabel != null)
         {
            ObjectUtils.disposeObject(_pkgNumberLabel);
            _pkgNumberLabel = null;
         }
         _pkgNumberSelecter = null;
         if(_wishWordsTextField != null)
         {
            ObjectUtils.disposeObject(_wishWordsTextField);
            _wishWordsTextField = null;
         }
         if(_isAverage)
         {
            ObjectUtils.disposeObject(_isAverage);
         }
         _isAverage = null;
         if(_wishWordsBG != null)
         {
            ObjectUtils.disposeObject(_wishWordsBG);
            _wishWordsBG = null;
         }
         if(_sendBtn != null)
         {
            ObjectUtils.disposeObject(_sendBtn);
            _sendBtn = null;
         }
         if(_helpBtn != null)
         {
            ObjectUtils.disposeObject(_helpBtn);
            _helpBtn = null;
         }
         if(img != null)
         {
            ObjectUtils.disposeObject(img);
            img = null;
         }
      }
   }
}
