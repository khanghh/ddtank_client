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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _vbox = ComponentFactory.Instance.creatComponentByStylename("conRecharge.rightItem.vbox");
         addChild(_vbox);
         _loc2_ = 0;
         while(_loc2_ < ConRechargeManager.instance.dayGiftbagArray.length)
         {
            _loc1_ = new DayItem(ConRechargeManager.instance.dayGiftbagArray[_loc2_]);
            _vbox.addChild(_loc1_);
            _loc2_++;
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
   
   function DayItem(param1:GiftBagInfo)
   {
      var _loc2_:* = null;
      var _loc8_:int = 0;
      var _loc7_:* = null;
      var _loc6_:* = null;
      var _loc3_:* = null;
      var _loc5_:* = null;
      var _loc4_:* = null;
      super();
      _info = param1;
      _bg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.rightItem.bg");
      addChild(_bg);
      _statusArr = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
      _statusArr.sortOn("statusID",16);
      if(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).giftInfoDic[param1.giftbagId].times != 0)
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.havaReceived.btn");
         addChild(_btn);
         _btn.addEventListener("click",clickHandler);
         _btn.enable = false;
      }
      else if(param1.giftConditionArr[0].conditionValue > _statusArr[0].statusValue)
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
      _num = ComponentFactory.Instance.creatNumberSprite(param1.giftConditionArr[0].conditionValue,"asset.conRecharge.red");
      addChild(_num);
      PositionUtils.setPos(_num,"asset.conRecharge.red.pos");
      _hbox = ComponentFactory.Instance.creatComponentByStylename("conRecharge.rightItem.hbox");
      addChild(_hbox);
      _loc8_ = 0;
      while(_loc8_ < param1.giftRewardArr.length)
      {
         _loc7_ = param1.giftRewardArr[_loc8_].property.split(",");
         _loc6_ = ItemManager.Instance.getTemplateById(param1.giftRewardArr[_loc8_].templateId) as ItemTemplateInfo;
         _loc3_ = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc3_,_loc6_);
         _loc3_.StrengthenLevel = _loc7_[0];
         _loc3_.AttackCompose = _loc7_[1];
         _loc3_.DefendCompose = _loc7_[2];
         _loc3_.AgilityCompose = _loc7_[3];
         _loc3_.LuckCompose = _loc7_[4];
         _loc3_.MagicAttack = _loc7_[6];
         _loc3_.MagicDefence = _loc7_[7];
         _loc3_.ValidDate = param1.giftRewardArr[_loc8_].validDate;
         _loc3_.IsBinds = param1.giftRewardArr[_loc8_].isBind;
         _loc3_.Count = param1.giftRewardArr[_loc8_].count;
         _loc5_ = ComponentFactory.Instance.creatBitmap("asset.conRecharge.goodsBG");
         _loc4_ = new BagCell(0,_loc3_,false,_loc5_);
         _hbox.addChild(_loc4_);
         _loc8_++;
      }
   }
   
   private function clickHandler(param1:MouseEvent) : void
   {
      var _loc3_:SendGiftInfo = new SendGiftInfo();
      _loc3_.activityId = ConRechargeManager.instance.actId;
      _loc3_.giftIdArr = [_info.giftbagId];
      var _loc2_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
      _loc2_.push(_loc3_);
      SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc2_);
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
