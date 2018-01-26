package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.Helpers;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import ddt.view.sceneCharacter.GirlHeadPicLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PlayerPortraitView extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var _needLoadGirlHead:Boolean;
      
      private var _mask:Shape;
      
      private var _character:ShowCharacter;
      
      private var _loaderGirlPhoto:GirlHeadPicLoader;
      
      private var _figure:Bitmap;
      
      private var _iconBg:ScaleFrameImage;
      
      private var _directrion:String;
      
      private var _info:PlayerInfo;
      
      public function PlayerPortraitView(param1:String = "left", param2:Boolean = false, param3:Boolean = true){super();}
      
      public function onHeadSelectChange(param1:Boolean) : void{}
      
      public function set info(param1:PlayerInfo) : void{}
      
      public function get info() : PlayerInfo{return null;}
      
      public function set iconFrame(param1:int) : void{}
      
      public function set isShowFrame(param1:Boolean) : void{}
      
      private function showFigure(param1:PlayerInfo) : void{}
      
      private function onGirlLoaderComplete(param1:DisplayObject) : void{}
      
      private function __characterComplete(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
