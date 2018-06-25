package wonderfulActivity.newActivity.returnActivity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.items.GiftBagItem;
   import wonderfulActivity.items.PrizeListItem;
   
   public class ReturnListItem extends Sprite implements Disposeable
   {
       
      
      private var _back:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _prizeHBox:HBox;
      
      private var _prizeArr:Array;
      
      private var _btn:SimpleBitmapButton;
      
      private var _btnTxt:FilterFrameText;
      
      private var _tipsBtn:Bitmap;
      
      private var _type:int;
      
      private var _bgType:int;
      
      private var _actId:String;
      
      private var giftInfo:GiftBagInfo;
      
      private var condition:int;
      
      private var condition2:int;
      
      private var _canSelect:Boolean;
      
      private var _selectedIndex:int;
      
      public function ReturnListItem(type:int, bgType:int, actId:String)
      {
         super();
         _type = type;
         _bgType = bgType;
         _actId = actId;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.listItem");
         addChild(_back);
         if(_bgType == 0)
         {
            _back.gotoAndStop(1);
         }
         else
         {
            _back.gotoAndStop(2);
         }
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.returnItem.nameTxt");
         addChild(_nameTxt);
         _nameTxt.y = _back.height / 2 - _nameTxt.height / 2;
         _prizeHBox = ComponentFactory.Instance.creatComponentByStylename("wonderful.returnActivity.Hbox");
         addChild(_prizeHBox);
      }
      
      public function setData(desc:String, info:GiftBagInfo, canSelect:Boolean) : void
      {
         var dic:* = null;
         var i:int = 0;
         var item:* = null;
         var gift:* = null;
         var prizeItem:* = null;
         giftInfo = info;
         condition = giftInfo.giftConditionArr[0].conditionValue;
         desc = desc.replace(/\{0\}/g,condition);
         condition2 = giftInfo.giftConditionArr[1].conditionValue;
         if(condition2 == -1)
         {
            desc = desc.replace(/-\{1\}/g,LanguageMgr.GetTranslation("wonderfulActivity.above"));
         }
         else
         {
            desc = desc.replace(/\{1\}/g,condition2);
         }
         _nameTxt.text = desc;
         _nameTxt.y = _back.height / 2 - _nameTxt.height / 2;
         var rewardArr:Vector.<GiftRewardInfo> = giftInfo.giftRewardArr;
         _canSelect = canSelect;
         _prizeArr = [];
         if(_canSelect)
         {
            dic = classifyReward(rewardArr);
            for(i = 0; i <= 3; )
            {
               if(dic[i.toString()])
               {
                  item = new GiftBagItem(_type,i);
                  item.addEventListener("click",__itemClick);
                  _prizeHBox.addChild(item);
                  item.setData(dic[i]);
                  _prizeArr.push(item);
                  if(giftInfo.giftRewardArr.length <= 1)
                  {
                     _selectedIndex = item.index;
                  }
               }
               i++;
            }
            if(_prizeArr.length == 1)
            {
               (_prizeArr[0] as GiftBagItem).selected = true;
               _selectedIndex = 1;
            }
         }
         else
         {
            i = 0;
            while(i <= rewardArr.length - 1)
            {
               gift = rewardArr[i];
               prizeItem = new PrizeListItem();
               prizeItem.initView(i);
               prizeItem.setCellData(gift);
               _prizeHBox.addChild(prizeItem);
               _prizeArr.push(prizeItem);
               i++;
            }
         }
      }
      
      protected function __itemClick(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         for(i = 0; i <= _prizeArr.length - 1; )
         {
            _prizeArr[i].selected = false;
            i++;
         }
         var item:GiftBagItem = event.currentTarget as GiftBagItem;
         item.selected = true;
         _selectedIndex = item.index;
      }
      
      private function classifyReward(rewardVec:Vector.<GiftRewardInfo>) : Dictionary
      {
         var dic:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:* = rewardVec;
         for each(var info in rewardVec)
         {
            if(!dic[info.rewardType])
            {
               dic[info.rewardType] = new Vector.<GiftRewardInfo>();
            }
            (dic[info.rewardType] as Vector.<GiftRewardInfo>).push(info);
         }
         return dic;
      }
      
      public function setStatus(statusArr:Array, giftStatusDic:Dictionary) : void
      {
         var remain:int = 0;
         var payValue:int = 0;
         clearBtn();
         var alreadyGet:int = (giftStatusDic[giftInfo.giftbagId] as GiftCurInfo).times;
         var canReget:int = giftInfo.giftConditionArr[2].conditionValue;
         if(_type == 2 || _type == 3)
         {
            var _loc9_:int = 0;
            var _loc8_:* = statusArr;
            for each(var playerStatus in statusArr)
            {
               if(playerStatus.statusID == condition)
               {
                  remain = playerStatus.statusValue - alreadyGet;
               }
            }
         }
         else
         {
            payValue = statusArr[0].statusValue;
            remain = int(Math.floor(payValue / condition)) - alreadyGet;
         }
         if(canReget == 0)
         {
            if(remain > 0)
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.smallGetBtn");
               addChild(_btn);
               _btnTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.btnTxt");
               _btnTxt.text = "(" + remain + ")";
               _btn.addChild(_btnTxt);
               _tipsBtn = ComponentFactory.Instance.creat("wonderfulactivity.can.repeat");
               _btn.addChild(_tipsBtn);
               _btn.addEventListener("click",getRewardBtnClick);
            }
            else
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
               addChild(_btn);
               _tipsBtn = ComponentFactory.Instance.creat("wonderfulactivity.can.repeat");
               _tipsBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _btn.addChild(_tipsBtn);
               _btn.enable = false;
            }
         }
         else if(alreadyGet == 0)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
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
            _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.overBtn");
            _btn.enable = false;
            addChild(_btn);
         }
      }
      
      protected function getRewardBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_canSelect)
         {
            if(_selectedIndex <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.choosePrizeFirst"));
               return;
            }
         }
         var getAwardInfo:SendGiftInfo = new SendGiftInfo();
         getAwardInfo.activityId = _actId;
         var childInfo:GiftChildInfo = new GiftChildInfo();
         childInfo.giftId = giftInfo.giftbagId;
         childInfo.index = _selectedIndex;
         getAwardInfo.giftIdArr = [childInfo];
         var data:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         data.push(getAwardInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(data);
         _btn.enable = false;
      }
      
      private function clearBtn() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_btnTxt);
         _btnTxt = null;
         ObjectUtils.disposeObject(_tipsBtn);
         _tipsBtn = null;
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",getRewardBtnClick);
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         for(i = 0; i <= _prizeArr.length - 1; )
         {
            _prizeArr[i].removeEventListener("click",__itemClick);
            ObjectUtils.disposeObject(_prizeArr[i]);
            _prizeArr[i] = null;
            i++;
         }
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_prizeHBox);
         _prizeHBox = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_btnTxt);
         _btnTxt = null;
         ObjectUtils.disposeObject(_tipsBtn);
         _tipsBtn = null;
      }
   }
}
