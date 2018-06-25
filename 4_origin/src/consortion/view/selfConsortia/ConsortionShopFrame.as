package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaAssetLevelOffer;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionShopFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _scrollbg:ScaleBitmapImage;
      
      private var _bg2:MutipleImage;
      
      private var _bg3:MutipleImage;
      
      private var _gold:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _exploitText:FilterFrameText;
      
      private var _contributionText:FilterFrameText;
      
      private var _offer:FilterFrameText;
      
      private var _ttoffer:FilterFrameText;
      
      private var _level1:SelectedTextButton;
      
      private var _level2:SelectedTextButton;
      
      private var _level3:SelectedTextButton;
      
      private var _level4:SelectedTextButton;
      
      private var _level5:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:ConsortionShopList;
      
      private var _word:FilterFrameText;
      
      public function ConsortionShopFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("tank.consortia.consortiashop.ConsortiaShopView.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.bg");
         _scrollbg = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItem.scallBG");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.bg2");
         _gold = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.gold");
         _money = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.money");
         _exploitText = ComponentFactory.Instance.creatComponentByStylename("consortion.shopFrame.exploitText");
         _exploitText.text = LanguageMgr.GetTranslation("offer");
         _contributionText = ComponentFactory.Instance.creatComponentByStylename("consortion.shopFrame.contributionText");
         _contributionText.text = LanguageMgr.GetTranslation("ddt.consortion.skillCell.btnPersonal.rich");
         _offer = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.offer");
         _ttoffer = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.ttoffer");
         _level1 = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.level1");
         _level1.text = LanguageMgr.GetTranslation("consortion.shop.level1.text");
         _level2 = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.level2");
         _level2.text = LanguageMgr.GetTranslation("consortion.shop.level2.text");
         _level3 = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.level3");
         _level3.text = LanguageMgr.GetTranslation("consortion.shop.level3.text");
         _level4 = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.level4");
         _level4.text = LanguageMgr.GetTranslation("consortion.shop.level4.text");
         _level5 = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.level5");
         _level5.text = LanguageMgr.GetTranslation("consortion.shop.level5.text");
         _btnGroup = new SelectedButtonGroup();
         _list = ComponentFactory.Instance.creatCustomObject("consortionShopList");
         _word = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.word");
         _word.text = LanguageMgr.GetTranslation("consortion.shop.word.text");
         addToContent(_bg);
         addToContent(_scrollbg);
         addToContent(_bg2);
         addToContent(_gold);
         addToContent(_money);
         addToContent(_exploitText);
         addToContent(_contributionText);
         addToContent(_offer);
         addToContent(_ttoffer);
         addToContent(_level1);
         addToContent(_level2);
         addToContent(_level3);
         addToContent(_level4);
         addToContent(_level5);
         addToContent(_list);
         addToContent(_word);
         _btnGroup.addSelectItem(_level1);
         _btnGroup.addSelectItem(_level2);
         _btnGroup.addSelectItem(_level3);
         _btnGroup.addSelectItem(_level4);
         _btnGroup.addSelectItem(_level5);
         _btnGroup.selectIndex = 0;
         _gold.text = String(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12567));
         _money.text = String(PlayerManager.Instance.Self.Money);
         _offer.text = String(PlayerManager.Instance.Self.Offer);
         _ttoffer.text = String(PlayerManager.Instance.Self.UseOffer);
         showLevel(_btnGroup.selectIndex + 1);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnGroup.addEventListener("change",__groupChange);
         ConsortionModelManager.Instance.model.addEventListener("useConditionChange",__useChangeHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propChangeHandler);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onUpdateBag);
      }
      
      protected function __useChangeHandler(event:Event) : void
      {
         showLevel(_btnGroup.selectIndex + 1);
      }
      
      private function __onUpdateBag(e:BagEvent) : void
      {
         _gold.text = String(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12567));
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _btnGroup.removeEventListener("change",__groupChange);
         ConsortionModelManager.Instance.model.removeEventListener("useConditionChange",__useChangeHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propChangeHandler);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__onUpdateBag);
      }
      
      private function __propChangeHandler(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Offer"])
         {
            _offer.text = String(PlayerManager.Instance.Self.Offer);
         }
         if(event.changedProperties["Money"])
         {
            _money.text = String(PlayerManager.Instance.Self.Money);
         }
         if(!event.changedProperties["BandMoney"])
         {
         }
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __groupChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         showLevel(_btnGroup.selectIndex + 1);
      }
      
      private function showLevel(index:int) : void
      {
         var rich:int = 0;
         var b:Boolean = PlayerManager.Instance.Self.consortiaInfo.ShopLevel >= index?true:false;
         var uselist:Vector.<ConsortiaAssetLevelOffer> = ConsortionModelManager.Instance.model.useConditionList;
         if(uselist == null || uselist.length == 0)
         {
            rich = 100;
         }
         else
         {
            rich = ConsortionModelManager.Instance.model.useConditionList[index - 1].Riches;
         }
         _list.list(ShopManager.Instance.consortiaShopLevelTemplates(index),index,rich,b);
      }
      
      private function __managerClickHandler(event:MouseEvent) : void
      {
         ConsortionModelManager.Instance.alertManagerFrame();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _scrollbg = null;
         _bg2 = null;
         _gold = null;
         _money = null;
         _exploitText = null;
         _contributionText = null;
         _offer = null;
         _ttoffer = null;
         _level1 = null;
         _level2 = null;
         _level3 = null;
         _level4 = null;
         _level5 = null;
         _btnGroup = null;
         _list = null;
         _word = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
