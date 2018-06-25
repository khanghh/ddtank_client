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
      
      public function FlowerSendFrameItem(data:GiftBagInfo)
      {
         _giftData = data;
         super();
         initView();
         initViewWithData();
         addEvent();
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(event:MouseEvent) : void
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
         var i:int = 0;
         var rewardInfo:* = null;
         var item:* = null;
         _sendNumTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.sendNumTxt",_giftData.giftConditionArr[0].conditionValue);
         _sendBagCell = createBagCell(FlowerGivingManager.instance.flowerTempleteId);
         addChild(_sendBagCell);
         _sendBagCell.setCountNotVisible();
         PositionUtils.setPos(_sendBagCell,"flowerGiving.flowerSendFrame.sendBagCell");
         _baseTip = new GoodTipInfo();
         var info:ItemTemplateInfo = new ItemTemplateInfo();
         info.Quality = 4;
         info.CategoryID = 11;
         info.Name = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.getGiftPackName" + (_giftData.giftbagOrder + 1));
         var content:String = "";
         for(i = 0; i < _giftData.giftRewardArr.length; )
         {
            rewardInfo = _giftData.giftRewardArr[i];
            item = new InventoryItemInfo();
            item.TemplateID = rewardInfo.templateId;
            ItemManager.fill(item);
            if(content != "")
            {
               content = content + "、";
            }
            content = content + (item.Name + "x" + rewardInfo.count);
            i++;
         }
         info.Description = LanguageMgr.GetTranslation("flowerGiving.flowerSendFrame.getGiftPackContent") + content;
         _baseTip.itemInfo = info;
         _getIcon.tipStyle = "core.GoodsTip";
         _getIcon.tipDirctions = "1,3";
         _getIcon.tipData = _baseTip;
      }
      
      private function createBagCell(templeteId:int) : BagCell
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = templeteId;
         info = ItemManager.fill(info);
         info.BindType = 4;
         var bagCell:BagCell = new BagCell(0);
         bagCell.info = info;
         bagCell.setBgVisible(false);
         return bagCell;
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
      
      public function set selectBtn(value:SelectedCheckButton) : void
      {
         _selectBtn = value;
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
