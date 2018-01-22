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
      
      public function FlowerSendRewardItem(param1:int)
      {
         super();
         this.index = param1;
         _itemIndex = param1 % 2 == 0?2:1;
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
      
      protected function __clickHanlder(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendGetFlowerReward(2,index);
      }
      
      protected function __onOutHandler(param1:MouseEvent) : void
      {
         _backOverBit.visible = false;
      }
      
      protected function __onOverHanlder(param1:MouseEvent) : void
      {
         _backOverBit.visible = true;
      }
      
      public function set info(param1:GiftBagInfo) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         num = param1.giftConditionArr[0].conditionValue;
         _contentTxt.text = LanguageMgr.GetTranslation("flowerGiving.flowerSendRewardView.desc",num);
         _loc6_ = 0;
         while(_loc6_ <= param1.giftRewardArr.length - 1)
         {
            _loc3_ = param1.giftRewardArr[_loc6_];
            _loc4_ = new InventoryItemInfo();
            _loc4_.TemplateID = _loc3_.templateId;
            ItemManager.fill(_loc4_);
            _loc4_.IsBinds = _loc3_.isBind;
            _loc4_.ValidDate = _loc3_.validDate;
            _loc5_ = _loc3_.property.split(",");
            _loc4_.StrengthenLevel = parseInt(_loc5_[0]);
            _loc4_.AttackCompose = parseInt(_loc5_[1]);
            _loc4_.DefendCompose = parseInt(_loc5_[2]);
            _loc4_.AgilityCompose = parseInt(_loc5_[3]);
            _loc4_.LuckCompose = parseInt(_loc5_[4]);
            if(EquipType.isMagicStone(_loc4_.CategoryID))
            {
               _loc4_.Level = _loc4_.StrengthenLevel;
               _loc4_.Attack = _loc4_.AttackCompose;
               _loc4_.Defence = _loc4_.DefendCompose;
               _loc4_.Agility = _loc4_.AgilityCompose;
               _loc4_.Luck = _loc4_.LuckCompose;
               _loc4_.MagicAttack = parseInt(_loc5_[6]);
               _loc4_.MagicDefence = parseInt(_loc5_[7]);
               _loc4_.StrengthenExp = parseInt(_loc5_[8]);
            }
            _loc2_ = new BagCell(0);
            _loc2_.info = _loc4_;
            _loc2_.setCount(_loc3_.count);
            _loc2_.setBgVisible(false);
            _hBox.addChild(_loc2_);
            _loc6_++;
         }
      }
      
      public function setBtnEnable(param1:int) : void
      {
         switch(int(param1))
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
