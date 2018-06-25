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
      
      public function set color(val:int) : void
      {
         _tipData.color = val;
      }
      
      public function get property() : String
      {
         return _tipData.property;
      }
      
      public function set property(val:String) : void
      {
         _tipData.property = "[" + val + "]";
      }
      
      public function get detail() : String
      {
         return _tipData.detail;
      }
      
      public function set detail(val:String) : void
      {
         _tipData.detail = val;
      }
      
      public function get propertySource() : String
      {
         return _tipData.propertySource;
      }
      
      public function set propertySource(val:String) : void
      {
         _tipData.propertySource = val;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value as CharacterPropTxtTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirection;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirection = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
