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
      
      public function PropertyWaterBuffIcon(param1:BuffInfo){super();}
      
      private function init() : void{}
      
      private function createPic() : void{}
      
      protected function createContentComplete() : void{}
      
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
