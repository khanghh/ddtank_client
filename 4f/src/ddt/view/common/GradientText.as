package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.text.TextFormat;
   
   public class GradientText extends Sprite implements Disposeable
   {
      
      public static var RandomColors:Array = [65508,16711782,16763904,14978897,9895680,14483225,10400767,16742025,50943,13390591];
      
      public static var randomFont:Array = ["AdLib BT","Arial Black","VAG Rounded Std Thin","Britannic Bold","Berlin Sans FB Demi","Benguiat Bk BT","Kabel Ult BT","Tw Cen MT Condensed Extra Bold","Cooper Std Black","Copperplate Gothic Bold","CastleTUlt","FrnkGothITC Hv BT"];
      
      public static var randomFontSize:Array = [0,2];
       
      
      private var _field:FilterFrameText;
      
      private var _textFormat:TextFormat;
      
      private var graidenBox:Sprite;
      
      private var currentMatix:Matrix;
      
      private var currentColors:Array;
      
      private var randomColor:Array;
      
      public function GradientText(param1:FilterFrameText, param2:Array = null){super();}
      
      public function setText(param1:String, param2:Boolean = true, param3:Boolean = false) : void{}
      
      public function get text() : String{return null;}
      
      public function set autoSize(param1:String) : void{}
      
      private function render(param1:Boolean, param2:Boolean) : void{}
      
      private function drawBox() : void{}
      
      private function drawBoxWithCurrent() : void{}
      
      private function getRandomColors() : Array{return null;}
      
      private function getRandomFont() : String{return null;}
      
      private function getRandomFontSize() : int{return 0;}
      
      private function setTextStyle(param1:String) : void{}
      
      public function dispose() : void{}
   }
}
