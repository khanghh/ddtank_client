package magicStone.components
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   
   public class MagicStoneBatFrame extends BaseAlerFrame
   {
       
      
      private var _text:FilterFrameText;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _okBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _selectedItem:DoubleSelectedItem;
      
      private var _totalTipText:FilterFrameText;
      
      private var _totalText:FilterFrameText;
      
      private var _shopItemInfo:ShopItemInfo;
      
      public var type:int;
      
      public function MagicStoneBatFrame()
      {
         super();
      }
      
      public function init2(param1:int) : void
      {
         this.type = param1;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _text = ComponentFactory.Instance.creatComponentByStylename("magicStone.batFrame.text");
         addToContent(_text);
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         PositionUtils.setPos(_numberSelecter,"magicStone.batFrame.numSelecterPos");
         addToContent(_numberSelecter);
         _selectedItem = new DoubleSelectedItem();
         PositionUtils.setPos(_selectedItem,"magicStone.batFrame.selectedItemPos");
         addToContent(_selectedItem);
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         PositionUtils.setPos(_totalTipText,"magicStone.batFrame.totalTipPos");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         addToContent(_totalTipText);
         _totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         PositionUtils.setPos(_totalText,"magicStone.batFrame.totalTxtPos");
         _totalText.text = "100";
         addToContent(_totalText);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _okBtn.text = LanguageMgr.GetTranslation("ok");
         PositionUtils.setPos(_okBtn,"magicStone.batFrame.okBtnPos");
         addToContent(_okBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         PositionUtils.setPos(_cancelBtn,"magicStone.batFrame.cancelBtnPos");
         addToContent(_cancelBtn);
         switch(int(type))
         {
            case 0:
               titleText = LanguageMgr.GetTranslation("magicStone.batExplore");
               _text.text = LanguageMgr.GetTranslation("magicStone.exploreCount");
               break;
            case 1:
               titleText = LanguageMgr.GetTranslation("magicStone.batBuy");
               _text.text = LanguageMgr.GetTranslation("magicStone.buyExperienceStone");
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _numberSelecter.addEventListener("change",__seleterChange);
         _selectedItem.addEventListener("change",__selectedItemChange);
         _okBtn.addEventListener("click",__okBtnClick);
         _cancelBtn.addEventListener("click",__cancelBtnClick);
      }
      
      protected function __selectedItemChange(param1:Event) : void
      {
         updateTotalCost();
      }
      
      public function updateTotalCost() : void
      {
         var _loc1_:int = 0;
         switch(int(type))
         {
            case 0:
               _loc1_ = MagicStoneControl.instance.infoView.getNeedMoney() * int(_numberSelecter.currentValue);
               break;
            case 1:
               _loc1_ = _shopItemInfo.AValue1 * int(_numberSelecter.currentValue);
         }
         if(_selectedItem.isBind)
         {
            _totalText.text = _loc1_ + " " + Price.DDTMONEYTOSTRING;
         }
         else
         {
            _totalText.text = _loc1_ + " " + Price.MONEYTOSTRING;
         }
      }
      
      protected function __okBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         switch(int(type))
         {
            case 0:
               _loc2_ = MagicStoneControl.instance.infoView.getNeedMoney() * int(_numberSelecter.currentValue);
               break;
            case 1:
               _loc2_ = _shopItemInfo.AValue1 * int(_numberSelecter.currentValue);
         }
         CheckMoneyUtils.instance.checkMoney(_selectedItem.isBind,_loc2_,onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         switch(int(type))
         {
            case 0:
               SocketManager.Instance.out.exploreMagicStone(MagicStoneControl.instance.infoView.selectedIndex,CheckMoneyUtils.instance.isBind,int(_numberSelecter.currentValue));
               break;
            case 1:
               SocketManager.Instance.out.convertMgStoneScore(_shopItemInfo.GoodsID,CheckMoneyUtils.instance.isBind,int(_numberSelecter.currentValue));
         }
         dispose();
      }
      
      protected function __cancelBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __seleterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         updateTotalCost();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameEventHandler);
         _numberSelecter.removeEventListener("change",__seleterChange);
         _selectedItem.addEventListener("change",__selectedItemChange);
         _okBtn.removeEventListener("click",__okBtnClick);
         _cancelBtn.removeEventListener("click",__cancelBtnClick);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvents();
         ObjectUtils.disposeObject(_numberSelecter);
         _numberSelecter = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_selectedItem);
         _selectedItem = null;
         ObjectUtils.disposeObject(_totalTipText);
         _totalTipText = null;
         ObjectUtils.disposeObject(_totalText);
         _totalText = null;
         ObjectUtils.disposeObject(_okBtn);
         _okBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
      }
      
      public function set shopItemInfo(param1:ShopItemInfo) : void
      {
         _shopItemInfo = param1;
         updateTotalCost();
      }
      
      public function setNumMax(param1:int) : void
      {
         _numberSelecter.valueLimit = "1," + param1;
         switch(int(type))
         {
            case 0:
               _numberSelecter.currentValue = 10;
               break;
            case 1:
               _numberSelecter.currentValue = 1;
         }
         _numberSelecter.validate();
      }
   }
}
