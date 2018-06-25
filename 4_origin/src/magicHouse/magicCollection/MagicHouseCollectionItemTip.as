package magicHouse.magicCollection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class MagicHouseCollectionItemTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _typeNameTxt:FilterFrameText;
      
      private var _typeValueTxt:FilterFrameText;
      
      private var _activityStatusTxt:FilterFrameText;
      
      private var _detailTxt:FilterFrameText;
      
      private var _placeTxt:FilterFrameText;
      
      private var _activityTxt:FilterFrameText;
      
      private var _notActivityTxt:FilterFrameText;
      
      public function MagicHouseCollectionItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _bg.width = 225;
         addChild(_bg);
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line.width = 110;
         _line.x = 42;
         _line.y = 51;
         addChild(_line);
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.titleTxt");
         _typeNameTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.typeNameTxt");
         _typeValueTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.typeValueTxt");
         _activityStatusTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.nameTxt");
         PositionUtils.setPos(_activityStatusTxt,"magicHouse.collectionItemTip.activityStatusTxtPos");
         _activityTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.nameTxt");
         PositionUtils.setPos(_activityTxt,"magicHouse.collectionItemTip.activityTxtPos");
         addChild(_activityTxt);
         _detailTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.detailTxt");
         PositionUtils.setPos(_detailTxt,"magicHouse.collectionItemTip.detailTxtPos");
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.nameTxt");
         PositionUtils.setPos(_placeTxt,"magicHouse.collectionItemTip.placeTxtPos");
         _notActivityTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.notActivityTxt");
         _notActivityTxt.visible = false;
         addChild(_titleTxt);
         addChild(_typeNameTxt);
         addChild(_typeValueTxt);
         addChild(_activityStatusTxt);
         addChild(_detailTxt);
         addChild(_placeTxt);
         addChild(_notActivityTxt);
      }
      
      override public function set tipData(data:Object) : void
      {
         if(!data)
         {
            return;
         }
         _titleTxt.text = data.titleName;
         _typeNameTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.typeNameTxt");
         _typeValueTxt.text = data.type;
         _placeTxt.text = data.placed;
         var activateTxts:Array = LanguageMgr.GetTranslation("avatarCollection.itemTip.activityTxt").split(",");
         if(data.activate)
         {
            _activityTxt.text = activateTxts[0];
            _notActivityTxt.visible = false;
            _activityTxt.visible = true;
         }
         else
         {
            _notActivityTxt.text = activateTxts[1];
            _notActivityTxt.visible = true;
            _activityTxt.visible = false;
         }
         _activityStatusTxt.text = LanguageMgr.GetTranslation("avatarCollection.itemTip.activityStatusTxt");
         _detailTxt.text = data.datail;
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
         _detailTxt = null;
         _placeTxt = null;
         _activityTxt = null;
         _notActivityTxt = null;
         super.dispose();
      }
   }
}
