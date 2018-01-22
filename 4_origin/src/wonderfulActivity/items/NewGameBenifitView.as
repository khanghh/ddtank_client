package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import wonderfulActivity.views.IRightView;
   
   public class NewGameBenifitView extends Sprite implements IRightView
   {
       
      
      private var _back:Bitmap;
      
      private var _activeTimeBit:Bitmap;
      
      private var _activetimeFilter:FilterFrameText;
      
      private var _rectangle:Rectangle;
      
      private var _pBar:Bitmap;
      
      private var _progressBar:Bitmap;
      
      private var _progressBarBitmapData:BitmapData;
      
      private var _progressFrame:Bitmap;
      
      private var _progressComplete:Bitmap;
      
      private var _progressTip:NewGameBenifitTipSprite;
      
      private var _progressCompleteNum:int;
      
      private var _progressWidthArr:Array;
      
      private var _itemArr:Array;
      
      private var _itemLightArr:Array;
      
      private var _currentTarget;
      
      private var _awardArr:Array;
      
      private var _activityInfo:GmActivityInfo;
      
      private var _getButton:SimpleBitmapButton;
      
      private var _bagCellDic:Dictionary;
      
      private var _giftInfoDic:Dictionary;
      
      private var _statusArr:Array;
      
      private var _chargeNumArr:Array;
      
      public function NewGameBenifitView()
      {
         _progressWidthArr = [35,91,147,203,259,315];
         super();
         _itemArr = [];
         _itemLightArr = [];
         _awardArr = [];
         _chargeNumArr = [];
         _bagCellDic = new Dictionary();
         _progressTip = new NewGameBenifitTipSprite();
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
         var _loc1_:* = null;
         if(!checkData())
         {
            return;
         }
         if(_activityInfo)
         {
            _loc1_ = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
            _activetimeFilter.text = _loc1_[0] + "-" + _loc1_[1];
            _activetimeFilter.y = 202;
         }
         initProgressBar(!!_statusArr?_statusArr[0].statusValue:0);
         initItem();
         initAward();
         setCurrentData(0);
      }
      
      private function checkData() : Boolean
      {
         if(_activityInfo && _chargeNumArr.length >= 6)
         {
            return true;
         }
         return false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.newgamebenifit.back");
         addChild(_back);
         _activeTimeBit = ComponentFactory.Instance.creat("wonderfulactivity.activetime");
         _activeTimeBit.y = 195;
         addChild(_activeTimeBit);
         _activetimeFilter = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.activetimeTxt");
         addChild(_activetimeFilter);
         _progressFrame = ComponentFactory.Instance.creat("wonderfulactivity.newgamebenifit.progressframe");
         addChild(_progressFrame);
         _pBar = ComponentFactory.Instance.creat("wonderfulactivity.newgamebenifit.progressbar");
         _progressBar = new Bitmap();
         _progressBar.x = _pBar.x;
         _progressBar.y = _pBar.y;
         _progressTip.x = _progressBar.x;
         _progressTip.y = _progressBar.y;
         _getButton = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.GetButton");
         addChild(_getButton);
         _getButton.enable = false;
      }
      
      private function initData() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.activityData;
         for each(var _loc1_ in WonderfulActivityManager.Instance.activityData)
         {
            if(_loc1_.activityType == 0 && _loc1_.activityChildType == 5)
            {
               _activityInfo = _loc1_;
               if(WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId])
               {
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId]["giftInfoDic"];
                  _statusArr = WonderfulActivityManager.Instance.activityInitData[_loc1_.activityId]["statusArr"];
               }
               _loc3_ = 0;
               while(_loc3_ < _loc1_.giftbagArray.length)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc1_.giftbagArray[_loc3_].giftConditionArr.length)
                  {
                     if(_loc1_.giftbagArray[_loc3_].giftConditionArr[_loc2_].conditionIndex == 0 && _chargeNumArr.length < 6)
                     {
                        _chargeNumArr.push(_loc1_.giftbagArray[_loc3_].giftConditionArr[_loc2_].conditionValue);
                     }
                     _loc2_++;
                  }
                  _loc3_++;
               }
               continue;
            }
         }
      }
      
      private function initProgressBar(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _rectangle = new Rectangle();
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.height = _pBar.height;
         if(param1 < _chargeNumArr[0])
         {
            _rectangle.width = param1 / _chargeNumArr[0] * 35;
            _progressCompleteNum = 0;
         }
         else if(param1 >= _chargeNumArr[0] && param1 < _chargeNumArr[1])
         {
            _rectangle.width = 35 + (param1 - _chargeNumArr[0]) / (_chargeNumArr[1] - _chargeNumArr[0]) * 56;
            _progressCompleteNum = 1;
         }
         else if(param1 >= _chargeNumArr[1] && param1 < _chargeNumArr[2])
         {
            _rectangle.width = 91 + (param1 - _chargeNumArr[1]) / (_chargeNumArr[2] - _chargeNumArr[1]) * 56;
            _progressCompleteNum = 2;
         }
         else if(param1 >= _chargeNumArr[2] && param1 < _chargeNumArr[3])
         {
            _rectangle.width = 147 + (param1 - _chargeNumArr[2]) / (_chargeNumArr[3] - _chargeNumArr[2]) * 56;
            _progressCompleteNum = 3;
         }
         else if(param1 >= _chargeNumArr[3] && param1 < _chargeNumArr[4])
         {
            _rectangle.width = 203 + (param1 - _chargeNumArr[3]) / (_chargeNumArr[4] - _chargeNumArr[3]) * 56;
            _progressCompleteNum = 4;
         }
         else if(param1 >= _chargeNumArr[4] && param1 < _chargeNumArr[5])
         {
            _rectangle.width = 259 + (param1 - _chargeNumArr[4]) / (_chargeNumArr[5] - _chargeNumArr[4]) * 56;
            _progressCompleteNum = 5;
         }
         else if(param1 >= _chargeNumArr[5])
         {
            _rectangle.width = _pBar.width;
            _progressCompleteNum = 6;
         }
         if(_rectangle.width <= 0)
         {
            _rectangle.width = 1;
         }
         _rectangle.width = Math.ceil(_rectangle.width);
         _progressBarBitmapData = new BitmapData(_rectangle.width,_rectangle.height,true,0);
         _progressBarBitmapData.copyPixels(_pBar.bitmapData,_rectangle,new Point(0,0));
         _progressBar.bitmapData = _progressBarBitmapData;
         addChild(_progressBar);
         _progressTip.tipStyle = "ddt.view.tips.OneLineTip";
         _progressTip.tipDirctions = "0,1,2";
         _progressTip.tipData = param1;
         _progressTip.back = new Bitmap(_pBar.bitmapData.clone());
         addChild(_progressTip);
         _loc4_ = 0;
         while(_loc4_ < _progressCompleteNum)
         {
            _loc2_ = ComponentFactory.Instance.creat("wonderfulactivity.newgamebenifit.progresscomplete");
            _loc2_.y = _progressBar.y - 2;
            _loc2_.x = 318 + _progressWidthArr[_loc4_] - 6;
            addChild(_loc2_);
            _loc4_++;
         }
         var _loc3_:Boolean = true;
         if(_giftInfoDic && _progressCompleteNum >= 1)
         {
            if(_giftInfoDic[_activityInfo.giftbagArray[_progressCompleteNum - 1].giftbagId].times > 0)
            {
               _loc3_ = false;
            }
         }
         if(_progressCompleteNum > 0 && _loc3_)
         {
            _getButton.enable = true;
            _getButton.addEventListener("click",__getAward);
         }
      }
      
      private function __getAward(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.playButtonSound();
         _getButton.enable = false;
         var _loc5_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc2_:SendGiftInfo = new SendGiftInfo();
         _loc2_.activityId = _activityInfo.activityId;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _activityInfo.giftbagArray.length)
         {
            _loc4_.push(_activityInfo.giftbagArray[_loc3_].giftbagId);
            _loc3_++;
         }
         _loc2_.giftIdArr = _loc4_;
         _loc5_.push(_loc2_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc5_);
      }
      
      private function initItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _chargeNumArr.length)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.itemButton");
            _loc2_.x = 330 + 55 * _loc3_ + _loc3_;
            _loc2_.y = 294;
            _itemArr.push(_loc2_);
            _loc2_.addEventListener("click",itemClickHandler);
            addChild(_loc2_);
            _loc3_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _chargeNumArr.length)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.itemLightButton");
            _loc4_.x = 330 + 55 * _loc5_ + _loc5_;
            _loc4_.y = 279;
            _itemLightArr.push(_loc4_);
            _loc4_.addEventListener("click",itemClickHandler);
            addChild(_loc4_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.newgameTxt");
            if(_loc5_ == 0)
            {
               var _loc6_:Boolean = true;
               _loc4_.visible = _loc6_;
               _loc4_.enable = _loc6_;
               _currentTarget = _loc4_;
            }
            else if(_loc5_ == 1 || _loc5_ == 2)
            {
               _loc6_ = false;
               _loc4_.visible = _loc6_;
               _loc4_.enable = _loc6_;
            }
            else
            {
               _loc6_ = false;
               _loc4_.visible = _loc6_;
               _loc4_.enable = _loc6_;
            }
            _loc1_.x = _loc4_.x + 5;
            _loc1_.y = _loc4_.y + 22;
            if(int(_chargeNumArr[_loc5_]) / 100000 >= 1)
            {
               _loc1_.text = int(_chargeNumArr[_loc5_]) / 10000 + "w";
            }
            else
            {
               _loc1_.text = _chargeNumArr[_loc5_];
            }
            addChild(_loc1_);
            _loc5_++;
         }
      }
      
      private function initAward() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         if(_activityInfo.giftbagArray)
         {
            _loc4_ = 0;
            while(_loc4_ < _activityInfo.giftbagArray.length)
            {
               _loc2_ = [];
               if(_activityInfo.giftbagArray[_loc4_].giftRewardArr)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _activityInfo.giftbagArray[_loc4_].giftRewardArr.length)
                  {
                     _loc1_ = createBagCell(_activityInfo.giftbagArray[_loc4_].giftbagOrder,_activityInfo.giftbagArray[_loc4_].giftRewardArr[_loc3_]);
                     _loc1_.x = _getButton.x - 89 + 63 * _loc3_;
                     _loc1_.y = _getButton.y - 90;
                     addChild(_loc1_);
                     _loc2_.push(_loc1_);
                     _loc3_++;
                  }
               }
               _bagCellDic[_loc4_] = _loc2_;
               _loc4_++;
            }
         }
      }
      
      private function createBagCell(param1:int, param2:GiftRewardInfo) : BagCell
      {
         var _loc5_:InventoryItemInfo = new InventoryItemInfo();
         _loc5_.TemplateID = param2.templateId;
         _loc5_ = ItemManager.fill(_loc5_);
         _loc5_.IsBinds = param2.isBind;
         _loc5_.ValidDate = param2.validDate;
         var _loc4_:Array = param2.property.split(",");
         _loc5_.StrengthenLevel = parseInt(_loc4_[0]);
         _loc5_.AttackCompose = parseInt(_loc4_[1]);
         _loc5_.DefendCompose = parseInt(_loc4_[2]);
         _loc5_.AgilityCompose = parseInt(_loc4_[3]);
         _loc5_.LuckCompose = parseInt(_loc4_[4]);
         if(EquipType.isMagicStone(_loc5_.CategoryID))
         {
            _loc5_.Level = _loc5_.StrengthenLevel;
            _loc5_.Attack = _loc5_.AttackCompose;
            _loc5_.Defence = _loc5_.DefendCompose;
            _loc5_.Agility = _loc5_.AgilityCompose;
            _loc5_.Luck = _loc5_.LuckCompose;
            _loc5_.MagicAttack = parseInt(_loc4_[6]);
            _loc5_.MagicDefence = parseInt(_loc4_[7]);
            _loc5_.StrengthenExp = parseInt(_loc4_[8]);
         }
         var _loc3_:BagCell = new BagCell(param1);
         _loc3_.info = _loc5_;
         _loc3_.setCount(param2.count);
         _loc3_.setBgVisible(false);
         return _loc3_;
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.target == _currentTarget)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _itemArr.length)
         {
            if(_itemArr[_loc2_] == param1.target)
            {
               _currentTarget = _itemLightArr[_loc2_];
               setCurrentData(_loc2_);
               break;
            }
            _loc2_++;
         }
      }
      
      private function setCurrentData(param1:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _itemArr.length)
         {
            if(_loc4_ == param1)
            {
               var _loc5_:Boolean = false;
               _itemArr[_loc4_].visible = _loc5_;
               _itemArr[_loc4_].enable = _loc5_;
               _loc5_ = true;
               _itemLightArr[_loc4_].visible = _loc5_;
               _itemLightArr[_loc4_].enable = _loc5_;
               if(_bagCellDic[_loc4_])
               {
                  var _loc7_:* = 0;
                  var _loc6_:* = _bagCellDic[_loc4_];
                  for each(var _loc3_ in _bagCellDic[_loc4_])
                  {
                     _loc3_.visible = true;
                  }
               }
            }
            else
            {
               _loc5_ = true;
               _itemArr[_loc4_].visible = _loc5_;
               _itemArr[_loc4_].enable = _loc5_;
               _loc7_ = false;
               _itemLightArr[_loc4_].visible = _loc7_;
               _itemLightArr[_loc4_].enable = _loc7_;
               if(_bagCellDic[_loc4_])
               {
                  var _loc9_:int = 0;
                  var _loc8_:* = _bagCellDic[_loc4_];
                  for each(var _loc2_ in _bagCellDic[_loc4_])
                  {
                     _loc2_.visible = false;
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _getButton.removeEventListener("click",__getAward);
         _loc4_ = 0;
         while(_loc4_ < _itemArr.length)
         {
            (_itemArr[_loc4_] as SimpleBitmapButton).removeEventListener("click",itemClickHandler);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _itemArr.length)
         {
            (_itemLightArr[_loc2_] as SimpleBitmapButton).removeEventListener("click",itemClickHandler);
            _loc2_++;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _bagCellDic;
         for each(var _loc1_ in _bagCellDic)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc1_[_loc3_] = null;
               _loc3_++;
            }
         }
         _bagCellDic = null;
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
