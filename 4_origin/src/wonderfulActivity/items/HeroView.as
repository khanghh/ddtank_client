package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class HeroView extends Sprite implements IRightView
   {
       
      
      private var _back:Bitmap;
      
      private var _activeTimeBit:Bitmap;
      
      private var _activetimeFilter:FilterFrameText;
      
      private var _getButton:SimpleBitmapButton;
      
      private var _cartoonList:Vector.<MovieClip>;
      
      private var _cartoonVisibleArr:Array;
      
      private var _bagCellGrayArr:Array;
      
      private var _bagCellArr:Array;
      
      private var _mcNum:int;
      
      private var _info:SelfInfo;
      
      private var _fightPowerArr:Array;
      
      private var _gradeArr:Array;
      
      private var _numPower:int = 0;
      
      private var _numGrade:int = 0;
      
      private var _activityInfo1:GmActivityInfo;
      
      private var _activityInfo2:GmActivityInfo;
      
      private var _activityInfoArr:Array;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusPowerArr:Array;
      
      private var _statusGradeArr:Array;
      
      public function HeroView()
      {
         super();
         _fightPowerArr = [];
         _gradeArr = [];
         _activityInfoArr = [];
         _cartoonVisibleArr = [false,false,false,false];
         _bagCellGrayArr = [false,false,false,false];
         _bagCellArr = [];
         _info = PlayerManager.Instance.Self;
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function init() : void
      {
         initView();
         initData();
         initViewWithData();
      }
      
      private function initViewWithData() : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(!checkData())
         {
            return;
         }
         if(_activityInfo1)
         {
            _loc6_ = [_activityInfo1.beginTime.split(" ")[0],_activityInfo1.endTime.split(" ")[0]];
            _activetimeFilter.text = _loc6_[0] + "-" + _loc6_[1];
         }
         else if(_activityInfo2)
         {
            _loc7_ = [_activityInfo2.beginTime.split(" ")[0],_activityInfo2.endTime.split(" ")[0]];
            _activetimeFilter.text = _loc7_[0] + "-" + _loc7_[1];
         }
         _loc9_ = 0;
         while(_loc9_ < 4 && _loc9_ < _numPower + _numGrade)
         {
            if(_loc9_ < _numPower)
            {
               _loc8_ = ComponentFactory.Instance.creat("wonderfulactivity.powerBitmap");
               _loc8_.x = _loc8_.x + 120 * _loc9_;
               addChild(_loc8_);
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.heroTxt");
               _loc3_.x = _loc3_.x + 120 * _loc9_;
               _loc3_.text = _fightPowerArr[_loc9_];
               addChild(_loc3_);
               _loc2_ = createBagCell(_loc9_,_activityInfo1.giftbagArray[_loc9_]);
               _loc2_.x = _loc3_.x + 22;
               _loc2_.y = _loc3_.y + 45;
               addChild(_loc2_);
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creat("wonderfulactivity.levelBitmap");
               _loc1_.x = _loc1_.x + 120 * _loc9_;
               addChild(_loc1_);
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.heroTxt");
               _loc5_.x = _loc5_.x + 120 * _loc9_;
               _loc5_.text = _gradeArr[_loc9_ - _numPower];
               addChild(_loc5_);
               _loc4_ = createBagCell(_loc9_,_activityInfo2.giftbagArray[_loc9_ - _numPower]);
               _loc4_.x = _loc1_.x + 32;
               _loc4_.y = _loc5_.y + 45;
               addChild(_loc4_);
            }
            _loc9_++;
         }
         initItem();
      }
      
      private function checkData() : Boolean
      {
         if((_activityInfo1 || _activityInfo2) && (_fightPowerArr.length > 0 || _gradeArr.length > 0))
         {
            return true;
         }
         return false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.hero.back");
         addChild(_back);
         _activeTimeBit = ComponentFactory.Instance.creat("wonderfulactivity.activetime");
         addChild(_activeTimeBit);
         _activetimeFilter = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.activetimeTxt");
         addChild(_activetimeFilter);
         _getButton = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.GetButton");
         addChild(_getButton);
         _getButton.enable = false;
      }
      
      private function createBagCell(param1:int, param2:GiftBagInfo) : BagCell
      {
         var _loc4_:GiftRewardInfo = param2.giftRewardArr[0];
         var _loc6_:InventoryItemInfo = new InventoryItemInfo();
         _loc6_.TemplateID = _loc4_.templateId;
         _loc6_ = ItemManager.fill(_loc6_);
         _loc6_.IsBinds = _loc4_.isBind;
         _loc6_.ValidDate = _loc4_.validDate;
         var _loc5_:Array = _loc4_.property.split(",");
         _loc6_.StrengthenLevel = parseInt(_loc5_[0]);
         _loc6_.AttackCompose = parseInt(_loc5_[1]);
         _loc6_.DefendCompose = parseInt(_loc5_[2]);
         _loc6_.AgilityCompose = parseInt(_loc5_[3]);
         _loc6_.LuckCompose = parseInt(_loc5_[4]);
         if(EquipType.isMagicStone(_loc6_.CategoryID))
         {
            _loc6_.Level = _loc6_.StrengthenLevel;
            _loc6_.Attack = _loc6_.AttackCompose;
            _loc6_.Defence = _loc6_.DefendCompose;
            _loc6_.Agility = _loc6_.AgilityCompose;
            _loc6_.Luck = _loc6_.LuckCompose;
            _loc6_.MagicAttack = parseInt(_loc5_[6]);
            _loc6_.MagicDefence = parseInt(_loc5_[7]);
            _loc6_.StrengthenExp = parseInt(_loc5_[8]);
         }
         var _loc3_:BagCell = new BagCell(param1);
         _loc3_.info = _loc6_;
         _loc3_.setCount(_loc4_.count);
         _loc3_.setBgVisible(false);
         if(_giftInfoDic)
         {
            if(_giftInfoDic[param2.giftbagId] && _giftInfoDic[param2.giftbagId].times > 0)
            {
               var _loc7_:Boolean = true;
               _loc3_.grayFilters = _loc7_;
               _bagCellGrayArr[param1] = _loc7_;
            }
         }
         else
         {
            _loc7_ = false;
            _loc3_.grayFilters = _loc7_;
            _bagCellGrayArr[param1] = _loc7_;
         }
         _bagCellArr.push(_loc3_);
         return _loc3_;
      }
      
      private function initData() : void
      {
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc15_:int = 0;
         var _loc14_:* = WonderfulActivityManager.Instance.activityData;
         for each(var _loc4_ in WonderfulActivityManager.Instance.activityData)
         {
            if(_loc4_.activityType == 7)
            {
               if(_loc4_.activityChildType == 0)
               {
                  if(WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId])
                  {
                     if(!_giftInfoDic)
                     {
                        _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId]["giftInfoDic"];
                     }
                     else
                     {
                        _loc5_ = WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId]["giftInfoDic"];
                        if(_loc5_)
                        {
                           var _loc11_:int = 0;
                           var _loc10_:* = _loc5_;
                           for(var _loc8_ in _loc5_)
                           {
                              _giftInfoDic[_loc8_] = _loc5_[_loc8_];
                           }
                        }
                     }
                     _statusPowerArr = WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId]["statusArr"];
                  }
                  _numPower = _loc4_.giftbagArray.length;
                  _loc9_ = 0;
                  while(_loc9_ < _numPower && _loc9_ < 4)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < _loc4_.giftbagArray[_loc9_].giftConditionArr.length)
                     {
                        if(_loc4_.giftbagArray[_loc9_].giftConditionArr[_loc2_].conditionIndex == 0)
                        {
                           _fightPowerArr.push(_loc4_.giftbagArray[_loc9_].giftConditionArr[_loc2_].conditionValue);
                        }
                        _loc2_++;
                     }
                     _loc9_++;
                  }
                  _activityInfo1 = _loc4_;
                  _activityInfoArr.push(_activityInfo1);
               }
               else if(_loc4_.activityChildType == 1)
               {
                  if(WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId])
                  {
                     if(!_giftInfoDic)
                     {
                        _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId]["giftInfoDic"];
                     }
                     else
                     {
                        _loc7_ = WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId]["giftInfoDic"];
                        if(_loc7_)
                        {
                           var _loc13_:int = 0;
                           var _loc12_:* = _loc7_;
                           for(var _loc3_ in _loc7_)
                           {
                              _giftInfoDic[_loc3_] = _loc7_[_loc3_];
                           }
                        }
                     }
                     _statusGradeArr = WonderfulActivityManager.Instance.activityInitData[_loc4_.activityId]["statusArr"];
                  }
                  _numGrade = _loc4_.giftbagArray.length;
                  _loc6_ = 0;
                  while(_loc6_ < _numGrade && _loc6_ < 4)
                  {
                     _loc1_ = 0;
                     while(_loc1_ < _loc4_.giftbagArray[_loc6_].giftConditionArr.length)
                     {
                        if(_loc4_.giftbagArray[_loc6_].giftConditionArr[_loc1_].conditionIndex == 0)
                        {
                           _gradeArr.push(_loc4_.giftbagArray[_loc6_].giftConditionArr[_loc1_].conditionValue);
                        }
                        _loc1_++;
                     }
                     _loc6_++;
                  }
                  _activityInfo2 = _loc4_;
                  _activityInfoArr.push(_activityInfo2);
               }
            }
         }
      }
      
      private function initCartoonPlayArr(param1:Array, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length && _loc4_ < 4)
         {
            if(_statusPowerArr && _statusPowerArr[0].statusValue >= param1[_loc4_] && !_bagCellGrayArr[_loc4_])
            {
               _cartoonVisibleArr[_loc4_] = true;
            }
            else
            {
               _cartoonVisibleArr[_loc4_] = false;
            }
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 4 - param1.length)
         {
            if(_statusGradeArr && _statusGradeArr[0].statusValue >= param2[_loc3_] && !_bagCellGrayArr[_loc4_])
            {
               _cartoonVisibleArr[param1.length + _loc3_] = true;
            }
            else
            {
               _cartoonVisibleArr[param1.length + _loc3_] = false;
            }
            _loc3_++;
         }
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _cartoonList = new Vector.<MovieClip>();
         initCartoonPlayArr(_fightPowerArr,_gradeArr);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(_cartoonVisibleArr[_loc2_])
            {
               _loc1_ = ComponentFactory.Instance.creat("wonderfulactivity.cartoon");
               _loc1_.mouseChildren = false;
               _loc1_.mouseEnabled = false;
               _loc1_.x = 268 + 120 * _loc2_;
               _loc1_.y = 311;
               addChild(_loc1_);
               _cartoonList.push(_loc1_);
            }
            _loc2_++;
         }
         if(_cartoonList.length > 0)
         {
            _getButton.enable = true;
            _getButton.addEventListener("click",__getAward);
         }
      }
      
      private function __getAward(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         SoundManager.instance.playButtonSound();
         _loc3_ = 0;
         while(_loc3_ < _bagCellArr.length)
         {
            if(_cartoonVisibleArr[_loc3_])
            {
               (_bagCellArr[_loc3_] as BagCell).grayFilters = true;
            }
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _cartoonList.length)
         {
            _cartoonList[_loc2_].parent.removeChild(_cartoonList[_loc2_]);
            _loc2_++;
         }
         _getButton.enable = false;
         var _loc7_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         _loc8_ = 0;
         while(_loc8_ < _activityInfoArr.length)
         {
            _loc4_ = new SendGiftInfo();
            _loc4_.activityId = _activityInfoArr[_loc8_].activityId;
            _loc6_ = [];
            _loc5_ = 0;
            while(_loc5_ < _activityInfoArr[_loc8_].giftbagArray.length)
            {
               _loc6_.push(_activityInfoArr[_loc8_].giftbagArray[_loc5_].giftbagId);
               _loc5_++;
            }
            _loc4_.giftIdArr = _loc6_;
            _loc7_.push(_loc4_);
            _loc8_++;
         }
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc7_);
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         _getButton.removeEventListener("click",__getAward);
         _bagCellArr = null;
         var _loc3_:int = 0;
         var _loc2_:* = _cartoonList;
         for each(var _loc1_ in _cartoonList)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_ = null;
         }
         _cartoonList = null;
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
