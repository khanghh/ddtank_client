package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class MarriedIcon extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _gender:Boolean;
      
      public function MarriedIcon()
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.core.MarriedIcon");
         addChild(_icon);
         ShowTipManager.Instance.addTip(this);
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeChild(_icon);
         _icon.bitmapData.dispose();
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
