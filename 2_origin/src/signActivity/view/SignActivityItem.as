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
      
      public function SignActivityItem($day:int, $money:int)
      {
         dayArray = [3,7,14];
         super();
         _day = $day;
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
      
      private function getRewardBtnClick(e:MouseEvent) : void
      {
         var i:int = 0;
         var getAwardInfo:SendGiftInfo = new SendGiftInfo();
         getAwardInfo.activityId = SignActivityMgr.instance.model.actId;
         var arr:Array = [];
         for(i = 0; i < giftInfo.giftRewardArr.length; )
         {
            arr[i] = giftInfo.giftbagId;
            i++;
         }
         getAwardInfo.giftIdArr = arr;
         var data:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         data.push(getAwardInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(data);
         setGetBtnEnalbe(false);
      }
      
      public function setGetBtnEnalbe($flag:*) : void
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
            _smallBtn.enable = $flag;
            leftIndex = Number(leftIndex) + 1;
         }
      }
      
      public function setGoods(info:GiftBagInfo) : void
      {
         giftInfo = info;
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
         var array:* = null;
         var bg:* = null;
         var itemInfo:* = null;
         var tInfo:* = null;
         var cell:* = null;
         if(_goodEveryDayItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodEveryDayItemContainerAll);
            _goodEveryDayItemContainerAll = null;
         }
         _goodEveryDayItemContainerAll = new Sprite();
         var _loc8_:int = 0;
         var _loc7_:* = giftInfo.giftRewardArr;
         for each(var item in giftInfo.giftRewardArr)
         {
            array = item.property.split(",");
            bg = ComponentFactory.Instance.creatBitmap("asset.signactivity.goodsBG");
            itemInfo = ItemManager.Instance.getTemplateById(item.templateId) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.StrengthenLevel = array[0];
            tInfo.AttackCompose = array[1];
            tInfo.DefendCompose = array[2];
            tInfo.AgilityCompose = array[3];
            tInfo.LuckCompose = array[4];
            tInfo.MagicAttack = array[6];
            tInfo.MagicDefence = array[7];
            tInfo.ValidDate = item.validDate;
            tInfo.IsBinds = item.isBind;
            tInfo.Count = item.count;
            cell = new BagCell(0,tInfo,false);
            cell.setBgVisible(false);
            _goodEveryDayItemContainerAll.addChild(bg);
            _goodEveryDayItemContainerAll.addChild(cell);
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
      
      private function __onOver(e:MouseEvent) : void
      {
         if(_smallBtn)
         {
            _smallBtn.visible = true;
         }
      }
      
      private function __onOut(e:MouseEvent) : void
      {
         if(_smallBtn)
         {
            _smallBtn.visible = false;
         }
      }
      
      private function continuousGoods() : void
      {
         var array:* = null;
         var bg:* = null;
         var itemInfo:* = null;
         var tInfo:* = null;
         var cell:* = null;
         if(_goodItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodItemContainerAll);
            _goodItemContainerAll = null;
         }
         _goodItemContainerAll = new Sprite();
         _goodItemContainerAll.x = 527;
         _goodItemContainerAll.y = 36;
         var length:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = giftInfo.giftRewardArr;
         for each(var item in giftInfo.giftRewardArr)
         {
            array = item.property.split(",");
            bg = ComponentFactory.Instance.creatBitmap("asset.signactivity.goodsBG");
            itemInfo = ItemManager.Instance.getTemplateById(item.templateId) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.StrengthenLevel = array[0];
            tInfo.AttackCompose = array[1];
            tInfo.DefendCompose = array[2];
            tInfo.AgilityCompose = array[3];
            tInfo.LuckCompose = array[4];
            tInfo.MagicAttack = array[6];
            tInfo.MagicDefence = array[7];
            tInfo.ValidDate = item.validDate;
            tInfo.IsBinds = item.isBind;
            tInfo.Count = item.count;
            cell = new BagCell(0,tInfo,false);
            if(_day == dayArray[2])
            {
               cell.width = 42;
               cell.height = 42;
               var _loc8_:int = 45;
               bg.height = _loc8_;
               bg.width = _loc8_;
               bg.x = length * (bg.width + 2);
               cell.x = bg.x + 5;
            }
            else
            {
               bg.x = length * (bg.width + 2);
               cell.x = bg.x + 5;
            }
            bg.y = 20;
            cell.y = 25;
            cell.setBgVisible(false);
            _goodItemContainerAll.addChild(bg);
            _goodItemContainerAll.addChild(cell);
            length++;
         }
         addChild(_goodItemContainerAll);
         PositionUtils.setPos(_goodItemContainerAll,"continuousGoods." + _day + "." + continuousGoodsIndex);
         continuousGoodsIndex = Number(continuousGoodsIndex) + 1;
      }
      
      public function setStatus(statusArr:Array, giftStatusDic:Dictionary, index:int) : void
      {
         var status2:* = null;
         clearBtn();
         tagIndex = index;
         var status:PlayerCurInfo = statusArr[index] as PlayerCurInfo;
         var alreadyGet:int = (giftStatusDic[giftInfo.giftbagId] as GiftCurInfo).times;
         if(alreadyGet == 0)
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
               if(status.statusValue == 1)
               {
                  _smallBtn.enable = true;
                  _smallBtn.addEventListener("click",getRewardBtnClick);
               }
               else if(status.statusValue == 2)
               {
                  createTag(index);
               }
            }
            else if(giftInfo.giftConditionArr[0].conditionIndex == 2)
            {
               status2 = statusArr[13 + (btnBigIndex - 1)] as PlayerCurInfo;
               if(status2.statusValue == 1)
               {
                  _smallBtn.enable = true;
                  _smallBtn.addEventListener("click",getRewardBtnClick);
               }
            }
         }
         else if(giftInfo.giftConditionArr[0].conditionIndex == 1)
         {
            createTag(index);
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
      
      private function createBigBtn(btnBigIndex:int, flag:Boolean = true) : void
      {
         if(flag)
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
         PositionUtils.setPos(_smallBtn,"signActivityItem.getBtnBig." + _day + "." + btnBigIndex);
      }
      
      private function createTag(index:int) : void
      {
         if(_smallBtn)
         {
            ObjectUtils.disposeObject(_smallBtn);
            _smallBtn = null;
         }
         _tag = ComponentFactory.Instance.creatBitmap("asset.signactivity.tag");
         PositionUtils.setPos(_tag,"asset.signactivity.tag.pos." + _day + "." + (index + 1));
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
