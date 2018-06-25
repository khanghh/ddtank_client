package room.view
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class RoomPlayerArea extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      protected var _tipData:Object;
      
      protected var _tipDirection:String;
      
      protected var _tipGapH:int;
      
      protected var _tipGapV:int;
      
      protected var _tipStyle:String;
      
      public function RoomPlayerArea()
      {
         super();
         addTip();
      }
      
      private function addTip() : void
      {
         tipDirctions = "2,7";
         tipGapV = 0;
         tipStyle = "ddtroom.RoomPlayerItemIip";
         ShowTipManager.Instance.addTip(this);
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
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value;
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
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
