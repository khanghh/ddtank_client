package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.QualityType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BadgeTip extends Sprite implements ITip, Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _desTxt:FilterFrameText;
      
      private var _validDateTxt:FilterFrameText;
      
      private var _tipdata:Object;
      
      public function BadgeTip()
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.BadgeTipBg");
         addChild(_bg);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _line2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(_line1,"asset.core.badgeTipLinePos1");
         PositionUtils.setPos(_line2,"asset.core.badgeTipLinePos2");
         var _loc1_:int = 154;
         _line2.width = _loc1_;
         _line1.width = _loc1_;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.badgeTipNameTxt");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("core.badgeTip.DescriptionTxt");
         _validDateTxt = ComponentFactory.Instance.creatComponentByStylename("core.badgeTipItemDateTxt");
         addChild(_line1);
         addChild(_line2);
         addChild(_nameTxt);
         addChild(_desTxt);
         addChild(_validDateTxt);
      }
      
      public function get tipData() : Object
      {
         return _tipdata;
      }
      
      public function set tipData(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         _tipdata = param1;
         _nameTxt.text = _tipdata.name;
         _nameTxt.textColor = QualityType.QUALITY_COLOR[4];
         _desTxt.text = LanguageMgr.GetTranslation("core.badgeTip.description",_tipdata.LimitLevel);
         if(_tipdata.ValidDate)
         {
            var _loc4_:Boolean = true;
            _validDateTxt.visible = _loc4_;
            _line2.visible = _loc4_;
            _bg.height = 115;
            if(_tipdata.buyDate)
            {
               _loc3_ = _tipdata.buyDate;
               _loc2_ = _loc3_.time + _tipdata.ValidDate * 24 * 60 * 60 * 1000 - TimeManager.Instance.Now().time;
               _validDateTxt.text = LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripView.validity") + Math.ceil(_loc2_ / 86400000).toString() + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
            }
            else
            {
               _validDateTxt.text = LanguageMgr.GetTranslation("ddt.consortion.skillTip.validity",_tipdata.ValidDate + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day"));
            }
         }
         else
         {
            _bg.height = 90;
            _line2.visible = false;
            _validDateTxt.visible = false;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_line1);
         _line1 = null;
         ObjectUtils.disposeObject(_line2);
         _line2 = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_validDateTxt);
         _validDateTxt = null;
         _tipdata = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
