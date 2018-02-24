package hall.hallInfo.playerInfo
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.energyData.EnergyData;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import magicStone.MagicStoneManager;
   import vip.VipController;
   
   public class PlayerHead extends Sprite
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 103;
       
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _selfInfo:SelfInfo;
      
      private var _energyProgress:EnergyProgress;
      
      private var _energyAddBtn:SimpleBitmapButton;
      
      private var _energyData:EnergyData;
      
      private var _nickNameText:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _headBtn:BaseButton;
      
      private var _headMask:DisplayObject;
      
      public function PlayerHead(){super();}
      
      private function initEvent() : void{}
      
      protected function onHeadSelectChange(param1:CEvent) : void{}
      
      protected function __onUpdateGrade(param1:PlayerPropertyEvent) : void{}
      
      public function loadGirlHeadPhoto() : void{}
      
      public function loadHead() : void{}
      
      private function initView() : void{}
      
      protected function __addEnergyHandler(param1:MouseEvent) : void{}
      
      protected function __alertBuyEnergy(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      private function checkMoney(param1:Boolean) : Boolean{return false;}
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void{}
      
      protected function __onHeadClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
