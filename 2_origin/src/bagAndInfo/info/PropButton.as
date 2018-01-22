package bagAndInfo.info
{
   import bagAndInfo.tips.CharacterPropTxtTipInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PropButton extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      protected var _back:DisplayObject;
      
      protected var _tipGapH:int = 0;
      
      protected var _tipGapV:int = 0;
      
      protected var _tipDirection:String = "7,5,6,4";
      
      protected var _tipStyle:String = "core.PropTxtTips";
      
      protected var _tipData:CharacterPropTxtTipInfo;
      
      public function PropButton()
      {
         _tipData = new CharacterPropTxtTipInfo();
         super();
         mouseChildren = false;
         addChildren();
      }
      
      protected function addChildren() : void
      {
         if(!_back)
         {
            _back = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.background_propbutton");
            addChild(_back);
         }
      }
      
      public function dispose() : void
      {
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get color() : int
      {
         return _tipData.color;
      }
      
      public function set color(param1:int) : void
      {
         _tipData.color = param1;
      }
      
      public function get property() : String
      {
         return _tipData.property;
      }
      
      public function set property(param1:String) : void
      {
         _tipData.property = "[" + param1 + "]";
      }
      
      public function get detail() : String
      {
         return _tipData.detail;
      }
      
      public function set detail(param1:String) : void
      {
         _tipData.detail = param1;
      }
      
      public function get propertySource() : String
      {
         return _tipData.propertySource;
      }
      
      public function set propertySource(param1:String) : void
      {
         _tipData.propertySource = param1;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1 as CharacterPropTxtTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirection;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirection = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
