package newOpenGuide
{
   import bagAndInfo.BagAndInfoManager;
   import cityWide.CityWideManager;
   import com.greensock.TweenLite;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.view.MainToolBar;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import hall.HallStateView;
   import hall.IHallStateView;
   import starling.scene.hall.HallPlayerView;
   import trainer.view.NewHandContainer;
   
   public class NewOpenGuideManager extends EventDispatcher
   {
      
      private static var _instance:NewOpenGuideManager;
       
      
      public const openLevelList:Array = [3,5,6,7,20,10,11,8,13,15,14,16,17,18,22,29,24,99,23,19,25,12,30,45,50,70,31,26];
      
      public const openMovePosList:Array = [new Point(662,144),new Point(399,169),new Point(0,0),new Point(635,6),new Point(219,96),new Point(445,-10),new Point(0,0),new Point(891,540),new Point(780,543),new Point(780,543),new Point(445,-10),new Point(780,543),new Point(445,-10),new Point(445,-10),new Point(732,543),new Point(891,540),new Point(891,540),new Point(891,540),new Point(891,540),new Point(0,0),new Point(0,0),new Point(0,0),new Point(445,-10),new Point(445,-10),new Point(638,558),new Point(638,558),new Point(740,550),new Point(891,540)];
      
      public const titleStrList:Array = LanguageMgr.GetTranslation("newOpenGuide.openTitleListStr").split(",");
      
      private var _rightView:NewOpenGuideRightView;
      
      private var _hall:IHallStateView;
      
      private var _playerView:HallPlayerView;
      
      private var _dialog:NewOpenGuideDialogView;
      
      private var _coverSpriteInPlayCartoon:Sprite;
      
      public function NewOpenGuideManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : NewOpenGuideManager{return null;}
      
      public function getMovePos() : Point{return null;}
      
      public function getTitleStrIndexByLevel(param1:int) : Array{return null;}
      
      public function closeShow() : void{}
      
      public function checkShow(param1:HallPlayerView, param2:IHallStateView) : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function openAllTool() : void{}
      
      private function judgeMiddleView() : void{}
      
      private function createOpenCartoon() : void{}
      
      private function openCartoonPlayFrame(param1:Event) : void{}
      
      private function checkGuide() : void{}
      
      protected function __onBagOpenClikc(param1:Event) : void{}
      
      protected function onHallAreaClick(param1:CEvent) : void{}
      
      protected function onHallPlayerArrived(param1:CEvent) : void{}
      
      private function createOpenView() : void{}
      
      private function middleViewCompleteHandler(param1:Event) : void{}
      
      private function onTweenDispose() : void{}
      
      protected function onDialogClick(param1:MouseEvent) : void{}
      
      private function disposeDialogView() : void{}
      
      private function getBuildOrNpcName() : String{return null;}
      
      private function isHasOpenCartoon() : Boolean{return false;}
      
      private function getMapMovePos() : Point{return null;}
      
      private function getOpenCartoonClassName() : String{return null;}
   }
}
