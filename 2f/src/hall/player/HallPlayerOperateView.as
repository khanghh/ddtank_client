package hall.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.GirlHeadPicLoader;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   
   public class HallPlayerOperateView extends Sprite
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 150;
       
      
      private var _bg:Bitmap;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headSprite:Sprite;
      
      private var _nickName:FilterFrameText;
      
      private var _operateSprite:Sprite;
      
      private var _operate:FilterFrameText;
      
      private var _upDownBtn:ScaleFrameImage;
      
      private var _playerTips:HallPlayerTips;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _playerInfo:PlayerInfo;
      
      private var _girlHeadPhotoLoader:GirlHeadPicLoader;
      
      public function HallPlayerOperateView(){super();}
      
      private function initView() : void{}
      
      public function loadHead() : void{}
      
      private function callGirlHeadPhotoLoaded(param1:DisplayObject) : void{}
      
      private function initEvent() : void{}
      
      protected function __onTipsClick(param1:MouseEvent) : void{}
      
      protected function __onUpdateInfo(param1:NewHallEvent) : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      protected function __onStageClick(param1:MouseEvent) : void{}
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
