package magicHouse.magicCollection
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseMagicPotionSelectFrame extends Frame
   {
       
      
      private var _numberSelecter:NumberSelecter;
      
      private var _countTxt:FilterFrameText;
      
      private var _needPotionTipTxt:FilterFrameText;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _count:int;
      
      private var _type:int;
      
      public function MagicHouseMagicPotionSelectFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("magichouse.collectionView.magicpotionsCountTitle");
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItem.upgrade.magicpotion.NumberSelecter");
         addToContent(_numberSelecter);
         var max:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201489);
         _numberSelecter.valueLimit = "1," + max;
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.chargeBoxNeedMoneyText");
         PositionUtils.setPos(_countTxt,"magicHouse.collection.selectedCountTxtPos");
         _countTxt.text = LanguageMgr.GetTranslation("magichouse.collectionView.magicpotionsCount");
         addToContent(_countTxt);
         _needPotionTipTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.chargeBoxNeedMoneyText");
         PositionUtils.setPos(_needPotionTipTxt,"magicHouse.collection.selectedNeedTxtPos");
         _needPotionTipTxt.htmlText = LanguageMgr.GetTranslation("magichouse.collectionView.upgradeLvNeedPotions",0);
         addToContent(_needPotionTipTxt);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         _okBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         PositionUtils.setPos(_okBtn,"magicHouse.collection.selectedOkBtnPos");
         addToContent(_okBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         _cancelBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText");
         PositionUtils.setPos(_cancelBtn,"magicHouse.collection.selectedCancekBtnPos");
         addToContent(_cancelBtn);
      }
      
      private function _update() : void
      {
         var number:int = 0;
         var needExp:int = 0;
         var currentExp:int = 0;
         if(_type == 1)
         {
            needExp = MagicHouseModel.instance.levelUpNumber[MagicHouseModel.instance.magicJuniorLv];
            currentExp = MagicHouseModel.instance.magicJuniorExp;
         }
         else if(_type == 2)
         {
            needExp = MagicHouseModel.instance.levelUpNumber[MagicHouseModel.instance.magicMidLv];
            currentExp = MagicHouseModel.instance.magicMidExp;
         }
         else
         {
            needExp = MagicHouseModel.instance.levelUpNumber[MagicHouseModel.instance.magicSeniorLv];
            currentExp = MagicHouseModel.instance.magicSeniorExp;
         }
         number = Math.ceil((needExp - currentExp) / 10);
         _numberSelecter.currentValue = number;
         _numberSelecter.validate();
         _needPotionTipTxt.htmlText = LanguageMgr.GetTranslation("magichouse.collectionView.upgradeLvNeedPotions",number);
      }
      
      private function initEvent() : void
      {
         _numberSelecter.addEventListener("change",selectHandler);
         _okBtn.addEventListener("click",__okBtnHandler);
         _cancelBtn.addEventListener("click",__cancelBtnHandler);
         addEventListener("response",_response);
      }
      
      private function removeEvent() : void
      {
         _numberSelecter.removeEventListener("change",selectHandler);
         _okBtn.removeEventListener("click",__okBtnHandler);
         _cancelBtn.removeEventListener("click",__cancelBtnHandler);
      }
      
      private function selectHandler(e:Event) : void
      {
         SoundManager.instance.play("008");
         _count = _numberSelecter.currentValue;
      }
      
      private function __okBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201489) > 0)
         {
            SocketManager.Instance.out.magicLibLevelUp(_type,_count);
            dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.collectionItem.magicPotionLess"));
         }
      }
      
      private function __cancelBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            dispose();
         }
         else if(e.responseCode == 2)
         {
            __okBtnHandler(null);
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
         _update();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
