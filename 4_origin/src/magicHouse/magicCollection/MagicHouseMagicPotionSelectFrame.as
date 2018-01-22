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
         var _loc1_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201489);
         _numberSelecter.valueLimit = "1," + _loc1_;
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(_type == 1)
         {
            _loc1_ = MagicHouseModel.instance.levelUpNumber[MagicHouseModel.instance.magicJuniorLv];
            _loc3_ = MagicHouseModel.instance.magicJuniorExp;
         }
         else if(_type == 2)
         {
            _loc1_ = MagicHouseModel.instance.levelUpNumber[MagicHouseModel.instance.magicMidLv];
            _loc3_ = MagicHouseModel.instance.magicMidExp;
         }
         else
         {
            _loc1_ = MagicHouseModel.instance.levelUpNumber[MagicHouseModel.instance.magicSeniorLv];
            _loc3_ = MagicHouseModel.instance.magicSeniorExp;
         }
         _loc2_ = Math.ceil((_loc1_ - _loc3_) / 10);
         _numberSelecter.currentValue = _loc2_;
         _numberSelecter.validate();
         _needPotionTipTxt.htmlText = LanguageMgr.GetTranslation("magichouse.collectionView.upgradeLvNeedPotions",_loc2_);
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
      
      private function selectHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _count = _numberSelecter.currentValue;
      }
      
      private function __okBtnHandler(param1:MouseEvent) : void
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
      
      private function __cancelBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
         else if(param1.responseCode == 2)
         {
            __okBtnHandler(null);
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         _update();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
