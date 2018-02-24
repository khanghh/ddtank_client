package tofflist.view
{
   import battleGroud.BattleGroudControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.club.ClubInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import horse.HorseManager;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   import tofflist.data.RankInfo;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistLeftInfoView extends Sprite implements Disposeable
   {
       
      
      private var _levelIcon:LevelIcon;
      
      private var _RankingLiftImg:ScaleFrameImage;
      
      private var _rankTitle:FilterFrameText;
      
      private var _levelTitle:FilterFrameText;
      
      private var _valueTitle:FilterFrameText;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _textArr:Array;
      
      private var _updateTimeTxt:FilterFrameText;
      
      private var _tempArr:Vector.<RankInfo>;
      
      private var _levelStar:Bitmap;
      
      private var _mountsLevel:FilterFrameText;
      
      private var _bg:MovieClip;
      
      public function TofflistLeftInfoView(){super();}
      
      public function dispose() : void{}
      
      public function get updateTimeTxt() : FilterFrameText{return null;}
      
      private function __tofflistTypeHandler(param1:TofflistEvent) : void{}
      
      private function getToffistPlayerInfo(param1:int) : TofflistPlayerInfo{return null;}
      
      private function addEvent() : void{}
      
      private function __rankInfoHandler(param1:TofflistEvent) : void{}
      
      private function consortiaEmpty() : void{}
      
      private function onComPare(param1:Number, param2:Number) : void{}
      
      private function init() : void{}
      
      private function removeEvent() : void{}
   }
}
