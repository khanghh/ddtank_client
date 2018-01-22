package carnivalActivity.view
{
   import carnivalActivity.CarnivalActivityControl;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class DailyGiftItem extends CarnivalActivityItem
   {
       
      
      private var _count:int;
      
      private var _temId:int;
      
      private var _getGoodsType:int;
      
      private var _beadGrade:int;
      
      private var _magicStoneQuality:int;
      
      private var _actType:int;
      
      public function DailyGiftItem(param1:int, param2:GiftBagInfo, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _awardCountTxt = ComponentFactory.Instance.creatComponentByStylename("carnivalAct.countTxt");
         addChild(_awardCountTxt);
         _loc2_ = 0;
         while(_loc2_ < _info.giftConditionArr.length)
         {
            if(_info.giftConditionArr[_loc2_].conditionIndex == 0)
            {
               _actType = 1;
            }
            else if(_info.giftConditionArr[_loc2_].conditionIndex == 1)
            {
               _actType = 2;
               _count = _info.giftConditionArr[_loc2_].remain1;
               _getGoodsType = int(_info.giftConditionArr[_loc2_].remain2);
               if(_getGoodsType == 2)
               {
                  _beadGrade = _info.giftConditionArr[_loc2_].conditionValue;
               }
               else
               {
                  _magicStoneQuality = _info.giftConditionArr[_loc2_].conditionValue;
               }
            }
            else if(_info.giftConditionArr[_loc2_].conditionIndex == 2)
            {
               _actType = 3;
            }
            else if(_info.giftConditionArr[_loc2_].conditionIndex != 3)
            {
               if(_info.giftConditionArr[_loc2_].conditionIndex > 50 && _info.giftConditionArr[_loc2_].conditionIndex < 100)
               {
                  _temId = _info.giftConditionArr[_loc2_].conditionValue;
                  _count = _info.giftConditionArr[_loc2_].remain1;
               }
            }
            _loc2_++;
         }
         _descTxt.height = _descTxt.height * 2;
         if(_actType == 1)
         {
            _descTxt.y = _descTxt.y - 8;
            _awardCountTxt.y = _awardCountTxt.y + 7;
            _descTxt.text = LanguageMgr.GetTranslation("dailyGift.useType.descTxt",_count,ItemManager.Instance.getTemplateById(_temId).Name);
         }
         else if(_actType == 2)
         {
            if(_getGoodsType == 1)
            {
               _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.descTxt" + _getGoodsType,_count);
            }
            else if(_getGoodsType == 2)
            {
               _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.descTxt" + _getGoodsType,_count,_beadGrade);
            }
            else
            {
               _loc1_ = _magicStoneQuality / 100;
               _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.descTxt" + _getGoodsType,_count,QualityType.QUALITY_STRING[_loc1_]);
            }
         }
         else
         {
            _descTxt.y = _descTxt.y - 8;
            _awardCountTxt.y = _awardCountTxt.y + 7;
            _descTxt.text = LanguageMgr.GetTranslation("dailyGift.getType.plantTxt",_count,ItemManager.Instance.getTemplateById(_temId).Name);
         }
      }
      
      override public function updateView() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         _giftCurInfo = WonderfulActivityManager.Instance.activityInitData[_info.activityId].giftInfoDic[_info.giftbagId];
         _statusArr = WonderfulActivityManager.Instance.activityInitData[_info.activityId].statusArr;
         var _loc5_:int = 0;
         var _loc4_:* = _statusArr;
         for each(var _loc3_ in _statusArr)
         {
            if(_actType == 1 || _actType == 3)
            {
               if(_loc3_.statusID == _temId)
               {
                  _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _loc3_.statusValue >= _count;
                  _awardCountTxt.text = _loc3_.statusValue + "/" + _count;
               }
            }
            else if(_getGoodsType == 3)
            {
               if(_loc3_.statusID == _magicStoneQuality)
               {
                  _loc1_ = _loc3_;
               }
            }
            else if(_getGoodsType == 2)
            {
               if(_loc3_.statusID == _beadGrade)
               {
                  _loc2_ = _loc3_;
               }
            }
            else
            {
               _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _giftCurInfo.times == 0 && _loc3_.statusValue >= _count;
               _awardCountTxt.text = _loc3_.statusValue + "/" + _count;
            }
         }
         if(_actType == 2)
         {
            if(_getGoodsType == 3)
            {
               _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _loc1_?_giftCurInfo.times == 0 && _loc1_.statusValue >= _count:false;
               _awardCountTxt.text = (!!_loc1_?_loc1_.statusValue:0) + "/" + _count;
            }
            else if(_getGoodsType == 2)
            {
               _getBtn.enable = CarnivalActivityControl.instance.canGetAward() && _loc2_?_giftCurInfo.times == 0 && _loc2_.statusValue >= _count:false;
               _awardCountTxt.text = (!!_loc2_?_loc2_.statusValue:0) + "/" + _count;
            }
         }
         _alreadyGetBtn.visible = _giftCurInfo.times > 0;
         _getBtn.visible = !_alreadyGetBtn.visible;
      }
   }
}
