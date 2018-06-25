package roleRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import roleRecharge.RoleRechargeMgr;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class RoleRechargeItem extends Sprite
   {
       
      
      private var _btn:BaseButton;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _moneyTxt:FilterFrameText;
      
      private var giftInfo:GiftBagInfo;
      
      private var _money:int;
      
      private var _index:int;
      
      private var condition:int;
      
      public function RoleRechargeItem($money:int, $index:int)
      {
         super();
         _money = $money;
         _index = $index;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("RoleRechargeItem.moneyTxt");
         _moneyTxt.text = LanguageMgr.GetTranslation("RoleRechargeItem.moneyL",_money);
         addChild(_moneyTxt);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",getRewardBtnClick);
         }
      }
      
      public function setGetBtnEnalbe($flag:*) : void
      {
         _btn.enable = $flag;
      }
      
      public function setGoods(info:GiftBagInfo) : void
      {
         var array:* = null;
         var bg:* = null;
         var dx:Number = NaN;
         var itemInfo:* = null;
         var tInfo:* = null;
         var cell:* = null;
         giftInfo = info;
         condition = _money;
         if(_goodItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodItemContainerAll);
            _goodItemContainerAll = null;
         }
         _goodItemContainerAll = new Sprite();
         _goodItemContainerAll.x = 128;
         _goodItemContainerAll.y = -18;
         var length:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = giftInfo.giftRewardArr;
         for each(var item in giftInfo.giftRewardArr)
         {
            array = item.property.split(",");
            bg = ComponentFactory.Instance.creatBitmap("roleRecharge.item");
            dx = bg.width + 5;
            dx = dx * (int(length % 5));
            bg.x = dx;
            bg.y = 20;
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
            cell.x = dx + 2;
            cell.y = 23;
            cell.setBgVisible(false);
            _goodItemContainerAll.addChild(bg);
            _goodItemContainerAll.addChild(cell);
            length++;
         }
         addChild(_goodItemContainerAll);
      }
      
      public function setStatus(statusArr:Array, giftStatusDic:Dictionary) : void
      {
         var remain:int = 0;
         var payValue:int = 0;
         clearBtn();
         var alreadyGet:int = (giftStatusDic[giftInfo.giftbagId] as GiftCurInfo).times;
         var _loc8_:int = 0;
         var _loc7_:* = statusArr;
         for each(var playerStatus in statusArr)
         {
            if(playerStatus.statusID == condition)
            {
               remain = playerStatus.statusValue - alreadyGet;
            }
         }
         if(alreadyGet == 0)
         {
            _btn = ComponentFactory.Instance.creat("RoleRechargeItem.getBtn");
            addChild(_btn);
            _btn.enable = false;
            if(remain > 0)
            {
               _btn.enable = true;
               _btn.addEventListener("click",getRewardBtnClick);
            }
         }
         else
         {
            _btn = ComponentFactory.Instance.creat("RoleRechargeItem.getBtn");
            _btn.enable = false;
            addChild(_btn);
         }
      }
      
      private function getRewardBtnClick(e:MouseEvent) : void
      {
         var i:int = 0;
         var getAwardInfo:SendGiftInfo = new SendGiftInfo();
         getAwardInfo.activityId = RoleRechargeMgr.instance.model.actId;
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
      
      private function clearBtn() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
      }
   }
}
