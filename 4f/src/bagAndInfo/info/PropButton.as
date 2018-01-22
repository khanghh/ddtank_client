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
      
      public function PropButton(){super();}
      
      protected function addChildren() : void{}
      
      public function dispose() : void{}
      
      public function get color() : int{return 0;}
      
      public function set color(param1:int) : void{}
      
      public function get property() : String{return null;}
      
      public function set property(param1:String) : void{}
      
      public function get detail() : String{return null;}
      
      public function set detail(param1:String) : void{}
      
      public function get propertySource() : String{return null;}
      
      public function set propertySource(param1:String) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
