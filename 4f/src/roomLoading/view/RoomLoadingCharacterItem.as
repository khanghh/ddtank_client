package roomLoading.view{   import com.greensock.TweenMax;   import com.greensock.easing.Quint;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import consortion.view.selfConsortia.Badge;   import ddt.data.goods.ItemTemplateInfo;   import ddt.display.BitmapLoaderProxy;   import ddt.manager.ItemManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.utils.PositionUtils;   import ddt.view.academyCommon.academyIcon.AcademyIcon;   import ddt.view.common.DailyLeagueLevel;   import ddt.view.common.LevelIcon;   import ddt.view.common.MarriedIcon;   import ddt.view.common.VipLevelIcon;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import room.events.RoomPlayerEvent;   import room.model.RoomPlayer;   import vip.VipController;      public class RoomLoadingCharacterItem extends Sprite implements Disposeable   {            public static const LOADING_FINISHED:String = "loadingFinished";                   private var _survivalFlag:Boolean;            protected var _info:RoomPlayer;            protected var _nameTxt:FilterFrameText;            protected var _vipName:GradientText;            public var _perecentageTxt:FilterFrameText;            protected var _okTxt:Bitmap;            protected var _levelIcon:LevelIcon;            protected var _legaueLevel:DailyLeagueLevel;            protected var _vipIcon:VipLevelIcon;            protected var _marriedIcon:MarriedIcon;            protected var _academyIcon:AcademyIcon;            protected var _badge:Badge;            protected var _iconContainer:VBox;            protected var _iconPos:Point;            protected var _loadingArr:Array;            protected var _weapon:DisplayObject;            protected var _displayMc:MovieClip;            protected var _index:int = 1;            protected var _animationFinish:Boolean = false;            private var _attestBtn:ScaleFrameImage;            private var _teamIcon:ScaleFrameImage;            public function RoomLoadingCharacterItem($info:RoomPlayer, survival:Boolean = false) { super(); }
            protected function init() : void { }
            private function creatTeamIcon() : void { }
            private function addSurvivalIcon() : void { }
            private function creatAttestBtn() : void { }
            protected function __onAppeared(event:Event) : void { }
            public function get isAnimationFinished() : Boolean { return false; }
            public function get index() : int { return 0; }
            public function set index(val:int) : void { }
            public function get displayMc() : DisplayObject { return null; }
            public function appear(no:String) : void { }
            public function disappear(no:String) : void { }
            public function addWeapon(small:Boolean, dir:int) : void { }
            private function setWeaponPos(small:Boolean) : void { }
            protected function __onProgress(event:RoomPlayerEvent) : void { }
            protected function finishTxt() : void { }
            protected function removeTxt() : void { }
            protected function initIcons() : void { }
            public function get info() : RoomPlayer { return null; }
            public function dispose() : void { }
            public function removePerecentageTxt() : void { }
   }}