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
      
      public function setState(type:int, id:int) : void
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
         var timeArr:* = null;
         var timeArr2:* = null;
         var i:int = 0;
         var itemIcon:* = null;
         var itemFilter:* = null;
         var bagCell:* = null;
         var itemIcon2:* = null;
         var itemFilter2:* = null;
         var bagCell2:* = null;
         if(!checkData())
         {
            return;
         }
         if(_activityInfo1)
         {
            timeArr = [_activityInfo1.beginTime.split(" ")[0],_activityInfo1.endTime.split(" ")[0]];
            _activetimeFilter.text = timeArr[0] + "-" + timeArr[1];
         }
         else if(_activityInfo2)
         {
            timeArr2 = [_activityInfo2.beginTime.split(" ")[0],_activityInfo2.endTime.split(" ")[0]];
            _activetimeFilter.text = timeArr2[0] + "-" + timeArr2[1];
         }
         i = 0;
         while(i < 4 && i < _numPower + _numGrade)
         {
            if(i < _numPower)
            {
               itemIcon = ComponentFactory.Instance.creat("wonderfulactivity.powerBitmap");
               itemIcon.x = itemIcon.x + 120 * i;
               addChild(itemIcon);
               itemFilter = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.heroTxt");
               itemFilter.x = itemFilter.x + 120 * i;
               itemFilter.text = _fightPowerArr[i];
               addChild(itemFilter);
               bagCell = createBagCell(i,_activityInfo1.giftbagArray[i]);
               bagCell.x = itemFilter.x + 22;
               bagCell.y = itemFilter.y + 45;
               addChild(bagCell);
            }
            else
            {
               itemIcon2 = ComponentFactory.Instance.creat("wonderfulactivity.levelBitmap");
               itemIcon2.x = itemIcon2.x + 120 * i;
               addChild(itemIcon2);
               itemFilter2 = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.heroTxt");
               itemFilter2.x = itemFilter2.x + 120 * i;
               itemFilter2.text = _gradeArr[i - _numPower];
               addChild(itemFilter2);
               bagCell2 = createBagCell(i,_activityInfo2.giftbagArray[i - _numPower]);
               bagCell2.x = itemIcon2.x + 32;
               bagCell2.y = itemFilter2.y + 45;
               addChild(bagCell2);
            }
            i++;
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
      
      private function createBagCell(order:int, giftBagInfo:GiftBagInfo) : BagCell
      {
         var gift:GiftRewardInfo = giftBagInfo.giftRewardArr[0];
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = gift.templateId;
         info = ItemManager.fill(info);
         info.IsBinds = gift.isBind;
         info.ValidDate = gift.validDate;
         var attrArr:Array = gift.property.split(",");
         info.StrengthenLevel = parseInt(attrArr[0]);
         info.AttackCompose = parseInt(attrArr[1]);
         info.DefendCompose = parseInt(attrArr[2]);
         info.AgilityCompose = parseInt(attrArr[3]);
         info.LuckCompose = parseInt(attrArr[4]);
         if(EquipType.isMagicStone(info.CategoryID))
         {
            info.Level = info.StrengthenLevel;
            info.Attack = info.AttackCompose;
            info.Defence = info.DefendCompose;
            info.Agility = info.AgilityCompose;
            info.Luck = info.LuckCompose;
            info.MagicAttack = parseInt(attrArr[6]);
            info.MagicDefence = parseInt(attrArr[7]);
            info.StrengthenExp = parseInt(attrArr[8]);
         }
         var bagCell:BagCell = new BagCell(order);
         bagCell.info = info;
         bagCell.setCount(gift.count);
         bagCell.setBgVisible(false);
         if(_giftInfoDic)
         {
            if(_giftInfoDic[giftBagInfo.giftbagId] && _giftInfoDic[giftBagInfo.giftbagId].times > 0)
            {
               var _loc7_:Boolean = true;
               bagCell.grayFilters = _loc7_;
               _bagCellGrayArr[order] = _loc7_;
            }
         }
         else
         {
            _loc7_ = false;
            bagCell.grayFilters = _loc7_;
            _bagCellGrayArr[order] = _loc7_;
         }
         _bagCellArr.push(bagCell);
         return bagCell;
      }
      
      private function initData() : void
      {
         var dic:* = null;
         var i:int = 0;
         var ig:int = 0;
         var dic2:* = null;
         var j:int = 0;
         var jg:int = 0;
         var _loc15_:int = 0;
         var _loc14_:* = WonderfulActivityManager.Instance.activityData;
         for each(var item in WonderfulActivityManager.Instance.activityData)
         {
            if(item.activityType == 7)
            {
               if(item.activityChildType == 0)
               {
                  if(WonderfulActivityManager.Instance.activityInitData[item.activityId])
                  {
                     if(!_giftInfoDic)
                     {
                        _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                     }
                     else
                     {
                        dic = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                        if(dic)
                        {
                           var _loc11_:int = 0;
                           var _loc10_:* = dic;
                           for(var key in dic)
                           {
                              _giftInfoDic[key] = dic[key];
                           }
                        }
                     }
                     _statusPowerArr = WonderfulActivityManager.Instance.activityInitData[item.activityId]["statusArr"];
                  }
                  _numPower = item.giftbagArray.length;
                  i = 0;
                  while(i < _numPower && i < 4)
                  {
                     for(ig = 0; ig < item.giftbagArray[i].giftConditionArr.length; )
                     {
                        if(item.giftbagArray[i].giftConditionArr[ig].conditionIndex == 0)
                        {
                           _fightPowerArr.push(item.giftbagArray[i].giftConditionArr[ig].conditionValue);
                        }
                        ig++;
                     }
                     i++;
                  }
                  _activityInfo1 = item;
                  _activityInfoArr.push(_activityInfo1);
               }
               else if(item.activityChildType == 1)
               {
                  if(WonderfulActivityManager.Instance.activityInitData[item.activityId])
                  {
                     if(!_giftInfoDic)
                     {
                        _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                     }
                     else
                     {
                        dic2 = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                        if(dic2)
                        {
                           var _loc13_:int = 0;
                           var _loc12_:* = dic2;
                           for(var key2 in dic2)
                           {
                              _giftInfoDic[key2] = dic2[key2];
                           }
                        }
                     }
                     _statusGradeArr = WonderfulActivityManager.Instance.activityInitData[item.activityId]["statusArr"];
                  }
                  _numGrade = item.giftbagArray.length;
                  j = 0;
                  while(j < _numGrade && j < 4)
                  {
                     for(jg = 0; jg < item.giftbagArray[j].giftConditionArr.length; )
                     {
                        if(item.giftbagArray[j].giftConditionArr[jg].conditionIndex == 0)
                        {
                           _gradeArr.push(item.giftbagArray[j].giftConditionArr[jg].conditionValue);
                        }
                        jg++;
                     }
                     j++;
                  }
                  _activityInfo2 = item;
                  _activityInfoArr.push(_activityInfo2);
               }
            }
         }
      }
      
      private function initCartoonPlayArr(fightPowerArr:Array, gradeArr:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         i = 0;
         while(i < fightPowerArr.length && i < 4)
         {
            if(_statusPowerArr && _statusPowerArr[0].statusValue >= fightPowerArr[i] && !_bagCellGrayArr[i])
            {
               _cartoonVisibleArr[i] = true;
            }
            else
            {
               _cartoonVisibleArr[i] = false;
            }
            i++;
         }
         for(j = 0; j < 4 - fightPowerArr.length; )
         {
            if(_statusGradeArr && _statusGradeArr[0].statusValue >= gradeArr[j] && !_bagCellGrayArr[i])
            {
               _cartoonVisibleArr[fightPowerArr.length + j] = true;
            }
            else
            {
               _cartoonVisibleArr[fightPowerArr.length + j] = false;
            }
            j++;
         }
      }
      
      private function initItem() : void
      {
         var i:int = 0;
         var mc:* = null;
         _cartoonList = new Vector.<MovieClip>();
         initCartoonPlayArr(_fightPowerArr,_gradeArr);
         for(i = 0; i < 4; )
         {
            if(_cartoonVisibleArr[i])
            {
               mc = ComponentFactory.Instance.creat("wonderfulactivity.cartoon");
               mc.mouseChildren = false;
               mc.mouseEnabled = false;
               mc.x = 268 + 120 * i;
               mc.y = 311;
               addChild(mc);
               _cartoonList.push(mc);
            }
            i++;
         }
         if(_cartoonList.length > 0)
         {
            _getButton.enable = true;
            _getButton.addEventListener("click",__getAward);
         }
      }
      
      private function __getAward(event:MouseEvent) : void
      {
         var ig:int = 0;
         var jg:int = 0;
         var i:int = 0;
         var sendInfo:* = null;
         var giftIdArr:* = null;
         var j:int = 0;
         SoundManager.instance.playButtonSound();
         for(ig = 0; ig < _bagCellArr.length; )
         {
            if(_cartoonVisibleArr[ig])
            {
               (_bagCellArr[ig] as BagCell).grayFilters = true;
            }
            ig++;
         }
         for(jg = 0; jg < _cartoonList.length; )
         {
            _cartoonList[jg].parent.removeChild(_cartoonList[jg]);
            jg++;
         }
         _getButton.enable = false;
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         for(i = 0; i < _activityInfoArr.length; )
         {
            sendInfo = new SendGiftInfo();
            sendInfo.activityId = _activityInfoArr[i].activityId;
            giftIdArr = [];
            for(j = 0; j < _activityInfoArr[i].giftbagArray.length; )
            {
               giftIdArr.push(_activityInfoArr[i].giftbagArray[j].giftbagId);
               j++;
            }
            sendInfo.giftIdArr = giftIdArr;
            sendInfoVec.push(sendInfo);
            i++;
         }
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
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
         for each(var mc in _cartoonList)
         {
            if(mc.parent)
            {
               mc.parent.removeChild(mc);
            }
            mc = null;
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
