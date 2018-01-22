package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class SanXiaoPropTip extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      private var _width:Number = 251;
      
      private var _height:Number = 82;
      
      private var _isDiscount:Boolean;
      
      private var _data:Object;
      
      private var _bg:ScaleBitmapImage;
      
      private var _detail:FilterFrameText;
      
      private var _cost:FilterFrameText;
      
      private var _discount:FilterFrameText;
      
      private var _separator:Image;
      
      public function SanXiaoPropTip()
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
         _detail = ComponentFactory.Instance.creat("core.commonTipText");
         _detail.multiline = true;
         _detail.wordWrap = true;
         _detail.width = _width - 8;
         _detail.x = 4;
         _detail.y = 4;
         addChild(_detail);
         _cost = ComponentFactory.Instance.creat("core.GoodsTipItemTxt");
         _cost.width = _width - 8;
         _cost.x = 4;
         _cost.y = 60;
         addChild(_cost);
      }
      
      public function get tipWidth() : int
      {
         return _width;
      }
      
      public function set tipWidth(param1:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return !!_isDiscount?_height + 28:Number(_height);
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function set tipData(param1:Object) : void
      {
         _detail.text = param1.detail;
         _cost.text = LanguageMgr.GetTranslation("sanxiao.propTipPrice",param1.price);
         _cost.textColor = 16711935;
         _isDiscount = param1.isDiscount;
         if(_isDiscount)
         {
            _separator || ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
            _separator.x = 14;
            _separator.y = 80;
            addChild(_separator);
            _discount || ComponentFactory.Instance.creat("core.redTxt");
            _discount.x = 4;
            _discount.y = 82;
            _discount.text = LanguageMgr.GetTranslation("sanxiao.propTipCurPrice",param1.curPrice);
            addChild(_discount);
         }
         else
         {
            ObjectUtils.disposeObject(_separator);
            ObjectUtils.disposeObject(_discount);
         }
         _bg.width = tipWidth;
         _bg.height = tipHeight;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_detail);
         ObjectUtils.disposeObject(_cost);
         ObjectUtils.disposeObject(_separator);
         ObjectUtils.disposeObject(_discount);
         _bg = null;
         _detail = null;
         _separator = null;
         _discount = null;
      }
   }
}
