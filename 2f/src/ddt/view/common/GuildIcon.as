package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.PlayerManager;
   import ddt.view.tips.GuildIconTipInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class GuildIcon extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const BIG:String = "big";
      
      public static const SMALL:String = "small";
       
      
      private var _icon:ScaleFrameImage;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _tipData:GuildIconTipInfo;
      
      private var _cid:int;
      
      private var _level:int;
      
      private var _repute:int;
      
      public function GuildIcon(){super();}
      
      public function setInfo(param1:int, param2:int, param3:int) : void{}
      
      public function set showTip(param1:Boolean) : void{}
      
      public function set size(param1:String) : void{}
      
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
      
      public function dispose() : void{}
   }
}
