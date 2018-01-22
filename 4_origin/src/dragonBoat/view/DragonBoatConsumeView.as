package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DragonBoatConsumeView extends BaseAlerFrame
   {
       
      
      private var _item:InventoryItemInfo;
      
      private var _itemMax:int;
      
      private var _txt:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _bottomPromptTxt:FilterFrameText;
      
      private var _textWord1:FilterFrameText;
      
      private var _ownMoney:FilterFrameText;
      
      private var _ownMoney2:FilterFrameText;
      
      private var _tag:int;
      
      public function DragonBoatConsumeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var _loc1_:AlertInfo = new AlertInfo("",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _loc1_.moveEnable = false;
         _loc1_.autoDispose = false;
         _loc1_.sound = "008";
         info = _loc1_;
         _textWord1 = ComponentFactory.Instance.creat("consortion.taskFrame.textWordI");
         PositionUtils.setPos(_textWord1,"dragonBoat.mainFrame.consumeView.textWord1Pos");
         _textWord1.text = LanguageMgr.GetTranslation("ddt.dragonBoat.highPromptTxt1");
         _ownMoney = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.totalTicketTxt");
         PositionUtils.setPos(_ownMoney,"dragonBoat.mainFrame.consumeView.ownMoneyPos");
         _ownMoney.text = String(PlayerManager.Instance.Self.Money);
         _txt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalPromptTxt");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.normal.inputBg");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalInputTxt");
         _inputText.text = "1";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normal.maxBtn");
         _bottomPromptTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.consumePromptTxt2");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalPromptTxt");
         _ownMoney2 = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.totalTicketTxt");
         PositionUtils.setPos(_ownMoney2,"dragonBoat.mainFrame.consumeView.ownMoneyPos2");
         addToContent(_textWord1);
         addToContent(_ownMoney);
         addToContent(_txt);
         addToContent(_inputBg);
         addToContent(_inputText);
         addToContent(_txt2);
         addToContent(_ownMoney2);
         addToContent(_maxBtn);
         addToContent(_bottomPromptTxt);
      }
      
      public function setView(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _tag = param1;
         if(_tag == 1 || _tag == 2)
         {
            _loc3_ = ServerConfigManager.instance.getDragonboatProp;
            _item = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(_loc3_);
            _itemMax = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc3_,false);
            _loc2_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201309,true);
            if(_loc2_ > 0)
            {
               _itemMax = _itemMax + _loc2_;
            }
            _textWord1.visible = false;
            _ownMoney.visible = false;
            _maxBtn.visible = true;
            if(DragonBoatManager.instance.activeInfo.ActiveID == 1)
            {
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.normalPromptTxt2");
            }
            else
            {
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.normalPromptTxt2_II");
            }
            if(_tag == 1)
            {
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.normalBuildTxt");
               _txt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.normalPromptTxt");
               _txt.x = 28;
               _bottomPromptTxt.x = 95;
            }
            else
            {
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.normalDecorateTxt");
               _txt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.normalPromptTxt");
            }
         }
         else
         {
            highViewSet();
            if(_tag == 3)
            {
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.highBuildTxt");
               _txt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.highPromptTxt2");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.highPromptTxt3");
               _txt2.text = LanguageMgr.GetTranslation("ddt.dragonBoat.priceFrameMsg");
               _ownMoney2.text = int(_inputText.text) * 100 + "";
               _txt.x = 25;
               _txt2.x = 274;
               _txt2.y = 88;
               _inputBg.x = 150;
               _inputText.x = 150;
               _bottomPromptTxt.x = 40;
            }
            else
            {
               titleText = LanguageMgr.GetTranslation("ddt.dragonBoat.highDecorateTxt");
               _txt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.highPromptTxt22");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("ddt.dragonBoat.highPromptTxt32");
            }
         }
      }
      
      private function highViewSet() : void
      {
         _textWord1.visible = true;
         _ownMoney.visible = true;
         _maxBtn.visible = false;
         _bottomPromptTxt.x = 40;
         _bottomPromptTxt.y = 121;
         _txt.x = 42;
         _txt.y = 88;
         _inputBg.x = 203;
         _inputBg.y = 84;
         _inputText.x = 203;
         _inputText.y = 89;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler,false,0,true);
         _maxBtn.addEventListener("click",changeMaxHandler,false,0,true);
         _inputText.addEventListener("change",inputTextChangeHandler,false,0,true);
         _inputText.addEventListener("keyDown",inputKeyDownHandler,false,0,true);
      }
      
      private function changeMaxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_item)
         {
            _inputText.text = _itemMax.toString();
         }
      }
      
      private function inputTextChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _inputText.text;
         if(_loc2_ < 1)
         {
            _inputText.text = "1";
         }
         if(_item)
         {
            if(_loc2_ > _itemMax)
            {
               _inputText.text = _itemMax.toString();
            }
         }
         if(_tag == 3)
         {
            _ownMoney2.text = int(_inputText.text) * 100 + "";
         }
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               enterKeyHandler();
         }
      }
      
      private function enterKeyHandler() : void
      {
         var _loc1_:int = 0;
         if(_tag == 1 || _tag == 2)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 2;
         }
         SocketManager.Instance.out.sendDragonBoatBuildOrDecorate(_loc1_,int(_inputText.text));
         dispose();
      }
      
      private function inputKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            enterKeyHandler();
         }
         else if(param1.keyCode == 27)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _maxBtn.removeEventListener("click",changeMaxHandler);
         _inputText.removeEventListener("change",inputTextChangeHandler);
         _inputText.removeEventListener("keyDown",inputKeyDownHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _item = null;
         _txt = null;
         _inputBg = null;
         _inputText = null;
         _maxBtn = null;
         _bottomPromptTxt = null;
         _textWord1 = null;
         _ownMoney = null;
      }
   }
}
