package signActivity.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import signActivity.SignActivityMgr;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class SignActivityItem extends Sprite
   {
      
      public static var length:int = 1;
      
      public static var btnIndex:int = 1;
      
      public static var btnBigIndex:int = 1;
      
      public static var continuousGoodsIndex:int = 1;
       
      
      private var giftInfo:GiftBagInfo;
      
      private var _smallBtn:BaseButton;
      
      private var _goodEveryDayItemContainerAll:Sprite;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _tag:Bitmap;
      
      private var _day:int;
      
      private var _money:int;
      
      private var _index:int;
      
      private var condition:int;
      
      private var tagIndex:int;
      
      private var leftIndex:int;
      
      private var dayArray:Array;
      
      public function SignActivityItem(param1:int, param2:int)
      {
         dayArray = [3,7,14];
         super();
         _day = param1;
      }
      
      private function removeEvent() : void
      {
         if(_smallBtn)
         {
            _smallBtn.removeEventListener("click",getRewardBtnClick);
         }
         if(_day == dayArray[2] && _goodEveryDayItemContainerAll)
         {
            _goodEveryDayItemContainerAll.removeEventListener("rollOver",__onOver);
            _goodEveryDayItemContainerAll.removeEventListener("rollOut",__onOut);
         }
      }
      
      private function getRewardBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:SendGiftInfo = new SendGiftInfo();
         _loc5_.activityId = SignActivityMgr.instance.model.actId;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < giftInfo.giftRewardArr.length)
         {
            _loc2_[_loc4_] = giftInfo.giftbagId;
            _loc4_++;
         }
         _loc5_.giftIdArr = _loc2_;
         var _loc3_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         _loc3_.push(_loc5_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc3_);
         setGetBtnEnalbe(false);
      }
      
      public function setGetBtnEnalbe(param1:*) : void
      {
         if(_smallBtn)
         {
            ObjectUtils.disposeObject(_smallBtn);
            _smallBtn = null;
         }
         if(giftInfo.giftConditionArr[0].conditionIndex == 1)
         {
            _tag = ComponentFactory.Instance.creatBitmap("asset.signactivity.tag");
            PositionUtils.setPos(_tag,"asset.signactivity.tag.pos." + _day + "." + (tagIndex + 1));
            addChild(_tag);
         }
         else
         {
            createBigBtn(leftIndex + 1,false);
            addChild(_smallBtn);
            _smallBtn.enable = param1;
            leftIndex = Number(leftIndex) + 1;
         }
      }
      
      public function setGoods(param1:GiftBagInfo) : void
      {
         giftInfo = param1;
         condition = _money;
         if(giftInfo.giftConditionArr[0].conditionIndex == 1)
         {
            everyDayGoods();
         }
         else
         {
            continuousGoods();
         }
      }
      
      private function everyDayGoods() : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_goodEveryDayItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodEveryDayItemContainerAll);
            _goodEveryDayItemContainerAll = null;
         }
         _goodEveryDayItemContainerAll = new Sprite();
         var _loc8_:int = 0;
         var _loc7_:* = giftInfo.giftRewardArr;
         for each(var _loc3_ in giftInfo.giftRewardArr)
         {
            _loc6_ = _loc3_.property.split(",");
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.signactivity.goodsBG");
            _loc4_ = ItemManager.Instance.getTemplateById(_loc3_.templateId) as ItemTemplateInfo;
            _loc1_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc1_,_loc4_);
            _loc1_.StrengthenLevel = _loc6_[0];
            _loc1_.AttackCompose = _loc6_[1];
            _loc1_.DefendCompose = _loc6_[2];
            _loc1_.AgilityCompose = _loc6_[3];
            _loc1_.LuckCompose = _loc6_[4];
            _loc1_.MagicAttack = _loc6_[6];
            _loc1_.MagicDefence = _loc6_[7];
            _loc1_.ValidDate = _loc3_.validDate;
            _loc1_.IsBinds = _loc3_.isBind;
            _loc1_.Count = _loc3_.count;
            _loc2_ = new BagCell(0,_loc1_,false);
            _loc2_.setBgVisible(false);
            _goodEveryDayItemContainerAll.addChild(_loc5_);
            _goodEveryDayItemContainerAll.addChild(_loc2_);
         }
         addChild(_goodEveryDayItemContainerAll);
         PositionUtils.setPos(_goodEveryDayItemContainerAll,"everyDayGoods." + _day + "." + length);
         length = Number(length) + 1;
         addEvent();
      }
      
      private function addEvent() : void
      {
         if(_day == dayArray[2])
         {
            this.addEventListener("mouseOver",__onOver);
            this.addEventListener("mouseOut",__onOut);
         }
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         if(_smallBtn)
         {
            _smallBtn.visible = true;
         }
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         if(_smallBtn)
         {
            _smallBtn.visible = false;
         }
      }
      
      private function continuousGoods() : void
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_goodItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodItemContainerAll);
            _goodItemContainerAll = null;
         }
         _goodItemContainerAll = new Sprite();
         _goodItemContainerAll.x = 527;
         _goodItemContainerAll.y = 36;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = giftInfo.giftRewardArr;
         for each(var _loc3_ in giftInfo.giftRewardArr)
         {
            _loc7_ = _loc3_.property.split(",");
            _loc6_ = ComponentFactory.Instance.creatBitmap("asset.signactivity.goodsBG");
            _loc5_ = ItemManager.Instance.getTemplateById(_loc3_.templateId) as ItemTemplateInfo;
            _loc1_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc1_,_loc5_);
            _loc1_.StrengthenLevel = _loc7_[0];
            _loc1_.AttackCompose = _loc7_[1];
            _loc1_.DefendCompose = _loc7_[2];
            _loc1_.AgilityCompose = _loc7_[3];
            _loc1_.LuckCompose = _loc7_[4];
            _loc1_.MagicAttack = _loc7_[6];
            _loc1_.MagicDefence = _loc7_[7];
            _loc1_.ValidDate = _loc3_.validDate;
            _loc1_.IsBinds = _loc3_.isBind;
            _loc1_.Count = _loc3_.count;
            _loc2_ = new BagCell(0,_loc1_,false);
            if(_day == dayArray[2])
            {
               _loc2_.width = 42;
               _loc2_.height = 42;
               var _loc8_:int = 45;
               _loc6_.height = _loc8_;
               _loc6_.width = _loc8_;
               _loc6_.x = _loc4_ * (_loc6_.width + 2);
               _loc2_.x = _loc6_.x + 5;
            }
            else
            {
               _loc6_.x = _loc4_ * (_loc6_.width + 2);
               _loc2_.x = _loc6_.x + 5;
            }
            _loc6_.y = 20;
            _loc2_.y = 25;
            _loc2_.setBgVisible(false);
            _goodItemContainerAll.addChild(_loc6_);
            _goodItemContainerAll.addChild(_loc2_);
            _loc4_++;
         }
         addChild(_goodItemContainerAll);
         PositionUtils.setPos(_goodItemContainerAll,"continuousGoods." + _day + "." + continuousGoodsIndex);
         continuousGoodsIndex = Number(continuousGoodsIndex) + 1;
      }
      
      public function setStatus(param1:Array, param2:Dictionary, param3:int) : void
      {
         var _loc6_:* = null;
         clearBtn();
         tagIndex = param3;
         var _loc5_:PlayerCurInfo = param1[param3] as PlayerCurInfo;
         var _loc4_:int = (param2[giftInfo.giftbagId] as GiftCurInfo).times;
         if(_loc4_ == 0)
         {
            if(giftInfo.giftConditionArr[0].conditionIndex == 1)
            {
               _smallBtn = ComponentFactory.Instance.creat("signActivityItem.getBtn");
               PositionUtils.setPos(_smallBtn,"signActivityItem.getBtn." + _day + "." + btnIndex);
               leftIndex = btnIndex;
               btnIndex = Number(btnIndex) + 1;
               if(_day == dayArray[2])
               {
                  _smallBtn.visible = false;
               }
            }
            else if(giftInfo.giftConditionArr[0].conditionIndex == 2)
            {
               createBigBtn(btnBigIndex);
               btnBigIndex = Number(btnBigIndex) + 1;
            }
            addChild(_smallBtn);
            _smallBtn.enable = false;
            if(giftInfo.giftConditionArr[0].conditionIndex == 1)
            {
               if(_loc5_.statusValue == 1)
               {
                  _smallBtn.enable = true;
                  _smallBtn.addEventListener("click",getRewardBtnClick);
               }
               else if(_loc5_.statusValue == 2)
               {
                  createTag(param3);
               }
            }
            else if(giftInfo.giftConditionArr[0].conditionIndex == 2)
            {
               _loc6_ = param1[13 + (btnBigIndex - 1)] as PlayerCurInfo;
               if(_loc6_.statusValue == 1)
               {
                  _smallBtn.enable = true;
                  _smallBtn.addEventListener("click",getRewardBtnClick);
               }
            }
         }
         else if(giftInfo.giftConditionArr[0].conditionIndex == 1)
         {
            createTag(param3);
            btnIndex = Number(btnIndex) + 1;
         }
         else
         {
            createBigBtn(btnBigIndex,false);
            btnBigIndex = Number(btnBigIndex) + 1;
            _smallBtn.enable = false;
            addChild(_smallBtn);
         }
      }
      
      private function createBigBtn(param1:int, param2:Boolean = true) : void
      {
         if(param2)
         {
            if(_day != dayArray[0])
            {
               _smallBtn = ComponentFactory.Instance.creat("signActivityItem.getBtnBig2");
            }
            else
            {
               _smallBtn = ComponentFactory.Instance.creat("signActivityItem.getBtnBig");
            }
         }
         else if(_day != dayArray[0])
         {
            _smallBtn = ComponentFactory.Instance.creat("signActivityItem.getBtnBig3");
         }
         else
         {
            _smallBtn = ComponentFactory.Instance.creat("signActivityItem.getBtnBig4");
         }
         PositionUtils.setPos(_smallBtn,"signActivityItem.getBtnBig." + _day + "." + param1);
      }
      
      private function createTag(param1:int) : void
      {
         if(_smallBtn)
         {
            ObjectUtils.disposeObject(_smallBtn);
            _smallBtn = null;
         }
         _tag = ComponentFactory.Instance.creatBitmap("asset.signactivity.tag");
         PositionUtils.setPos(_tag,"asset.signactivity.tag.pos." + _day + "." + (param1 + 1));
         addChild(_tag);
      }
      
      private function clearBtn() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_smallBtn);
         _smallBtn = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         ObjectUtils.disposeObject(_smallBtn);
         _smallBtn = null;
      }
   }
}
