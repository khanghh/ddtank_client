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
         var i:int = 0;
         var _boxItem:* = null;
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
         for(i = 0; i < 3; )
         {
            _boxItem = new BoxItem(i);
            _vbox.addChild(_boxItem);
            i++;
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
   
   function BoxItem(index:int)
   {
      super();
      _index = index;
      initView();
   }
   
   private function initView() : void
   {
      var i:int = 0;
      var info:* = null;
      var container:* = null;
      var bg:* = null;
      var array:* = null;
      var prize:* = null;
      var tipStr:* = null;
      var j:int = 0;
      var itemInfo:* = null;
      var _box:* = null;
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
      var n:int = 0;
      for(i = 0; i < ConRechargeManager.instance.longGiftbagArray[_index].length; )
      {
         info = ConRechargeManager.instance.longGiftbagArray[_index][i];
         container = new Sprite();
         bg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.leftItem.bg");
         container.addChild(bg);
         array = info.giftRewardArr[0].property.split(",");
         prize = ComponentFactory.Instance.creatComponentByStylename("conRecharge.prize.btn");
         prize.id = i;
         tipStr = "";
         for(j = 0; j < info.giftRewardArr.length; )
         {
            itemInfo = ItemManager.Instance.getTemplateById(info.giftRewardArr[j].templateId) as ItemTemplateInfo;
            tipStr = tipStr + itemInfo.Name;
            if(info.giftRewardArr[j].validDate > 0)
            {
               tipStr = tipStr + ("(" + LanguageMgr.GetTranslation("ddt.conRecharge.leftDay",info.giftRewardArr[j].validDate) + ")");
            }
            tipStr = tipStr + (" x " + String(info.giftRewardArr[j].count) + "\n");
            j++;
         }
         prize.tipData = tipStr;
         container.addChild(prize);
         _cellArr.push(prize);
         _box = ClassUtils.CreatInstance("asset.conRecharge.box");
         if(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).giftInfoDic[info.giftbagId].times != 0)
         {
            _box.gotoAndStop(1);
            prize.enable = false;
            prize.mouseEnabled = true;
         }
         else if(judgeRechargeDay(info.giftConditionArr[0].remain1,info.giftConditionArr[0].conditionValue))
         {
            _box.gotoAndStop(2);
            prize.addEventListener("click",clickHandler);
         }
         else
         {
            _box.gotoAndStop(3);
            prize.enable = false;
            prize.mouseEnabled = true;
         }
         PositionUtils.setPos(_box,"asset.conRecharge.box.pos");
         _boxArr.push(_box);
         container.addChild(_box);
         _hBox.addChild(container);
         n++;
         i++;
      }
   }
   
   private function rechargeDayNum(money:int) : int
   {
      var p:int = 0;
      var nowIndex:* = 0;
      var i:int = 0;
      var j:* = 0;
      var info:* = null;
      var arr:Array = [];
      for(p = 0; p < WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr.length; )
      {
         if(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr[p].statusID != 0)
         {
            arr.push(WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr[p]);
         }
         p++;
      }
      arr.sortOn("statusID",16);
      var now:Date = TimeManager.Instance.Now();
      var nowInt:int = 10000 * now.getFullYear() + 100 * (now.getMonth() + 1) + now.getDate();
      for(i = 0; i < arr.length; )
      {
         if(arr[i].statusID == nowInt)
         {
            if(i == 0)
            {
               if(arr[i].statusValue == 0)
               {
                  return 0;
               }
               if(arr[i].statusValue >= money)
               {
                  return 1;
               }
               return 0;
            }
            if(arr[i].statusValue >= money)
            {
               nowIndex = i;
            }
            else
            {
               nowIndex = int(i - 1);
            }
            break;
         }
         i++;
      }
      var index:int = 0;
      for(j = nowIndex; j >= 0; )
      {
         info = arr[j];
         if(info.statusValue >= money)
         {
            index++;
            j--;
            continue;
         }
         return index;
      }
      return index;
   }
   
   private function judgeRechargeDay(day:int, money:int) : Boolean
   {
      var i:int = 0;
      var info:* = null;
      var j:int = 0;
      var moneyHave:Array = [];
      var arr:Array = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
      arr.sortOn("statusID",16);
      for(i = 0; i < arr.length; )
      {
         info = arr[i];
         info.my = i;
         if(info.statusID != 0)
         {
            if(info.statusValue >= money)
            {
               moneyHave.push(info);
            }
         }
         i++;
      }
      if(moneyHave.length < day)
      {
         return false;
      }
      for(j = day - 1; j < moneyHave.length; )
      {
         if(moneyHave[j].my - moneyHave[j - day + 1].my == day - 1)
         {
            return true;
         }
         j++;
      }
      return false;
   }
   
   private function clickHandler(e:MouseEvent) : void
   {
      var getAwardInfo:SendGiftInfo = new SendGiftInfo();
      getAwardInfo.activityId = ConRechargeManager.instance.actId;
      getAwardInfo.giftIdArr = [ConRechargeManager.instance.longGiftbagArray[_index][e.currentTarget.id].giftbagId];
      var data:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
      data.push(getAwardInfo);
      SocketManager.Instance.out.sendWonderfulActivityGetReward(data);
      e.currentTarget.enable = false;
      e.currentTarget.mouseEnabled = true;
      _boxArr[e.currentTarget.id].gotoAndStop(0);
   }
   
   override public function dispose() : void
   {
      var i:int = 0;
      super.dispose();
      for(i = 0; i < _cellArr.length; )
      {
         _cellArr[i].removeEventListener("click",clickHandler);
         i++;
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
