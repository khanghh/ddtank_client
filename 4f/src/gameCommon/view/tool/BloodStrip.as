package gameCommon.view.tool
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.view.tips.ChangeNumToolTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   
   public class BloodStrip extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _HPStripBg:Bitmap;
      
      private var _HPStrip:Bitmap;
      
      private var _hpShadow:Bitmap;
      
      private var _HPTxt:FilterFrameText;
      
      private var _mask:Shape;
      
      private var _hurtedMask:MovieClip;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _maskH:Number;
      
      private var _info:ChangeNumToolTipInfo;
      
      public function BloodStrip(){super();}
      
      private function initTip() : void{}
      
      public function dispose() : void{}
      
      private function __update(param1:LivingEvent) : void{}
      
      private function update(param1:int, param2:int) : void{}
      
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
