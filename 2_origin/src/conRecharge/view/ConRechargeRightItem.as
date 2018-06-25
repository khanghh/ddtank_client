package conRecharge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import flash.display.Sprite;
   
   public class ConRechargeRightItem extends Sprite implements Disposeable
   {
       
      
      private var _vbox:VBox;
      
      public function ConRechargeRightItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var _dayItem:* = null;
         _vbox = ComponentFactory.Instance.creatComponentByStylename("conRecharge.rightItem.vbox");
         addChild(_vbox);
         for(i = 0; i < ConRechargeManager.instance.dayGiftbagArray.length; )
         {
            _dayItem = new DayItem(ConRechargeManager.instance.dayGiftbagArray[i]);
            _vbox.addChild(_dayItem);
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
   }
}

import bagAndInfo.cell.BagCell;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.controls.BaseButton;
import com.pickgliss.ui.controls.container.HBox;
import com.pickgliss.ui.core.Component;
import com.pickgliss.utils.ObjectUtils;
import conRecharge.ConRechargeManager;
import ddt.data.goods.InventoryItemInfo;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ItemManager;
import ddt.manager.SocketManager;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import wonderfulActivity.WonderfulActivityManager;
import wonderfulActivity.data.GiftBagInfo;
import wonderfulActivity.data.SendGiftInfo;

class DayItem extends Component
{
    
   
   private var _bg:Bitmap;
   
   private var _btn:BaseButton;
   
   private var _hbox:HBox;
   
   private var _info:GiftBagInfo;
   
   private var _statusArr:Array;
   
   private var _num:Sprite;
   
   function DayItem(info:GiftBagInfo)
   {
      var _cell:* = null;
      var i:int = 0;
      var array:* = null;
      var itemInfo:* = null;
      var tInfo:* = null;
      var bg:* = null;
      var cell:* = null;
      super();
      _info = info;
      _bg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.rightItem.bg");
      addChild(_bg);
      _statusArr = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
      _statusArr.sortOn("statusID",16);
      if(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).giftInfoDic[info.giftbagId].times != 0)
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.havaReceived.btn");
         addChild(_btn);
         _btn.addEventListener("click",clickHandler);
         _btn.enable = false;
      }
      else if(info.giftConditionArr[0].conditionValue > _statusArr[0].statusValue)
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.canReceive.btn");
         addChild(_btn);
         _btn.addEventListener("click",clickHandler);
         _btn.enable = false;
      }
      else
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.canReceive.btn");
         addChild(_btn);
         _btn.addEventListener("click",clickHandler);
      }
      _num = ComponentFactory.Instance.creatNumberSprite(info.giftConditionArr[0].conditionValue,"asset.conRecharge.red");
      addChild(_num);
      PositionUtils.setPos(_num,"asset.conRecharge.red.pos");
      _hbox = ComponentFactory.Instance.creatComponentByStylename("conRecharge.rightItem.hbox");
      addChild(_hbox);
      for(i = 0; i < info.giftRewardArr.length; )
      {
         array = info.giftRewardArr[i].property.split(",");
         itemInfo = ItemManager.Instance.getTemplateById(info.giftRewardArr[i].templateId) as ItemTemplateInfo;
         tInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,itemInfo);
         tInfo.StrengthenLevel = array[0];
         tInfo.AttackCompose = array[1];
         tInfo.DefendCompose = array[2];
         tInfo.AgilityCompose = array[3];
         tInfo.LuckCompose = array[4];
         tInfo.MagicAttack = array[6];
         tInfo.MagicDefence = array[7];
         tInfo.ValidDate = info.giftRewardArr[i].validDate;
         tInfo.IsBinds = info.giftRewardArr[i].isBind;
         tInfo.Count = info.giftRewardArr[i].count;
         bg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.goodsBG");
         cell = new BagCell(0,tInfo,false,bg);
         _hbox.addChild(cell);
         i++;
      }
   }
   
   private function clickHandler(e:MouseEvent) : void
   {
      var getAwardInfo:SendGiftInfo = new SendGiftInfo();
      getAwardInfo.activityId = ConRechargeManager.instance.actId;
      getAwardInfo.giftIdArr = [_info.giftbagId];
      var data:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
      data.push(getAwardInfo);
      SocketManager.Instance.out.sendWonderfulActivityGetReward(data);
      ObjectUtils.disposeObject(_btn);
      _btn.removeEventListener("click",clickHandler);
      _btn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.havaReceived.btn");
      addChild(_btn);
      _btn.enable = false;
   }
   
   override public function dispose() : void
   {
      super.dispose();
      _btn.removeEventListener("click",clickHandler);
      ObjectUtils.disposeObject(_bg);
      _bg = null;
      ObjectUtils.disposeObject(_btn);
      _btn = null;
      ObjectUtils.disposeObject(_hbox);
      _hbox = null;
      ObjectUtils.disposeObject(_num);
      _num = null;
   }
}
