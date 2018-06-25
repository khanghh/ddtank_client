package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class TurnRoundEggItem extends CarnivalActivityItem
   {
       
      
      protected var _remain:int;
      
      public function TurnRoundEggItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         var reValue:int = 0;
         var gift:* = undefined;
         var i:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         if(_descTxt)
         {
            gift = _info.giftConditionArr;
            for(i = 0; i < gift.length; )
            {
               if(gift[i].conditionIndex == 0)
               {
                  reValue = gift[i].remain1;
                  _condtion = gift[i].conditionValue;
               }
               i++;
            }
            if(_condtion == 1)
            {
               _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt27_1",reValue);
            }
            else
            {
               _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt27_2",reValue);
            }
         }
         if(_sumCount == 0)
         {
            _descTxt.y = _descTxt.y + 5;
         }
      }
      
      override protected function initData() : void
      {
         var i:int = 0;
         for(i = 0; i < _info.giftConditionArr.length; )
         {
            if(_info.giftConditionArr[i].conditionIndex == 0)
            {
               _condtion = _info.giftConditionArr[i].conditionValue;
               _remain = _info.giftConditionArr[i].remain1;
            }
            i++;
         }
      }
      
      override public function updateView() : void
      {
         var infoDic:Object = WonderfulActivityManager.Instance.activityInitData[_info.activityId];
         if(infoDic)
         {
            _giftCurInfo = infoDic.giftInfoDic[_info.giftbagId];
            _statusArr = infoDic.statusArr;
            _playerAlreadyGetCount = _giftCurInfo.times;
            var _loc4_:int = 0;
            var _loc3_:* = _statusArr;
            for each(var info in _statusArr)
            {
               if(info.statusID == _condtion)
               {
                  _currentCondtion = info.statusValue;
               }
            }
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _currentCondtion >= _remain;
            _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
            _awardCountTxt.text = (_currentCondtion > _remain?_remain:int(_currentCondtion)) + "/" + _remain;
         }
      }
   }
}
