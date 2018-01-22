package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class AttributeItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _txt:FilterFrameText;
      
      public function AttributeItem(param1:String = "indiana.attribute.Txt")
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.bg");
         _txt = ComponentFactory.Instance.creatComponentByStylename(param1);
         _txt.x = 4;
         _txt.y = 1;
         addChild(_bg);
         addChild(_txt);
      }
      
      public function setWidth(param1:int) : void
      {
         if(_bg)
         {
            _bg.width = param1;
         }
      }
      
      public function setView(param1:DisplayObject) : void
      {
         if(param1)
         {
            addChild(param1);
         }
      }
      
      override public function get width() : Number
      {
         return 24;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function set fontColor(param1:int) : void
      {
         var _loc2_:* = null;
         if(_txt)
         {
            _loc2_ = _txt.defaultTextFormat;
            _loc2_.color = param1;
            _txt.defaultTextFormat = _loc2_;
         }
      }
      
      public function set Filter(param1:Array) : void
      {
         var _loc2_:* = null;
         if(_txt)
         {
            _loc2_ = _txt.defaultTextFormat;
            _txt.filters = param1;
         }
      }
      
      public function get textField() : FilterFrameText
      {
         return _txt;
      }
      
      public function setDis(param1:String) : void
      {
         if(_txt)
         {
            _txt.text = param1;
         }
         _bg.width = _txt.textWidth + 10;
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _txt = null;
      }
   }
}
