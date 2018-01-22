package anotherDimension.view
{
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class AnotherDimensionSelfItemView extends Sprite implements Disposeable
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 103;
       
      
      private var _resourceLevel:int = 0;
      
      private var _resourcePlayerInfo:PlayerInfo;
      
      private var _resourceLevelBg:MovieClip;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _daojishiTxt:FilterFrameText;
      
      private var _daojishiBg:Bitmap;
      
      private var _anotherDimensionInfo:AnotherDimensionResourceInfo;
      
      private var _anotherDimensionOthertip:AnotherDimensionOtherTip;
      
      private var _tipSprite:Sprite;
      
      private var _timer:Timer;
      
      private var hourTime:Number = 3600000.0;
      
      private var minuteTime:Number = 60000.0;
      
      public function AnotherDimensionSelfItemView(param1:AnotherDimensionResourceInfo){super();}
      
      public function get resourceLevel() : int{return 0;}
      
      public function set resourceLevel(param1:int) : void{}
      
      private function initView() : void{}
      
      public function loadHead() : void{}
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void{}
      
      private function setDaojishi() : void{}
      
      private function initEvent() : void{}
      
      private function _reflushTip(param1:TimerEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
