package conRecharge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class ConRechargeLeftItem extends Sprite implements Disposeable
   {
       
      
      private var _vbox:VBox;
      
      private var _num1:Sprite;
      
      private var _num2:Sprite;
      
      private var _num3:Sprite;
      
      public function ConRechargeLeftItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _vbox = ComponentFactory.Instance.creatComponentByStylename("conRecharge.leftItem.vbox");
         addChild(_vbox);
         _num1 = ComponentFactory.Instance.creatNumberSprite(ConRechargeManager.instance.longGiftbagArray[0][0].giftConditionArr[0].remain1,"asset.conRecharge.yellow");
         addChild(_num1);
         PositionUtils.setPos(_num1,"asset.conRecharge.yellow1.pos");
         _num2 = ComponentFactory.Instance.creatNumberSprite(ConRechargeManager.instance.longGiftbagArray[0][1].giftConditionArr[0].remain1,"asset.conRecharge.yellow");
         addChild(_num2);
         PositionUtils.setPos(_num2,"asset.conRecharge.yellow2.pos");
         _num3 = ComponentFactory.Instance.creatNumberSprite(ConRechargeManager.instance.longGiftbagArray[0][2].giftConditionArr[0].remain1,"asset.conRecharge.yellow");
         addChild(_num3);
         PositionUtils.setPos(_num3,"asset.conRecharge.yellow3.pos");
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new BoxItem(_loc2_);
            _vbox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_num1);
         _num1 = null;
         ObjectUtils.disposeObject(_num2);
         _num2 = null;
         ObjectUtils.disposeObject(_num3);
         _num3 = null;
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.controls.BaseButton;
import com.pickgliss.ui.controls.container.HBox;
import com.pickgliss.ui.core.Component;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ClassUtils;
import com.pickgliss.utils.ObjectUtils;
import conRecharge.ConRechargeManager;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ItemManager;
import ddt.manager.LanguageMgr;
import ddt.manager.SocketManager;
import ddt.manager.TimeManager;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import wonderfulActivity.WonderfulActivityManager;
import wonderfulActivity.data.GiftBagInfo;
import wonderfulActivity.data.PlayerCurInfo;
import wonderfulActivity.data.SendGiftInfo;

class BoxItem extends Component
{
    
   
   private var _titleBg:Bitmap;
   
   private var _index:int;
   
   private var _finishDayTxt:FilterFrameText;
   
   private var _moneyTxt:FilterFrameText;
   
   private var _hBox:HBox;
   
   private var _cellArr:Array;
   
   private var _boxArr:Array;
   
   function BoxItem(param1:int)
   {
      super();
      _index = param1;
      initView();
   }
   
