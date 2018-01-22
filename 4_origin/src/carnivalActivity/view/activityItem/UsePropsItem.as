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
      
      public function UsePropsItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initData() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _info.giftConditionArr.length)
         {
            _loc2_ = _info.giftConditionArr[_loc1_];
            if(_loc2_.conditionIndex > 50 && _loc2_.conditionIndex < 100)
            {
               _propId = _loc2_.conditionValue;
               _useCount = _loc2_.remain1;
            }
            _loc1_++;
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
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = _propId;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.BindType = 4;
         var _loc1_:BagCell = new BagCell(0);
         _loc1_.info = _loc2_;
         _loc1_.setCountNotVisible();
         return _loc1_;
      }
      
      override public function updateView() : void
      {
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         _playerAlreadyGetCount = _giftCurInfo.times;
         _allGiftAlreadyGetCount = _giftCurInfo.allGiftGetTimes;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _statusArr;
         for each(var _loc2_ in _statusArr)
         {
            if(_loc2_.statusID == _propId)
            {
               _loc1_ = _loc2_.statusValue;
            }
         }
         _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _loc1_ >= _useCount && (_sumCount == 0 || _sumCount - _allGiftAlreadyGetCount > 0);
         _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
         _descTxt.text = (_loc1_ > _useCount?_useCount:int(_loc1_)) + "/" + _useCount;
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
