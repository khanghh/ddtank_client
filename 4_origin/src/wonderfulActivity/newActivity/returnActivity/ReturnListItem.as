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
      
      public function ReturnListItem(param1:int, param2:int, param3:String)
      {
         super();
         _type = param1;
         _bgType = param2;
         _actId = param3;
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
      
      public function setData(param1:String, param2:GiftBagInfo, param3:Boolean) : void
      {
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         giftInfo = param2;
         condition = giftInfo.giftConditionArr[0].conditionValue;
         param1 = param1.replace(/\{0\}/g,condition);
         condition2 = giftInfo.giftConditionArr[1].conditionValue;
         if(condition2 == -1)
         {
            param1 = param1.replace(/-\{1\}/g,LanguageMgr.GetTranslation("wonderfulActivity.above"));
         }
         else
         {
            param1 = param1.replace(/\{1\}/g,condition2);
         }
         _nameTxt.text = param1;
         _nameTxt.y = _back.height / 2 - _nameTxt.height / 2;
         var _loc4_:Vector.<GiftRewardInfo> = giftInfo.giftRewardArr;
         _canSelect = param3;
         _prizeArr = [];
         if(_canSelect)
         {
            _loc8_ = classifyReward(_loc4_);
            _loc9_ = 0;
            while(_loc9_ <= 3)
            {
               if(_loc8_[_loc9_.toString()])
               {
                  _loc7_ = new GiftBagItem(_type,_loc9_);
                  _loc7_.addEventListener("click",__itemClick);
                  _prizeHBox.addChild(_loc7_);
                  _loc7_.setData(_loc8_[_loc9_]);
                  _prizeArr.push(_loc7_);
                  if(giftInfo.giftRewardArr.length <= 1)
                  {
                     _selectedIndex = _loc7_.index;
                  }
               }
               _loc9_++;
            }
            if(_prizeArr.length == 1)
            {
               (_prizeArr[0] as GiftBagItem).selected = true;
               _selectedIndex = 1;
            }
         }
         else
         {
            _loc9_ = 0;
            while(_loc9_ <= _loc4_.length - 1)
            {
               _loc6_ = _loc4_[_loc9_];
               _loc5_ = new PrizeListItem();
               _loc5_.initView(_loc9_);
               _loc5_.setCellData(_loc6_);
               _prizeHBox.addChild(_loc5_);
               _prizeArr.push(_loc5_);
               _loc9_++;
            }
         }
      }
      
      protected function __itemClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         _loc3_ = 0;
         while(_loc3_ <= _prizeArr.length - 1)
         {
            _prizeArr[_loc3_].selected = false;
            _loc3_++;
         }
         var _loc2_:GiftBagItem = param1.currentTarget as GiftBagItem;
         _loc2_.selected = true;
         _selectedIndex = _loc2_.index;
      }
      
      private function classifyReward(param1:Vector.<GiftRewardInfo>) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(!_loc2_[_loc3_.rewardType])
            {
               _loc2_[_loc3_.rewardType] = new Vector.<GiftRewardInfo>();
            }
            (_loc2_[_loc3_.rewardType] as Vector.<GiftRewardInfo>).push(_loc3_);
         }
         return _loc2_;
      }
      
      public function setStatus(param1:Array, param2:Dictionary) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         clearBtn();
         var _loc4_:int = (param2[giftInfo.giftbagId] as GiftCurInfo).times;
         var _loc3_:int = giftInfo.giftConditionArr[2].conditionValue;
         if(_type == 2 || _type == 3)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1;
            for each(var _loc6_ in param1)
            {
               if(_loc6_.statusID == condition)
               {
                  _loc5_ = _loc6_.statusValue - _loc4_;
               }
            }
         }
         else
         {
            _loc7_ = param1[0].statusValue;
            _loc5_ = int(Math.floor(_loc7_ / condition)) - _loc4_;
         }
         if(_loc3_ == 0)
         {
            if(_loc5_ > 0)
            {
               _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.smallGetBtn");
               addChild(_btn);
               _btnTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.btnTxt");
               _btnTxt.text = "(" + _loc5_ + ")";
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
         else if(_loc4_ == 0)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.bigGetBtn");
            addChild(_btn);
            _btn.enable = false;
            if(_loc5_ > 0)
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
      
      protected function getRewardBtnClick(param1:MouseEvent) : void
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
         var _loc4_:SendGiftInfo = new SendGiftInfo();
         _loc4_.activityId = _actId;
         var _loc2_:GiftChildInfo = new GiftChildInfo();
         _loc2_.giftId = giftInfo.giftbagId;
         _loc2_.index = _selectedIndex;
         _loc4_.giftIdArr = [_loc2_];
         var _loc3_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         _loc3_.push(_loc4_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc3_);
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
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ <= _prizeArr.length - 1)
         {
            _prizeArr[_loc1_].removeEventListener("click",__itemClick);
            ObjectUtils.disposeObject(_prizeArr[_loc1_]);
            _prizeArr[_loc1_] = null;
            _loc1_++;
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
