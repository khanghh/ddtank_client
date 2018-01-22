package carnivalActivity.view.activityItem
{
   import carnivalActivity.CarnivalActivityControl;
   import carnivalActivity.view.CarnivalActivityItem;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class ActivationPotentialItem extends CarnivalActivityItem
   {
      
      protected static var PROLEN:int = 5;
       
      
      protected var _proOffset:int;
      
      protected var _goodIndex:int;
      
      public function ActivationPotentialItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         _goodIndex = int((_condtion - 1) / PROLEN);
         _proOffset = _condtion % PROLEN;
         var _loc2_:String = LanguageMgr.GetTranslation("activationPotential.goodsDescTxt" + _goodIndex);
         var _loc1_:String = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt" + _proOffset);
         _descTxt.text = LanguageMgr.GetTranslation("activationPotential.descTxt1",_loc2_,_loc1_);
         _descTxt.y = _descTxt.y + 9;
         _descTxt.height = _descTxt.height + 14;
      }
      
      override public function updateView() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         _playerAlreadyGetCount = _giftCurInfo.times;
         var _loc5_:int = 0;
         var _loc4_:* = _statusArr;
         for each(var _loc2_ in _statusArr)
         {
            _loc1_ = _proOffset == 0?PROLEN:int(_proOffset);
            if(_loc2_.statusID == _goodIndex * PROLEN + _loc1_)
            {
               if(_loc2_.statusValue > 0)
               {
                  _loc3_ = true;
               }
               else
               {
                  _loc3_ = false;
               }
               break;
            }
         }
         _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && _loc3_;
         _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
