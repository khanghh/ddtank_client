package consortion.view.selfConsortia
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class MemberItem extends Sprite implements Disposeable, IListCell
   {
      
      public static const MAX_OFFLINE_HOURS:int = 720;
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _light:Scale9CornerImage;
      
      private var _name:FilterFrameText;
      
      private var _nameForVip:GradientText;
      
      private var _job:FilterFrameText;
      
      private var _offer:FilterFrameText;
      
      private var _week:FilterFrameText;
      
      private var _fightPower:FilterFrameText;
      
      private var _offLine:FilterFrameText;
      
      private var _levelIcon:LevelIcon;
      
      private var _playerInfo:ConsortiaPlayerInfo;
      
      private var _isSelected:Boolean;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function MemberItem(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onItmeClickHandler(param1:MouseEvent) : void{}
      
      private function __mouseOverHandler(param1:MouseEvent) : void{}
      
      private function __mouseOutHandler(param1:MouseEvent) : void{}
      
      public function isSelelct(param1:Boolean) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function __selfPropertyHanlder(param1:PlayerPropertyEvent) : void{}
      
      private function setVisible(param1:Boolean) : void{}
      
      private function setName() : void{}
      
      private function creatAttestBtn() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
