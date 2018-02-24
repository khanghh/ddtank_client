package consortion.view.selfConsortia
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.BadgeInfo;
   import ddt.manager.BadgeInfoManager;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Badge extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const LARGE:String = "large";
      
      public static const NORMAL:String = "normal";
      
      public static const SMALL:String = "small";
      
      private static const LARGE_SIZE:int = 78;
      
      private static const NORMAL_SIZE:int = 48;
      
      private static const SMALL_SIZE:int = 28;
       
      
      private var _size:String = "large";
      
      private var _badgeID:int = -1;
      
      private var _buyDate:Date;
      
      private var _badge:Bitmap;
      
      private var _loader:BitmapLoader;
      
      private var _clickEnale:Boolean = false;
      
      private var _tipInfo:Object;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String = "consortion.view.selfConsortia.BadgeTip";
      
      private var _showTip:Boolean;
      
      public function Badge(param1:String = "small"){super();}
      
      public function get showTip() : Boolean{return false;}
      
      public function set showTip(param1:Boolean) : void{}
      
      public function get clickEnale() : Boolean{return false;}
      
      public function set clickEnale(param1:Boolean) : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      public function get buyDate() : Date{return null;}
      
      public function set buyDate(param1:Date) : void{}
      
      public function get badgeID() : int{return 0;}
      
      public function set badgeID(param1:int) : void{}
      
      private function getTipInfo() : void{}
      
      private function updateView() : void{}
      
      private function removeBadge() : void{}
      
      private function onComplete(param1:LoaderEvent) : void{}
      
      private function onError(param1:LoaderEvent) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
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
      
      public function dispose() : void{}
   }
}
