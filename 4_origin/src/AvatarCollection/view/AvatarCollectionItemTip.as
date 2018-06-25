package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionItemVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class AvatarCollectionItemTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _typeNameTxt:FilterFrameText;
      
      private var _typeValueTxt:FilterFrameText;
      
      private var _activityStatusTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _placeTxt:FilterFrameText;
      
      private var _notActivityTxt:FilterFrameText;
      
      private var _tempData:AvatarCollectionItemVo;
      
      private var _activityTxtList:Array;
      
      private var _placeTxtList:Array;
      
      public function AvatarCollectionItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _activityTxtList = LanguageMgr.GetTranslation("avatarCollection.itemTip.activityTxt").split(",");
         _placeTxtList = LanguageMgr.GetTranslation("avatarCollection.itemTip.placeValueStrTxt").split(",");
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _bg.width = 250;
         addChild(_bg);
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line.width = 110;
         _line.x = 42;
         _line.y = 51;
         addChild(_line);
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.titleTxt");
         _typeNameTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.itemTip.typeNameTxt");
         _typeNameTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.typeNameTxt");
         _typeValueTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.itemTip.typeValueTxt");
         _activityStatusTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.nameTxt");
         PositionUtils.setPos(_activityStatusTxt,"avatarColl.itemTip.activityStatusTxtPos");
         _needMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.nameTxt");
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.propertyTip.nameTxt");
         _notActivityTxt = ComponentFactory.Instance.creatComponentByStylename("avatarColl.itemCellTip.notActivityTxt");
         _notActivityTxt.text = _activityTxtList[1];
         _notActivityTxt.visible = false;
         addChild(_titleTxt);
         addChild(_typeNameTxt);
         addChild(_typeValueTxt);
         addChild(_activityStatusTxt);
         addChild(_needMoneyTxt);
         addChild(_placeTxt);
         addChild(_notActivityTxt);
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(data:Object) : void
      {
         _tempData = data as AvatarCollectionItemVo;
         if(!_tempData)
         {
            return;
         }
         var tmp:ItemTemplateInfo = _tempData.itemInfo;
         _titleTxt.text = tmp.Name;
         _typeValueTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.typeValueTxt",EquipType.PARTNAME[tmp.CategoryID]);
         _placeTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.placeTxt") + _placeTxtList[int(_tempData.proArea) - 1];
         if(_tempData.isActivity)
         {
            _activityStatusTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.activityStatusTxt") + _activityTxtList[0];
            _notActivityTxt.visible = false;
            _needMoneyTxt.visible = false;
            PositionUtils.setPos(_placeTxt,"avatarColl.itemTip.needGoldTxtPos");
         }
         else
         {
            _activityStatusTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.activityStatusTxt");
            _notActivityTxt.visible = true;
            _needMoneyTxt.visible = true;
            _needMoneyTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.needGoldTxt",_tempData.needGold);
            PositionUtils.setPos(_needMoneyTxt,"avatarColl.itemTip.needGoldTxtPos");
            PositionUtils.setPos(_placeTxt,"avatarColl.itemTip.placeTxtPos");
         }
         _bg.height = _placeTxt.y + 32;
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _line = null;
         _titleTxt = null;
         _typeNameTxt = null;
         _typeValueTxt = null;
         _activityStatusTxt = null;
         _needMoneyTxt = null;
         _placeTxt = null;
         _notActivityTxt = null;
         _tempData = null;
         _activityTxtList = null;
         super.dispose();
      }
   }
}
