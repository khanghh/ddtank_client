package carnivalActivity.view.activityItem
{
   import bagAndInfo.cell.BagCell;
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class UsePropsItem extends CarnivalActivityItem
   {
       
      
      protected var _propId:int;
      
      protected var _useCount:int;
      
      protected var _propCell:BagCell;
      
      public function UsePropsItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initData() : void
      {
         var info:* = null;
         var i:int = 0;
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            info = _info.giftConditionArr[i];
            if(info.conditionIndex > 50 && info.conditionIndex < 100)
            {
               _propId = info.conditionValue;
               _useCount = info.remain1;
            }
            i++;
         }
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = ComponentFactory.Instance.creat("carnicalAct.fourCol.listItem" + _index);
         addChild(_bg);
         _propCell = createProp();
         addChild(_propCell);
         PositionUtils.setPos(_propCell,"carnivalAct.usePropPos");
         PositionUtils.setPos(_descTxt,"carnivalAct.usePropCountPos");
         addChild(_descTxt);
         PositionUtils.setPos(_goodContent,"carnivalAct.goodCellsGroupPos");
         addChild(_goodContent);
         PositionUtils.setPos(_getBtn,"carnivalAct.propgetBtnPos");
         addChild(_getBtn);
         PositionUtils.setPos(_alreadyGetBtn,"carnivalAct.propAlreadygetBtnPos");
         addChild(_alreadyGetBtn);
      }
      
      override protected function initItem() : void
      {
         _descTxt.text = _useCount.toString();
      }
      
      protected function createProp() : BagCell
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = _propId;
         info = ItemManager.fill(info);
         info.BindType = 4;
         var cell:BagCell = new BagCell(0);
         cell.info = info;
         cell.setCountNotVisible();
         return cell;
      }
      
      override public function updateView() : void
      {
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         _playerAlreadyGetCount = _giftCurInfo.times;
         _allGiftAlreadyGetCount = _giftCurInfo.allGiftGetTimes;
         var currentUseCount:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _statusArr;
         for each(var info in _statusArr)
         {
            if(info.statusID == _propId)
            {
               currentUseCount = info.statusValue;
            }
         }
         _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && currentUseCount >= _useCount && (_sumCount == 0 || _sumCount - _allGiftAlreadyGetCount > 0);
         _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
         _descTxt.text = (currentUseCount > _useCount?_useCount:int(currentUseCount)) + "/" + _useCount;
      }
      
      override public function dispose() : void
      {
         if(_propCell)
         {
            ObjectUtils.disposeObject(_propCell);
         }
         _propCell = null;
         super.dispose();
      }
   }
}
