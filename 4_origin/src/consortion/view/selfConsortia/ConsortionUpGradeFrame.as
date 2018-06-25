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
      
      public function ConsortionUpGradeFrame(buildId:int)
      {
         super();
         _buildId = buildId;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         _wordAndbmp1 = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.bmp1");
         _wordAndBmp2 = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.bmp2");
         addToContent(_wordAndbmp1);
         addToContent(_wordAndBmp2);
         if(_buildId == 5)
         {
            _level = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.level");
            _levelTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.levelTxt");
            _levelTxt.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.levelTxt.text");
            _levelNum = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.levelNum");
            addToContent(_level);
            addToContent(_levelTxt);
            addToContent(_levelNum);
            _selectIndex = 0;
         }
         else if(_buildId == 4)
         {
            _store = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.store");
            _storeTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.storTxt");
            _storeTxt.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.storTxt.text");
            _storeNum = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.storeNum");
            addToContent(_store);
            addToContent(_storeTxt);
            addToContent(_storeNum);
            _selectIndex = 1;
         }
         else if(_buildId == 3)
         {
            _shop = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.shop");
            _shopTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.shopTxt");
            _shopTxt.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.shopTxt.text");
            _shopNum = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.shopNum");
            addToContent(_shop);
            addToContent(_shopTxt);
            addToContent(_shopNum);
            _selectIndex = 2;
         }
         else if(_buildId == 1)
         {
            _bank = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.bank");
            _bankTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.boxTxt");
            _bankTxt.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.boxTxt.text");
            _bankNum = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.bankNum");
            addToContent(_bank);
            addToContent(_bankTxt);
            addToContent(_bankNum);
            _selectIndex = 3;
         }
         else if(_buildId == 2)
         {
            _skill = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.skill");
            _skillTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.skillTxt");
            _skillTxt.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.skillTxt.text");
            _skillNum = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.skillNum");
            addToContent(_skill);
            addToContent(_skillTxt);
            addToContent(_skillNum);
            _selectIndex = 4;
         }
         _explainWord = ComponentFactory.Instance.creatComponentByStylename("consortion.upGrade.explainWord");
         _explainWord.text = LanguageMgr.GetTranslation("consortion.upGrade.explainWord.text");
         _nextLevel = ComponentFactory.Instance.creatComponentByStylename("consortion.upGrade.nextLevel");
         _nextLevel.text = LanguageMgr.GetTranslation("consortion.upGrade.nextLevel.text");
         _requireText = ComponentFactory.Instance.creatComponentByStylename("consortion.upGrade.require");
         _requireText.text = LanguageMgr.GetTranslation("consortion.upGrade.require.text");
         _consumeText = ComponentFactory.Instance.creatComponentByStylename("consortion.upGrade.consume");
         _consumeText.text = LanguageMgr.GetTranslation("consortion.upGrade.consume.text");
         _tiptitle = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.title");
         _explain = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.explain");
         _next = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.next");
         _require = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.require");
         _consume = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.consume");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.ok");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("consortion.upGradeFrame.cancel");
         addToContent(_explainWord);
         addToContent(_nextLevel);
         addToContent(_requireText);
         addToContent(_consumeText);
         addToContent(_tiptitle);
         addToContent(_explain);
         addToContent(_next);
         addToContent(_require);
         addToContent(_consume);
         addToContent(_ok);
         addToContent(_cancel);
         _ok.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.okLabel");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         setLeveText();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _ok.addEventListener("click",__okHandler);
         _cancel.addEventListener("click",__cancelHandler);
         PlayerManager.Instance.Self.consortiaInfo.addEventListener("propertychange",_consortiaInfoChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _ok.removeEventListener("click",__okHandler);
         _cancel.removeEventListener("click",__cancelHandler);
         PlayerManager.Instance.Self.consortiaInfo.removeEventListener("propertychange",_consortiaInfoChange);
      }
      
      private function _consortiaInfoChange(event:PlayerPropertyEvent) : void
      {
         setLeveText();
      }
      
      private function setLeveText() : void
      {
         if(_selectIndex == 0)
         {
            _levelNum.text = String(PlayerManager.Instance.Self.consortiaInfo.Level);
         }
         else if(_selectIndex == 1)
         {
            _storeNum.text = String(PlayerManager.Instance.Self.consortiaInfo.SmithLevel);
         }
         else if(_selectIndex == 2)
         {
            _shopNum.text = String(PlayerManager.Instance.Self.consortiaInfo.ShopLevel);
         }
         else if(_selectIndex == 3)
         {
            _bankNum.text = String(PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
         }
         else if(_selectIndex == 4)
         {
            _skillNum.text = String(PlayerManager.Instance.Self.consortiaInfo.BufferLevel);
         }
         showView(_selectIndex);
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function showView(type:int) : void
      {
         var frameTitle:* = null;
         var data:Vector.<String> = new Vector.<String>();
         switch(int(type))
         {
            case 0:
               frameTitle = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.titleText");
               data = ConsortionModelManager.Instance.model.getLevelString(0,PlayerManager.Instance.Self.consortiaInfo.Level);
               if(PlayerManager.Instance.Self.consortiaInfo.Level >= 10)
               {
                  _ok.enable = false;
               }
               else
               {
                  _ok.enable = true;
               }
               break;
            case 1:
               frameTitle = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.storeUpgrade");
               data = ConsortionModelManager.Instance.model.getLevelString(2,PlayerManager.Instance.Self.consortiaInfo.SmithLevel);
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel >= 10)
               {
                  _ok.enable = false;
               }
               else
               {
                  _ok.enable = true;
               }
               break;
            case 2:
               frameTitle = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaShopUpgrade");
               data = ConsortionModelManager.Instance.model.getLevelString(1,PlayerManager.Instance.Self.consortiaInfo.ShopLevel);
               if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel >= 5)
               {
                  _ok.enable = false;
               }
               else
               {
                  _ok.enable = true;
               }
               break;
            case 3:
               frameTitle = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaSmithUpgrade");
               data = ConsortionModelManager.Instance.model.getLevelString(3,PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel >= 10)
               {
                  _ok.enable = false;
               }
               else
               {
                  _ok.enable = true;
               }
               break;
            case 4:
               frameTitle = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaSkillUpgrade");
               data = ConsortionModelManager.Instance.model.getLevelString(4,PlayerManager.Instance.Self.consortiaInfo.BufferLevel);
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel >= 10)
               {
                  _ok.enable = false;
               }
               else
               {
                  _ok.enable = true;
               }
         }
         titleText = frameTitle;
         _tiptitle.text = frameTitle;
         _explain.text = data[0];
         _next.text = data[1];
         _require.text = data[2];
         _consume.htmlText = data[3];
      }
      
      private function __okHandler(event:MouseEvent) : void
      {
         var confirm:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(!ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(_selectIndex))
         {
            openRichesTip();
            return;
         }
         if(checkGoldOrLevel())
         {
            switch(int(_selectIndex))
            {
               case 0:
                  confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.sure"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
                  confirm.moveEnable = false;
                  confirm.addEventListener("response",__confirmResponse);
                  break;
               case 1:
                  confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.CONSORTIASMITHGRADE"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
                  confirm.moveEnable = false;
                  confirm.addEventListener("response",__confirmResponse);
                  break;
               case 2:
                  confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.CONSORTIASHOPGRADE"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
                  confirm.moveEnable = false;
                  confirm.addEventListener("response",__confirmResponse);
                  break;
               case 3:
                  confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.CONSORTIASTOREGRADE"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
                  confirm.moveEnable = false;
                  confirm.addEventListener("response",__confirmResponse);
                  break;
               case 4:
                  confirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.CONSORTIASKILLGRADE"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
                  confirm.moveEnable = false;
                  confirm.addEventListener("response",__confirmResponse);
            }
         }
      }
      
      private function __confirmResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__confirmResponse);
         ObjectUtils.disposeObject(frame);
         if(frame && frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         frame = null;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            sendUpGradeData();
         }
      }
      
      private function sendUpGradeData() : void
      {
         switch(int(_selectIndex))
         {
            case 0:
               SocketManager.Instance.out.sendConsortiaLevelUp(1);
               break;
            case 1:
               SocketManager.Instance.out.sendConsortiaLevelUp(4);
               break;
            case 2:
               SocketManager.Instance.out.sendConsortiaLevelUp(3);
               break;
            case 3:
               SocketManager.Instance.out.sendConsortiaLevelUp(2);
               break;
            case 4:
               SocketManager.Instance.out.sendConsortiaLevelUp(5);
         }
      }
      
      private function openRichesTip() : void
      {
         SoundManager.instance.play("047");
         var enoughFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortion.skillItem.click.enough1"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
         enoughFrame.addEventListener("response",__noEnoughHandler);
      }
      
      private function __noEnoughHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               ConsortionModelManager.Instance.alertTaxFrame();
         }
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__noEnoughHandler);
         frame.dispose();
         frame = null;
      }
      
      private function checkGoldOrLevel() : Boolean
      {
         var goldAlert:* = null;
         switch(int(_selectIndex))
         {
            case 0:
               if(PlayerManager.Instance.Self.consortiaInfo.Level >= 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaLevel"));
                  return false;
               }
               break;
            case 1:
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel >= 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.store"));
                  return false;
               }
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel >= PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.pleaseUpgrade"));
                  return false;
               }
               break;
            case 2:
               if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel >= 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.consortiaShopLevel"));
                  return false;
               }
               if((PlayerManager.Instance.Self.consortiaInfo.ShopLevel + 1) * 2 > PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.pleaseUpgrade"));
                  return false;
               }
               break;
            case 3:
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel >= 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.smith"));
                  return false;
               }
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel >= PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.pleaseUpgrade"));
                  return false;
               }
               break;
            case 4:
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel >= 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.skill"));
                  break;
               }
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel >= PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.pleaseUpgrade"));
                  return false;
               }
               break;
         }
         if(_selectIndex == 0 && PlayerManager.Instance.Self.Gold < ConsortionModelManager.Instance.model.getLevelData(PlayerManager.Instance.Self.consortiaInfo.Level + 1).NeedGold)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return false;
            }
            goldAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            goldAlert.moveEnable = false;
            goldAlert.addEventListener("response",__quickBuyResponse);
            return false;
         }
         return true;
      }
      
      private function __quickBuyResponse(evt:FrameEvent) : void
      {
         var quickBuy:* = null;
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__quickBuyResponse);
         frame.dispose();
         if(frame.parent)
         {
            frame.parent.removeChild(frame);
         }
         frame = null;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            quickBuy = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            quickBuy.itemID = 11233;
            quickBuy.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(quickBuy,3,true,1);
         }
      }
      
      private function __cancelHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _level = null;
         _store = null;
         _shop = null;
         _bank = null;
         _skill = null;
         _wordAndbmp1 = null;
         _wordAndBmp2 = null;
         _levelTxt = null;
         _storeTxt = null;
         _shopTxt = null;
         _bankTxt = null;
         _skillTxt = null;
         _levelNum = null;
         _storeNum = null;
         _shopNum = null;
         _bankNum = null;
         _skillNum = null;
         _explainWord = null;
         _nextLevel = null;
         _requireText = null;
         _consumeText = null;
         _tiptitle = null;
         _explain = null;
         _next = null;
         _require = null;
         _consume = null;
         _ok = null;
         _cancel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
