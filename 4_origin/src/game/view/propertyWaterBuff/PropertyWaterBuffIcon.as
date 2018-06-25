package game.view.propertyWaterBuff
{
   import bagAndInfo.cell.CellContentCreator;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PropertyWaterBuffIcon extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const defaultW:int = 32;
      
      public static const defaultH:int = 32;
       
      
      private var _buffInfo:BuffInfo;
      
      private var _pic:CellContentCreator;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      public function PropertyWaterBuffIcon(info:BuffInfo)
      {
         super();
         _buffInfo = info;
         init();
      }
      
      private function init() : void
      {
         graphics.beginFill(16777215,0.2);
         graphics.drawRect(x,y,33,33);
         graphics.endFill();
         createPic();
         ShowTipManager.Instance.addTip(this);
      }
      
      private function createPic() : void
      {
         ObjectUtils.disposeObject(_pic);
         _pic = null;
         _pic = new CellContentCreator();
         _pic.info = _buffInfo.buffItemInfo;
         _pic.loadSync(createContentComplete);
         addChild(_pic);
      }
      
      protected function createContentComplete() : void
      {
         _pic.scaleX = 32 / _pic.width;
         _pic.scaleY = 32 / _pic.height;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeObject(_pic);
         _pic = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         return _buffInfo;
      }
      
      public function set tipData(value:Object) : void
      {
         _buffInfo = value as BuffInfo;
         createPic();
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
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
