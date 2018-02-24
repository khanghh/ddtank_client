package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PropLayerButton extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _background:ScaleFrameImage;
      
      private var _shine:Bitmap;
      
      private var _tipData:String;
      
      private var _mode:int;
      
      private var _mouseOver:Boolean = false;
      
      private var _tipDirction:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      public function PropLayerButton(param1:int){super();}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      public function set enabled(param1:Boolean) : void{}
      
      public function get enabled() : Boolean{return false;}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function configUI() : void{}
      
      public function setMode(param1:int) : void{}
      
      public function dispose() : void{}
      
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
