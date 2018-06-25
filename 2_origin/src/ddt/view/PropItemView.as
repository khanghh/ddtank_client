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
      
      public function PropItemView(info:PropInfo, $isExist:Boolean = true, $showPrice:Boolean = true, $count:int = 1)
      {
         super();
         mouseEnabled = true;
         _info = info;
         _isExist = $isExist;
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
         var tipInfo:ToolPropInfo = new ToolPropInfo();
         tipInfo.info = info.Template;
         tipInfo.count = $count;
         tipInfo.showTurn = $showPrice;
         tipInfo.showThew = true;
         tipInfo.showCount = true;
         tipData = tipInfo;
         ShowTipManager.Instance.addTip(this);
         addEventListener("mouseOver",__over);
         addEventListener("mouseOut",__out);
      }
      
      public static function createView(id:String, width:int = 62, height:int = 62, smoothing:Boolean = true) : Bitmap
      {
         var className:* = null;
         var t:* = null;
         var wishBtn:* = null;
         if(id != "wish")
         {
            className = "game.crazyTank.view.Prop" + id.toString() + "Asset";
            t = ComponentFactory.Instance.creatBitmap(className);
            t.smoothing = smoothing;
            t.width = width;
            t.height = height;
            return t;
         }
         wishBtn = ComponentFactory.Instance.creatBitmap("asset.game.wishBtn");
         wishBtn.smoothing = smoothing;
         wishBtn.width = width;
         wishBtn.height = height;
         return wishBtn;
      }
      
      public function get info() : PropInfo
      {
         return _info;
      }
      
      public function set propPos(val:int) : void
      {
         _asset.x = val;
         _asset.y = val;
      }
      
      private function __out(event:MouseEvent) : void
      {
         dispatchEvent(new Event("out"));
      }
      
      private function __over(event:MouseEvent) : void
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
      
      public function set tipStyle(value:String) : void
      {
         if(_tipStyle == value)
         {
            return;
         }
         _tipStyle = value;
      }
      
      public function set tipData(value:Object) : void
      {
         if(_tipData == value)
         {
            return;
         }
         _tipData = value;
      }
      
      public function set tipDirctions(value:String) : void
      {
         if(_tipDirctions == value)
         {
            return;
         }
         _tipDirctions = value;
      }
      
      public function set tipGapV(value:int) : void
      {
         if(_tipGapV == value)
         {
            return;
         }
         _tipGapV = value;
      }
      
      public function set tipGapH(value:int) : void
      {
         if(_tipGapH == value)
         {
            return;
         }
         _tipGapH = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
