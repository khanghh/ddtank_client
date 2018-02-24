package ddt.view.academyCommon.academyIcon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class AcademyIconTip extends Sprite implements Disposeable, ITip
   {
      
      public static const MAX_HEIGHT:int = 70;
      
      public static const MIN_HEIGHT:int = 22;
       
      
      private var _tipData:PlayerInfo;
      
      private var _contentLabel:TextFormat;
      
      private var _bg:ScaleBitmapImage;
      
      private var _textFrameArray:Vector.<FilterFrameText>;
      
      public function AcademyIconTip(){super();}
      
      private function init() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      private function update() : void{}
      
      private function updateBgSize() : void{}
      
      private function getApprenticesNum() : String{return null;}
      
      private function getMaxWidth() : int{return 0;}
      
      public function dispose() : void{}
   }
}
