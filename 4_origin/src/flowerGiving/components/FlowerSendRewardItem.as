package flowerGiving.components
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class FlowerSendRewardItem extends Sprite implements Disposeable
   {
       
      
      private var _itemIndex:int;
      
      private var _back:Bitmap;
      
      private var _backOverBit:Bitmap;
      
      private var _contentTxt:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _haveGot:Bitmap;
      
      private var _hBox:HBox;
      
      private var index:int;
      
      public var num:int;
      
      public function FlowerSendRewardItem(index:int)
      {
         super();
         this.index = index;
         _itemIndex = index % 2 == 0?2:1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("flowerGiving.accumuGivingItem" + _itemIndex);
         addChild(_back);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("flowerSendView.contentTxt");
         addChild(_contentTxt);
         _contentTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendRewardView.desc");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("flowerSendView.getbtn");
         addChild(_getBtn);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("flowerSendView.hBox");
         addChild(_hBox);
         _backOverBit = ComponentFactory.Instance.creat("flowerGiving.accumuGivingMouseOver");
         addChild(_backOverBit);
         _backOverBit.visible = false;
         _haveGot = ComponentFactory.Instance.creat("flowerGiving.haveGot");
         addChild(_haveGot);
         _haveGot.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onOverHanlder);
         addEventListener("rollOut",__onOutHandler);
         _getBtn.addEventListener("click",__clickHanlder);
      }
      
      protected function __clickHanlder(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendGetFlowerReward(2,index);
      }
      
      protected function __onOutHandler(event:MouseEvent) : void
      {
         _backOverBit.visible = false;
      }
      
      protected function __onOverHanlder(event:MouseEvent) : void
      {
         _backOverBit.visible = true;
      }
      
      public function set info(info:GiftBagInfo) : void
      {
         var i:int = 0;
         var reward:* = null;
         var item:* = null;
         var attrArr:* = null;
         var bagCell:* = null;
         num = info.giftConditionArr[0].conditionValue;
         _contentTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendRewardView.desc",num);
         for(i = 0; i <= info.giftRewardArr.length - 1; )
         {
            reward = info.giftRewardArr[i];
            item = new InventoryItemInfo();
            item.TemplateID = reward.templateId;
            ItemManager.fill(item);
            item.IsBinds = reward.isBind;
            item.ValidDate = reward.validDate;
            attrArr = reward.property.split(",");
            item.StrengthenLevel = parseInt(attrArr[0]);
            item.AttackCompose = parseInt(attrArr[1]);
            item.DefendCompose = parseInt(attrArr[2]);
            item.AgilityCompose = parseInt(attrArr[3]);
            item.LuckCompose = parseInt(attrArr[4]);
            if(EquipType.isMagicStone(item.CategoryID))
            {
               item.Level = item.StrengthenLevel;
               item.Attack = item.AttackCompose;
               item.Defence = item.DefendCompose;
               item.Agility = item.AgilityCompose;
               item.Luck = item.LuckCompose;
               item.MagicAttack = parseInt(attrArr[6]);
               item.MagicDefence = parseInt(attrArr[7]);
               item.StrengthenExp = parseInt(attrArr[8]);
            }
            bagCell = new BagCell(0);
            bagCell.info = item;
            bagCell.setCount(reward.count);
            bagCell.setBgVisible(false);
            _hBox.addChild(bagCell);
            i++;
         }
      }
      
      public function setBtnEnable(type:int) : void
      {
         switch(int(type))
         {
            case 0:
               _getBtn.enable = false;
               _haveGot.visible = false;
               break;
            case 1:
               _getBtn.enable = true;
               _haveGot.visible = false;
               break;
            case 2:
               _getBtn.enable = false;
               _haveGot.visible = true;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onOverHanlder);
         removeEventListener("rollOut",__onOutHandler);
         _getBtn.removeEventListener("click",__clickHanlder);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_backOverBit)
         {
            ObjectUtils.disposeObject(_backOverBit);
         }
         _backOverBit = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(_getBtn)
         {
            ObjectUtils.disposeObject(_getBtn);
         }
         _getBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
