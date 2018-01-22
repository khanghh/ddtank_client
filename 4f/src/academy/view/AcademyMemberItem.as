package academy.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class AcademyMemberItem extends Sprite implements Disposeable
   {
       
      
      private var _itembg:ScaleFrameImage;
      
      private var _line1:ScaleBitmapImage;
      
      private var _line2:ScaleBitmapImage;
      
      private var _line3:ScaleBitmapImage;
      
      private var _itemEffect:ScaleFrameImage;
      
      private var _OnlineIcon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _levelIcon:LevelIcon;
      
      private var _info:AcademyPlayerInfo;
      
      private var _selected:Boolean;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _index:int;
      
      public function AcademyMemberItem(param1:int){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __onMouseClick(param1:MouseEvent) : void{}
      
      private function __onMouseOver(param1:MouseEvent) : void{}
      
      public function set isSelect(param1:Boolean) : void{}
      
      public function get isSelect() : Boolean{return false;}
      
      private function updateComponentPos() : void{}
      
      private function updateInfo() : void{}
      
      private function creatAttestBtn() : void{}
      
      public function set info(param1:AcademyPlayerInfo) : void{}
      
      public function get info() : AcademyPlayerInfo{return null;}
      
      public function dispose() : void{}
   }
}
