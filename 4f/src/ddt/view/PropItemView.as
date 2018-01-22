package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.data.PropInfo;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.Dictionary;
   
   public class PropItemView extends Sprite implements ITipedDisplay, Disposeable
   {
      
      public static const OVER:String = "over";
      
      public static const OUT:String = "out";
      
      public static var _prop:Dictionary;
       
      
      private var _info:PropInfo;
      
      private var _asset:Bitmap;
      
      private var _isExist:Boolean;
      
      private var _tipStyle:String;
      
      private var _tipData:Object;
      
      private var _tipDirctions:String;
      
      private var _tipGapV:int;
      
      private var _tipGapH:int;
      
      public function PropItemView(param1:PropInfo, param2:Boolean = true, param3:Boolean = true, param4:int = 1){super();}
      
      public static function createView(param1:String, param2:int = 62, param3:int = 62, param4:Boolean = true) : Bitmap{return null;}
      
      public function get info() : PropInfo{return null;}
      
      public function set propPos(param1:int) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      public function get isExist() : Boolean{return false;}
      
      public function dispose() : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function get tipDirctions() : String{return null;}
      
      public function get tipGapV() : int{return 0;}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function set tipData(param1:Object) : void{}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function set tipGapV(param1:int) : void{}
      
      public function set tipGapH(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
