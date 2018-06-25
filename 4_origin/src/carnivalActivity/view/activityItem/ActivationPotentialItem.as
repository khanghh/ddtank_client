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
      
      public function ActivationPotentialItem(type:int, info:GiftBagInfo, index:int)
      {
         super(type,info,index);
      }
      
      override protected function initItem() : void
      {
         _goodIndex = int((_condtion - 1) / PROLEN);
         _proOffset = _condtion % PROLEN;
         var good:String = LanguageMgr.GetTranslation("activationPotential.goodsDescTxt" + _goodIndex);
         var pro:String = LanguageMgr.GetTranslation("activationPotential.propertyDescTxt" + _proOffset);
         _descTxt.text = LanguageMgr.GetTranslation("activationPotential.descTxt1",good,pro);
         _descTxt.y = _descTxt.y + 9;
         _descTxt.height = _descTxt.height + 14;
      }
      
      override public function updateView() : void
      {
         var isReceive:Boolean = false;
         var temId:int = 0;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         _playerAlreadyGetCount = _giftCurInfo.times;
         var _loc5_:int = 0;
         var _loc4_:* = _statusArr;
         for each(var info in _statusArr)
         {
            temId = _proOffset == 0?PROLEN:int(_proOffset);
            if(info.statusID == _goodIndex * PROLEN + temId)
            {
               if(info.statusValue > 0)
               {
                  isReceive = true;
               }
               else
               {
                  isReceive = false;
               }
               break;
            }
         }
         _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _playerAlreadyGetCount == 0 && isReceive;
         _alreadyGetBtn.visible = _playerAlreadyGetCount > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
