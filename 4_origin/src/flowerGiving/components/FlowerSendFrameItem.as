package flowerGiving.components
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class FlowerSendFrameItem extends Sprite implements Disposeable
   {
       
      
      private var _selectBtn:SelectedCheckButton;
      
      private var _sendTxt:FilterFrameText;
      
      private var _sendNumTxt:FilterFrameText;
      
      private var _canGetTxt:FilterFrameText;
      
      private var _shineBit:Bitmap;
      
      private var _giftData:GiftBagInfo;
      
      private var _sendBagCell:BagCell;
      
      private var _getIconSp:Sprite;
      
      private var _getIcon:Image;
      
      private var _baseTip:GoodTipInfo;
      
      public function FlowerSendFrameItem(param1:GiftBagInfo)
      {
         _giftData = param1;
         super();
         initView();
         initViewWithData();
         addEvent();
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         updateShine();
      }
      
      private function initView() : void
      {
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.selectedBtn");
         addChild(_selectBtn);
         _sendTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendTxt");
         addChild(_sendTxt);
         PositionUtils.setPos(_sendTxt,"flowerGiving.flowerSendFrame.sendPos");
         _sendTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.sendTxt");
         _sendNumTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendTxt");
         addChild(_sendNumTxt);
         PositionUtils.setPos(_sendNumTxt,"flowerGiving.flowerSendFrame.sendNumPos");
         _canGetTxt = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.flowerSendFrame.sendTxt");
         addChild(_canGetTxt);
         PositionUtils.setPos(_canGetTxt,"flowerGiving.flowerSendFrame.canGetPos");
         _canGetTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.cenGetTxt");
         _getIconSp = new Sprite();
         _getIcon = ComponentFactory.Instance.creatComponentByStylename("flowerSendFrame.rewardIcon");
         var _loc1_:* = 0.58;
         _getIcon.scaleY = _loc1_;
         _getIcon.scaleX = _loc1_;
         PositionUtils.setPos(_getIcon,"flowerGiving.flowerSendFrame.getIconPos");
         _getIconSp.addChild(_getIcon);
         addChild(_getIconSp);
         _shineBit = ComponentFactory.Instance.creat("flowerGiving.flowerSendFrame.mouseOver");
         addChild(_shineBit);
         updateShine();
      }
      
      private function initViewWithData() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         _sendNumTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.sendNumTxt",_giftData.giftConditionArr[0].conditionValue);
         _sendBagCell = createBagCell(FlowerGivingManager.instance.flowerTempleteId);
         addChild(_sendBagCell);
         _sendBagCell.setCountNotVisible();
         PositionUtils.setPos(_sendBagCell,"flowerGiving.flowerSendFrame.sendBagCell");
         _baseTip = new GoodTipInfo();
         var _loc5_:ItemTemplateInfo = new ItemTemplateInfo();
         _loc5_.Quality = 4;
         _loc5_.CategoryID = 11;
         _loc5_.Name = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.getGiftPackName" + (_giftData.giftbagOrder + 1));
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _giftData.giftRewardArr.length)
         {
            _loc1_ = _giftData.giftRewardArr[_loc4_];
            _loc3_ = new InventoryItemInfo();
            _loc3_.TemplateID = _loc1_.templateId;
            ItemManager.fill(_loc3_);
            if(_loc2_ != "")
            {
               _loc2_ = _loc2_ + "、";
            }
            _loc2_ = _loc2_ + (_loc3_.Name + "x" + _loc1_.count);
            _loc4_++;
         }
         _loc5_.Description = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.getGiftPackContent") + _loc2_;
         _baseTip.itemInfo = _loc5_;
         _getIcon.tipStyle = "core.GoodsTip";
         _getIcon.tipDirctions = "1,3";
         _getIcon.tipData = _baseTip;
      }
      
      private function createBagCell(param1:int) : BagCell
      {
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = param1;
         _loc3_ = ItemManager.fill(_loc3_);
         _loc3_.BindType = 4;
         var _loc2_:BagCell = new BagCell(0);
         _loc2_.info = _loc3_;
         _loc2_.setBgVisible(false);
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         _selectBtn.removeEventListener("click",__clickHandler);
      }
      
      public function updateShine() : void
      {
         _shineBit.visible = _selectBtn.selected;
      }
      
      public function get selectBtn() : SelectedCheckButton
      {
         return _selectBtn;
      }
      
      public function set selectBtn(param1:SelectedCheckButton) : void
      {
         _selectBtn = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_getIcon);
         ObjectUtils.disposeAllChildren(this);
         _getIcon = null;
         _getIconSp = null;
         _selectBtn = null;
         _sendTxt = null;
         _sendNumTxt = null;
         _canGetTxt = null;
         _shineBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
