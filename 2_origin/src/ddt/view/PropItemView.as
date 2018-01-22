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
      
      public function PropItemView(param1:PropInfo, param2:Boolean = true, param3:Boolean = true, param4:int = 1)
      {
         super();
         mouseEnabled = true;
         _info = param1;
         _isExist = param2;
         _asset = PropItemView.createView(_info.Template.Pic,38,38);
         _asset.x = 1;
         _asset.y = 1;
         if(!_isExist)
         {
            filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
         addChild(_asset);
         tipStyle = "core.ToolPropTips";
         tipDirctions = "2,7,5,1,6,4";
         tipGapH = 20;
         tipGapV = 20;
         var _loc5_:ToolPropInfo = new ToolPropInfo();
         _loc5_.info = param1.Template;
         _loc5_.count = param4;
         _loc5_.showTurn = param3;
         _loc5_.showThew = true;
         _loc5_.showCount = true;
         tipData = _loc5_;
         ShowTipManager.Instance.addTip(this);
         addEventListener("mouseOver",__over);
         addEventListener("mouseOut",__out);
      }
      
      public static function createView(param1:String, param2:int = 62, param3:int = 62, param4:Boolean = true) : Bitmap
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         if(param1 != "wish")
         {
            _loc7_ = "game.crazyTank.view.Prop" + param1.toString() + "Asset";
            _loc6_ = ComponentFactory.Instance.creatBitmap(_loc7_);
            _loc6_.smoothing = param4;
            _loc6_.width = param2;
            _loc6_.height = param3;
            return _loc6_;
         }
         _loc5_ = ComponentFactory.Instance.creatBitmap("asset.game.wishBtn");
         _loc5_.smoothing = param4;
         _loc5_.width = param2;
         _loc5_.height = param3;
         return _loc5_;
      }
      
      public function get info() : PropInfo
      {
         return _info;
      }
      
      public function set propPos(param1:int) : void
      {
         _asset.x = param1;
         _asset.y = param1;
      }
      
      private function __out(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("out"));
      }
      
      private function __over(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("over"));
      }
      
      public function get isExist() : Boolean
      {
         return _isExist;
      }
      
      public function dispose() : void
      {
         if(_asset && _asset.parent)
         {
            _asset.parent.removeChild(_asset);
         }
         _asset.bitmapData.dispose();
         _asset = null;
         _info = null;
         ShowTipManager.Instance.removeTip(this);
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
         if(_tipStyle == param1)
         {
            return;
         }
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(_tipData == param1)
         {
            return;
         }
         _tipData = param1;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         if(_tipDirctions == param1)
         {
            return;
         }
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         if(_tipGapV == param1)
         {
            return;
         }
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         if(_tipGapH == param1)
         {
            return;
         }
         _tipGapH = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
