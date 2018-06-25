package store.view.embed
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class EmbedStoneTip extends GoodTip
   {
      
      public static const P_backgoundInnerRect:String = "backOutterRect";
      
      public static const P_tipTextField:String = "tipTextField";
       
      
      protected var _backInnerRect:InnerRectangle;
      
      protected var _backgoundInnerRectString:String;
      
      protected var _tipTextField:TextField;
      
      protected var _tipTextStyle:String;
      
      private var _currentData:Object;
      
      public function EmbedStoneTip()
      {
         super();
      }
      
      public function set backgoundInnerRectString(value:String) : void
      {
         if(_backgoundInnerRectString == value)
         {
            return;
         }
         _backgoundInnerRectString = value;
         _backInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_backgoundInnerRectString));
         onPropertiesChanged("backOutterRect");
      }
      
      override public function dispose() : void
      {
         if(_tipTextField)
         {
            ObjectUtils.disposeObject(_tipTextField);
         }
         _tipTextField = null;
         super.dispose();
      }
      
      public function set tipTextField(field:TextField) : void
      {
         if(_tipTextField == field)
         {
            return;
         }
         ObjectUtils.disposeObject(_tipTextField);
         _tipTextField = field;
         onPropertiesChanged("tipTextField");
      }
      
      public function set tipTextStyle(stylename:String) : void
      {
         if(_tipTextStyle == stylename)
         {
            return;
         }
         _tipTextStyle = stylename;
         tipTextField = ComponentFactory.Instance.creat(_tipTextStyle);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_tipTextField)
         {
            addChild(_tipTextField);
         }
         if(_tipData is DisplayObject)
         {
            addChild(_tipData as DisplayObject);
         }
      }
      
      override public function get tipData() : Object
      {
         return _currentData;
      }
      
      override public function set tipData(data:Object) : void
      {
         var rectangle:* = null;
         var obj:* = null;
         if(data as String)
         {
            if(data is String)
            {
               _tipTextField.wordWrap = false;
               _tipTextField.text = String(data);
               rectangle = _backInnerRect.getInnerRect(_tipTextField.width,_tipTextField.height);
               var _loc4_:* = rectangle.width;
               _tipbackgound.width = _loc4_;
               _width = _loc4_;
               _loc4_ = rectangle.height;
               _tipbackgound.height = _loc4_;
               _height = _loc4_;
            }
            else if(data is Array)
            {
               _tipTextField.wordWrap = true;
               _tipTextField.width = int(data[1]);
               _tipTextField.text = String(data[0]);
               rectangle = _backInnerRect.getInnerRect(_tipTextField.width,_tipTextField.height);
               _loc4_ = rectangle.width;
               _tipbackgound.width = _loc4_;
               _width = _loc4_;
               _loc4_ = rectangle.height;
               _tipbackgound.height = _loc4_;
               _height = _loc4_;
            }
            visible = true;
            _tipTextField.x = _backInnerRect.para1;
            _tipTextField.y = _backInnerRect.para3;
            _currentData = data;
         }
         else if(data as GoodTipInfo)
         {
            obj = data as GoodTipInfo;
            _currentData = obj;
            showTip(obj.itemInfo,obj.typeIsSecond);
            visible = true;
         }
         else
         {
            visible = false;
            _currentData = null;
         }
      }
   }
}
