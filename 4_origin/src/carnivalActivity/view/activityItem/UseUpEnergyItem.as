package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   
   public class UseUpEnergyItem extends CarnivalActivityItem
   {
       
      
      public function UseUpEnergyItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         if(_descTxt)
         {
            _descTxt.text = LanguageMgr.GetTranslation("carnival.descTxt" + _type,_condtion);
         }
         if(_sumCount == 0)
         {
            _descTxt.y = _descTxt.y + -2;
         }
      }
      
      override public function updateView() : void
      {
         var _loc1_:Object = WonderfulActivityManager.Instance.activityInitData[_info.activityId];
         if(_loc1_)
         {
            _giftCurInfo = _loc1_.giftInfoDic[_info.giftbagId];
            _statusArr = _loc1_.statusArr;
            _currentCondtion = _statusArr[0].statusValue;
            _playerAlreadyGetCount = _giftCurInfo.times;
            _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _currentCondtion >= _condtion;
            _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
            _getBtn.visible = !_alreadyGetBtn.visible;
            _awardCountTxt.text = (_currentCondtion > _condtion?_condtion:int(_currentCondtion)) + "/" + _condtion;
         }
      }
   }
}
