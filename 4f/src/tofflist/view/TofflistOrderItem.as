package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.selfConsortia.Badge;
   import ddt.data.ConsortiaInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import tofflist.data.TofflistConsortiaData;
   import tofflist.data.TofflistConsortiaInfo;
   import tofflist.data.TofflistPlayerInfo;
   import vip.VipController;
   
   public class TofflistOrderItem extends Sprite implements Disposeable
   {
       
      
      private var _consortiaInfo:TofflistConsortiaInfo;
      
      private var _badge:Badge;
      
      private var _index:int;
      
      private var _info:TofflistPlayerInfo;
      
      private var _teamRankinfo:TeamRankInfo;
      
      private var _isSelect:Boolean;
      
      private var _bg:Image;
      
      private var _shine:Scale9CornerImage;
      
      private var _level:LevelIcon;
      
      private var _vipName:GradientText;
      
      private var _topThreeRink:ScaleFrameImage;
      
      private var _horseNameStrList:Array;
      
      private var _levelStar:Bitmap;
      
      private var _teamSegmentIcon:ScaleFrameImage;
      
      private var _resourceArr:Array;
      
      private var _styleLinkArr:Array;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var hLines:Array;
      
      public function TofflistOrderItem(){super();}
      
      public function get currentText() : String{return null;}
      
      public function dispose() : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      public function get MountsLevel() : String{return null;}
      
      public function showHLine(param1:Vector.<Point>) : void{}
      
      public function get info() : Object{return null;}
      
      public function set info(param1:Object) : void{}
      
      public function set isSelect(param1:Boolean) : void{}
      
      public function set resourceLink(param1:String) : void{}
      
      public function set setAllStyleXY(param1:String) : void{}
      
      public function updateStyleXY(param1:int = 0) : void{}
      
      private function get NO_ID() : String{return null;}
      
      private function __itemClickHandler(param1:MouseEvent) : void{}
      
      private function __itemMouseOutHandler(param1:MouseEvent) : void{}
      
      private function __itemMouseOverHandler(param1:MouseEvent) : void{}
      
      private function addEvent() : void{}
      
      private function __offerChange(param1:PlayerPropertyEvent) : void{}
      
      private function init() : void{}
      
      private function removeEvent() : void{}
      
      private function upView() : void{}
      
      private function creatAttestBtn() : void{}
      
      public function get consortiaInfo() : ConsortiaInfo{return null;}
      
      public function get teamRankinfo() : TeamRankInfo{return null;}
   }
}
