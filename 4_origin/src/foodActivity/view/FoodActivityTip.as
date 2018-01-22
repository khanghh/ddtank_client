package foodActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class FoodActivityTip extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _contentTxt:FilterFrameText;
      
      protected var _awardsTxt:FilterFrameText;
      
      public function FoodActivityTip()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         _awardsTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         addChild(_bg);
         addChild(_contentTxt);
         addChild(_awardsTxt);
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(param1:int) : void
      {
         if(_tipWidth != param1)
         {
            _tipWidth = param1;
            updateTransform();
         }
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         _data = param1;
         _contentTxt.text = _data["content"];
         _awardsTxt.text = _data["awards"];
         updateTransform();
      }
      
      protected function updateTransform() : void
      {
         var _loc1_:int = _contentTxt.width > _awardsTxt.width?_contentTxt.width:Number(_awardsTxt.width);
         _bg.width = _loc1_ + 16;
         _bg.height = _contentTxt.height + _awardsTxt.height + 8;
         _contentTxt.x = _bg.x + 8;
         _contentTxt.y = _bg.y + 4;
         _awardsTxt.x = _contentTxt.x;
         _awardsTxt.y = _contentTxt.y + _contentTxt.height;
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_awardsTxt);
         _awardsTxt = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
