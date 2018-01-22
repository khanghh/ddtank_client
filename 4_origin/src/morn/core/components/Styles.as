package morn.core.components
{
   import flash.filters.ColorMatrixFilter;
   
   public class Styles
   {
      
      public static var defaultSizeGrid:Array = [4,4,4,4,0];
      
      public static var fontName:String = "Arial";
      
      public static var fontSize:int = 12;
      
      public static var embedFonts:Boolean = false;
      
      public static var labelColor:uint = 0;
      
      public static var labelStroke:Array = [1509122,1,2,2,10,1];
      
      public static var labelMargin:Array = [0,0,0,0];
      
      public static var buttonStateNum:int = 3;
      
      public static var buttonLabelColors:Array = [3298667,3298667,3298667,12632256];
      
      public static var buttonLabelMargin:Array = [0,0,0,0];
      
      public static var singleButtonFilter:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,25,0,1,0,0,25,0,0,1,0,25,0,0,0,1,0]);
      
      public static var linkLabelColors:Array = [32960,16744448,8388608,12632256];
      
      public static var comboBoxItemColors:Array = [6198710,16777215,0,9413809,16777215];
      
      public static var comboBoxItemHeight:int = 22;
      
      public static var scrollBarMinNum:int = 15;
      
      public static var scrollBarDelayTime:int = 500;
      
      public static var tipTextColor:uint = 0;
      
      public static var tipBorderColor:uint = 12632256;
      
      public static var tipBgColor:uint = 16777215;
      
      public static var smoothing:Boolean = false;
      
      public static var clickInterval:int = 500;
       
      
      public function Styles()
      {
         super();
      }
   }
}