   private function initView() : void
   {
      var _loc11_:int = 0;
      var _loc10_:* = null;
      var _loc1_:* = null;
      var _loc6_:* = null;
      var _loc9_:* = null;
      var _loc3_:* = null;
      var _loc7_:* = null;
      var _loc8_:int = 0;
      var _loc5_:* = null;
      var _loc2_:* = null;
      _titleBg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.leftTitle.bg");
      addChild(_titleBg);
      _finishDayTxt = ComponentFactory.Instance.creatComponentByStylename("conRecharge.finishDay.txt");
      addChild(_finishDayTxt);
      _finishDayTxt.text = LanguageMgr.GetTranslation("ddt.conRecharge.finishDay",rechargeDayNum(ConRechargeManager.instance.longGiftbagArray[_index][0].giftConditionArr[0].conditionValue));
      _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("conRecharge.leftItem.money.txt");
      addChild(_moneyTxt);
      _moneyTxt.text = LanguageMgr.GetTranslation("ddt.conRecharge.moneyTxt",ConRechargeManager.instance.longGiftbagArray[_index][0].giftConditionArr[0].conditionValue);
      _hBox = ComponentFactory.Instance.creatComponentByStylename("conRecharge.leftItem.hbox");
      addChild(_hBox);
      _cellArr = [];
      _boxArr = [];
      var _loc4_:int = 0;
      _loc11_ = 0;
      while(_loc11_ < ConRechargeManager.instance.longGiftbagArray[_index].length)
      {
         _loc10_ = ConRechargeManager.instance.longGiftbagArray[_index][_loc11_];
         _loc1_ = new Sprite();
         _loc6_ = ComponentFactory.Instance.creatBitmap("asset.conRecharge.leftItem.bg");
         _loc1_.addChild(_loc6_);
         _loc9_ = _loc10_.giftRewardArr[0].property.split(",");
         _loc3_ = ComponentFactory.Instance.creatComponentByStylename("conRecharge.prize.btn");
         _loc3_.id = _loc11_;
         _loc7_ = "";
         _loc8_ = 0;
         while(_loc8_ < _loc10_.giftRewardArr.length)
         {
            _loc5_ = ItemManager.Instance.getTemplateById(_loc10_.giftRewardArr[_loc8_].templateId) as ItemTemplateInfo;
            _loc7_ = _loc7_ + _loc5_.Name;
            if(_loc10_.giftRewardArr[_loc8_].validDate > 0)
            {
               _loc7_ = _loc7_ + ("(" + LanguageMgr.GetTranslation("ddt.conRecharge.leftDay",_loc10_.giftRewardArr[_loc8_].validDate) + ")");
            }
            _loc7_ = _loc7_ + (" x " + String(_loc10_.giftRewardArr[_loc8_].count) + "\n");
            _loc8_++;
         }
         _loc3_.tipData = _loc7_;
         _loc1_.addChild(_loc3_);
         _cellArr.push(_loc3_);
         _loc2_ = ClassUtils.CreatInstance("asset.conRecharge.box");
         if(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).giftInfoDic[_loc10_.giftbagId].times != 0)
         {
            _loc2_.gotoAndStop(1);
            _loc3_.enable = false;
            _loc3_.mouseEnabled = true;
         }
         else if(judgeRechargeDay(_loc10_.giftConditionArr[0].remain1,_loc10_.giftConditionArr[0].conditionValue))
         {
            _loc2_.gotoAndStop(2);
            _loc3_.addEventListener("click",clickHandler);
         }
         else
         {
            _loc2_.gotoAndStop(3);
            _loc3_.enable = false;
            _loc3_.mouseEnabled = true;
         }
         PositionUtils.setPos(_loc2_,"asset.conRecharge.box.pos");
         _boxArr.push(_loc2_);
         _loc1_.addChild(_loc2_);
         _hBox.addChild(_loc1_);
         _loc4_++;
         _loc11_++;
      }
   }
   
   private function rechargeDayNum(param1:int) : int
   {
      var _loc6_:int = 0;
      var _loc7_:* = 0;
      var _loc10_:int = 0;
      var _loc8_:* = 0;
      var _loc9_:* = null;
      var _loc5_:Array = [];
      _loc6_ = 0;
      while(_loc6_ < WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr.length)
      {
         if(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr[_loc6_].statusID != 0)
         {
            _loc5_.push(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr[_loc6_]);
         }
         _loc6_++;
      }
      _loc5_.sortOn("statusID",16);
      var _loc4_:Date = TimeManager.Instance.Now();
      var _loc3_:int = 10000 * _loc4_.getFullYear() + 100 * (_loc4_.getMonth() + 1) + _loc4_.getDate();
      _loc10_ = 0;
      while(_loc10_ < _loc5_.length)
      {
         if(_loc5_[_loc10_].statusID == _loc3_)
         {
            if(_loc10_ == 0)
            {
               if(_loc5_[_loc10_].statusValue == 0)
               {
                  return 0;
               }
               if(_loc5_[_loc10_].statusValue >= param1)
               {
                  return 1;
               }
               return 0;
            }
            if(_loc5_[_loc10_].statusValue >= param1)
            {
               _loc7_ = _loc10_;
            }
            else
            {
               _loc7_ = int(_loc10_ - 1);
            }
            break;
         }
         _loc10_++;
      }
      var _loc2_:int = 0;
      _loc8_ = _loc7_;
      while(_loc8_ >= 0)
      {
         _loc9_ = _loc5_[_loc8_];
         if(_loc9_.statusValue >= param1)
         {
            _loc2_++;
            _loc8_--;
            continue;
         }
         return _loc2_;
      }
      return _loc2_;
   }
   
   private function judgeRechargeDay(param1:int, param2:int) : Boolean
   {
      var _loc7_:int = 0;
      var _loc6_:* = null;
      var _loc5_:int = 0;
      var _loc4_:Array = [];
      var _loc3_:Array = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
      _loc3_.sortOn("statusID",16);
      _loc7_ = 0;
      while(_loc7_ < _loc3_.length)
      {
         _loc6_ = _loc3_[_loc7_];
         _loc6_.my = _loc7_;
         if(_loc6_.statusID != 0)
         {
            if(_loc6_.statusValue >= param2)
            {
               _loc4_.push(_loc6_);
            }
         }
         _loc7_++;
      }
      if(_loc4_.length < param1)
      {
         return false;
      }
      _loc5_ = param1 - 1;
      while(_loc5_ < _loc4_.length)
      {
         if(_loc4_[_loc5_].my - _loc4_[_loc5_ - param1 + 1].my == param1 - 1)
         {
            return true;
         }
         _loc5_++;
      }
      return false;
   }
   
   private function clickHandler(param1:MouseEvent) : void
   {
      var _loc3_:SendGiftInfo = new SendGiftInfo();
      _loc3_.activityId = ConRechargeManager.instance.actId;
      _loc3_.giftIdArr = [ConRechargeManager.instance.longGiftbagArray[_index][param1.currentTarget.id].giftbagId];
      var _loc2_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
      _loc2_.push(_loc3_);
      SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc2_);
      param1.currentTarget.enable = false;
      param1.currentTarget.mouseEnabled = true;
      _boxArr[param1.currentTarget.id].gotoAndStop(0);
   }
   
   override public function dispose() : void
   {
      var _loc1_:int = 0;
      super.dispose();
      _loc1_ = 0;
      while(_loc1_ < _cellArr.length)
      {
         _cellArr[_loc1_].removeEventListener("click",clickHandler);
         _loc1_++;
      }
      ObjectUtils.disposeObject(_titleBg);
      _titleBg = null;
      ObjectUtils.disposeObject(_finishDayTxt);
      _finishDayTxt = null;
      ObjectUtils.disposeObject(_moneyTxt);
      _moneyTxt = null;
      ObjectUtils.disposeObject(_hBox);
      _hBox = null;
   }
}
