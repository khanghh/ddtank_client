package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import road7th.utils.StringHelper;
   
   public class OneLineTip extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _contentTxt:FilterFrameText;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function OneLineTip()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         addChild(_bg);
         addChild(_contentTxt);
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         _data = param1;
         _contentTxt.text = StringHelper.trim(String(_data));
         updateTransform();
      }
      
      protected function updateTransform() : void
      {
         _bg.width = _contentTxt.width + 16;
         _bg.height = _contentTxt.height + 8;
         _contentTxt.x = _bg.x + 8;
         _contentTxt.y = _bg.y + 4;
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
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
