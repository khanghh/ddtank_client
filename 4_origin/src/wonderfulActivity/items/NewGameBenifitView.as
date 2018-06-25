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
         if(!checkData())
         {
            return;
         }
         if(_activityInfo)
         {
            timeArr = [_activityInfo.beginTime.split(" ")[0],_activityInfo.endTime.split(" ")[0]];
            _activetimeFilter.text = timeArr[0] + "-" + timeArr[1];
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
         var i:int = 0;
         var j:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = WonderfulActivityManager.Instance.activityData;
         for each(var item in WonderfulActivityManager.Instance.activityData)
         {
            if(item.activityType == 0 && item.activityChildType == 5)
            {
               _activityInfo = item;
               if(WonderfulActivityManager.Instance.activityInitData[item.activityId])
               {
                  _giftInfoDic = WonderfulActivityManager.Instance.activityInitData[item.activityId]["giftInfoDic"];
                  _statusArr = WonderfulActivityManager.Instance.activityInitData[item.activityId]["statusArr"];
               }
               i = 0;
               while(i < item.giftbagArray.length)
               {
                  for(j = 0; j < item.giftbagArray[i].giftConditionArr.length; )
                  {
                     if(item.giftbagArray[i].giftConditionArr[j].conditionIndex == 0 && _chargeNumArr.length < 6)
                     {
                        _chargeNumArr.push(item.giftbagArray[i].giftConditionArr[j].conditionValue);
                     }
                     j++;
                  }
                  i++;
               }
               continue;
            }
         }
      }
      
      private function initProgressBar(totalMoney:int) : void
      {
         var i:int = 0;
         var progressComplete:* = null;
         _rectangle = new Rectangle();
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.height = _pBar.height;
         if(totalMoney < _chargeNumArr[0])
         {
            _rectangle.width = totalMoney / _chargeNumArr[0] * 35;
            _progressCompleteNum = 0;
         }
         else if(totalMoney >= _chargeNumArr[0] && totalMoney < _chargeNumArr[1])
         {
            _rectangle.width = 35 + (totalMoney - _chargeNumArr[0]) / (_chargeNumArr[1] - _chargeNumArr[0]) * 56;
            _progressCompleteNum = 1;
         }
         else if(totalMoney >= _chargeNumArr[1] && totalMoney < _chargeNumArr[2])
         {
            _rectangle.width = 91 + (totalMoney - _chargeNumArr[1]) / (_chargeNumArr[2] - _chargeNumArr[1]) * 56;
            _progressCompleteNum = 2;
         }
         else if(totalMoney >= _chargeNumArr[2] && totalMoney < _chargeNumArr[3])
         {
            _rectangle.width = 147 + (totalMoney - _chargeNumArr[2]) / (_chargeNumArr[3] - _chargeNumArr[2]) * 56;
            _progressCompleteNum = 3;
         }
         else if(totalMoney >= _chargeNumArr[3] && totalMoney < _chargeNumArr[4])
         {
            _rectangle.width = 203 + (totalMoney - _chargeNumArr[3]) / (_chargeNumArr[4] - _chargeNumArr[3]) * 56;
            _progressCompleteNum = 4;
         }
         else if(totalMoney >= _chargeNumArr[4] && totalMoney < _chargeNumArr[5])
         {
            _rectangle.width = 259 + (totalMoney - _chargeNumArr[4]) / (_chargeNumArr[5] - _chargeNumArr[4]) * 56;
            _progressCompleteNum = 5;
         }
         else if(totalMoney >= _chargeNumArr[5])
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
         _progressTip.tipData = totalMoney;
         _progressTip.back = new Bitmap(_pBar.bitmapData.clone());
         addChild(_progressTip);
         for(i = 0; i < _progressCompleteNum; )
         {
            progressComplete = ComponentFactory.Instance.creat("wonderfulactivity.newgamebenifit.progresscomplete");
            progressComplete.y = _progressBar.y - 2;
            progressComplete.x = 318 + _progressWidthArr[i] - 6;
            addChild(progressComplete);
            i++;
         }
         var enable:Boolean = true;
         if(_giftInfoDic && _progressCompleteNum >= 1)
         {
            if(_giftInfoDic[_activityInfo.giftbagArray[_progressCompleteNum - 1].giftbagId].times > 0)
            {
               enable = false;
            }
         }
         if(_progressCompleteNum > 0 && enable)
         {
            _getButton.enable = true;
            _getButton.addEventListener("click",__getAward);
         }
      }
      
      private function __getAward(event:MouseEvent) : void
      {
         var j:int = 0;
         SoundManager.instance.playButtonSound();
         _getButton.enable = false;
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var sendInfo:SendGiftInfo = new SendGiftInfo();
         sendInfo.activityId = _activityInfo.activityId;
         var giftIdArr:Array = [];
         for(j = 0; j < _activityInfo.giftbagArray.length; )
         {
            giftIdArr.push(_activityInfo.giftbagArray[j].giftbagId);
            j++;
         }
         sendInfo.giftIdArr = giftIdArr;
         sendInfoVec.push(sendInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      private function initItem() : void
      {
         var j:int = 0;
         var item:* = null;
         var i:int = 0;
         var itemLight:* = null;
         var itemTxt:* = null;
         for(j = 0; j < _chargeNumArr.length; )
         {
            item = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.itemButton");
            item.x = 330 + 55 * j + j;
            item.y = 294;
            _itemArr.push(item);
            item.addEventListener("click",itemClickHandler);
            addChild(item);
            j++;
         }
         for(i = 0; i < _chargeNumArr.length; )
         {
            itemLight = ComponentFactory.Instance.creatComponentByStylename("wonderful.ActivityState.itemLightButton");
            itemLight.x = 330 + 55 * i + i;
            itemLight.y = 279;
            _itemLightArr.push(itemLight);
            itemLight.addEventListener("click",itemClickHandler);
            addChild(itemLight);
            itemTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.newgameTxt");
            if(i == 0)
            {
               var _loc6_:Boolean = true;
               itemLight.visible = _loc6_;
               itemLight.enable = _loc6_;
               _currentTarget = itemLight;
            }
            else if(i == 1 || i == 2)
            {
               _loc6_ = false;
               itemLight.visible = _loc6_;
               itemLight.enable = _loc6_;
            }
            else
            {
               _loc6_ = false;
               itemLight.visible = _loc6_;
               itemLight.enable = _loc6_;
            }
            itemTxt.x = itemLight.x + 5;
            itemTxt.y = itemLight.y + 22;
            if(int(_chargeNumArr[i]) / 100000 >= 1)
            {
               itemTxt.text = int(_chargeNumArr[i]) / 10000 + "w";
            }
            else
            {
               itemTxt.text = _chargeNumArr[i];
            }
            addChild(itemTxt);
            i++;
         }
      }
      
      private function initAward() : void
      {
         var i:int = 0;
         var bagCellArr:* = null;
         var j:int = 0;
         var bagCell:* = null;
         if(_activityInfo.giftbagArray)
         {
            for(i = 0; i < _activityInfo.giftbagArray.length; )
            {
               bagCellArr = [];
               if(_activityInfo.giftbagArray[i].giftRewardArr)
               {
                  for(j = 0; j < _activityInfo.giftbagArray[i].giftRewardArr.length; )
                  {
                     bagCell = createBagCell(_activityInfo.giftbagArray[i].giftbagOrder,_activityInfo.giftbagArray[i].giftRewardArr[j]);
                     bagCell.x = _getButton.x - 89 + 63 * j;
                     bagCell.y = _getButton.y - 90;
                     addChild(bagCell);
                     bagCellArr.push(bagCell);
                     j++;
                  }
               }
               _bagCellDic[i] = bagCellArr;
               i++;
            }
         }
      }
      
      private function createBagCell(order:int, gift:GiftRewardInfo) : BagCell
      {
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
         return bagCell;
      }
      
      private function itemClickHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         if(event.target == _currentTarget)
         {
            return;
         }
         i = 0;
         while(i < _itemArr.length)
         {
            if(_itemArr[i] == event.target)
            {
               _currentTarget = _itemLightArr[i];
               setCurrentData(i);
               break;
            }
            i++;
         }
      }
      
      private function setCurrentData(index:int) : void
      {
         var i:int = 0;
         for(i = 0; i < _itemArr.length; )
         {
            if(i == index)
            {
               var _loc5_:Boolean = false;
               _itemArr[i].visible = _loc5_;
               _itemArr[i].enable = _loc5_;
               _loc5_ = true;
               _itemLightArr[i].visible = _loc5_;
               _itemLightArr[i].enable = _loc5_;
               if(_bagCellDic[i])
               {
                  var _loc7_:* = 0;
                  var _loc6_:* = _bagCellDic[i];
                  for each(var item in _bagCellDic[i])
                  {
                     item.visible = true;
                  }
               }
            }
            else
            {
               _loc5_ = true;
               _itemArr[i].visible = _loc5_;
               _itemArr[i].enable = _loc5_;
               _loc7_ = false;
               _itemLightArr[i].visible = _loc7_;
               _itemLightArr[i].enable = _loc7_;
               if(_bagCellDic[i])
               {
                  var _loc9_:int = 0;
                  var _loc8_:* = _bagCellDic[i];
                  for each(var item2 in _bagCellDic[i])
                  {
                     item2.visible = false;
                  }
               }
            }
            i++;
         }
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         _getButton.removeEventListener("click",__getAward);
         for(i = 0; i < _itemArr.length; )
         {
            (_itemArr[i] as SimpleBitmapButton).removeEventListener("click",itemClickHandler);
            i++;
         }
         for(j = 0; j < _itemArr.length; )
         {
            (_itemLightArr[j] as SimpleBitmapButton).removeEventListener("click",itemClickHandler);
            j++;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _bagCellDic;
         for each(var bagCellArr in _bagCellDic)
         {
            for(k = 0; k < bagCellArr.length; )
            {
               bagCellArr[k] = null;
               k++;
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
