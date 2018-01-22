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
      
      public function set backgoundInnerRectString(param1:String) : void
      {
         if(_backgoundInnerRectString == param1)
         {
            return;
         }
         _backgoundInnerRectString = param1;
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
      
      public function set tipTextField(param1:TextField) : void
      {
         if(_tipTextField == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_tipTextField);
         _tipTextField = param1;
         onPropertiesChanged("tipTextField");
      }
      
      public function set tipTextStyle(param1:String) : void
      {
         if(_tipTextStyle == param1)
         {
            return;
         }
         _tipTextStyle = param1;
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
      
      override public function set tipData(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 as String)
         {
            if(param1 is String)
            {
               _tipTextField.wordWrap = false;
               _tipTextField.text = String(param1);
               _loc2_ = _backInnerRect.getInnerRect(_tipTextField.width,_tipTextField.height);
               var _loc4_:* = _loc2_.width;
               _tipbackgound.width = _loc4_;
               _width = _loc4_;
               _loc4_ = _loc2_.height;
               _tipbackgound.height = _loc4_;
               _height = _loc4_;
            }
            else if(param1 is Array)
            {
               _tipTextField.wordWrap = true;
               _tipTextField.width = int(param1[1]);
               _tipTextField.text = String(param1[0]);
               _loc2_ = _backInnerRect.getInnerRect(_tipTextField.width,_tipTextField.height);
               _loc4_ = _loc2_.width;
               _tipbackgound.width = _loc4_;
               _width = _loc4_;
               _loc4_ = _loc2_.height;
               _tipbackgound.height = _loc4_;
               _height = _loc4_;
            }
            visible = true;
            _tipTextField.x = _backInnerRect.para1;
            _tipTextField.y = _backInnerRect.para3;
            _currentData = param1;
         }
         else if(param1 as GoodTipInfo)
         {
            _loc3_ = param1 as GoodTipInfo;
            _currentData = _loc3_;
            showTip(_loc3_.itemInfo,_loc3_.typeIsSecond);
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
