package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.CSMBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class CSMBoxView extends Sprite implements Disposeable
   {
       
      
      private var _closeSprite:Component;
      
      private var _closeBox:MovieImage;
      
      private var _timeBG:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _openBox:MovieImage;
      
      private var _downBox:MovieImage;
      
      private var _showType:int = -1;
      
      public function CSMBoxView(){super();}
      
      private function init() : void{}
      
      public function showBox(param1:int = 0) : void{}
      
      public function updateTime(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function _boxClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
