package gameCommon.view.control{   import catchInsect.InsectProBar;   import catchInsect.event.InsectEvent;   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.LivingEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObjectContainer;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.setTimeout;   import game.GameDecorateManager;   import game.GameManager;   import gameCommon.GameControl;   import gameCommon.model.GameInfo;   import gameCommon.model.LocalPlayer;   import gameCommon.view.EnergyView;   import gameCommon.view.arrow.ArrowView;   import gameCommon.view.prop.CustomPropBar;   import gameCommon.view.prop.HorseGameSkillBar;   import gameCommon.view.prop.PetSkillBar;   import gameCommon.view.prop.RightPropBar;   import gameCommon.view.prop.WeaponPropBar;   import gameCommon.view.tool.ToolStripView;   import rescue.views.RescuePropBar;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;   import trainer.controller.NewHandGuideManager;   import trainer.controller.WeakGuildManager;   import trainer.view.NewHandContainer;      public class LiveState extends ControlState   {                   protected var _arrow:ArrowView;            protected var _energy:EnergyView;            protected var _customPropBar:CustomPropBar;            protected var _tool:ToolStripView;            protected var _rightPropBar:RightPropBar;            protected var _weaponPropBar:WeaponPropBar;            protected var _rescuePropBar:RescuePropBar;            protected var _insectProBar:InsectProBar;            protected var _horseSkillBar:HorseGameSkillBar;            protected var _petSkill:PetSkillBar;            protected var _petSkillIsShowBtn:BaseButton;            protected var _petSkillBtnCurrentFrame:int;            protected var _petSkillIsShowBtnTopY:Number;            private var _gameInfo:GameInfo;            public function LiveState(self:LocalPlayer) { super(null); }
            override protected function configUI() : void { }
            public function updateSkillLockStatus(type:int, status:Boolean) : void { }
            protected function __useInsectProp(event:InsectEvent) : void { }
            private function __onPetSillIsShowBtnOver(e:MouseEvent) : void { }
            private function __onPetSillIsShowBtnOut(e:MouseEvent) : void { }
            private function __onPetSillIsShowBtnMousedown(e:MouseEvent) : void { }
            private function __onPetSillIsShowBtnClick(e:MouseEvent) : void { }
            private function setPropBarVisible() : void { }
            override protected function addEvent() : void { }
            protected function __transparentChanged(event:Event) : void { }
            override protected function removeEvent() : void { }
            override public function enter(container:DisplayObjectContainer) : void { }
            override public function leaving(onComplete:Function = null) : void { }
            override protected function tweenIn() : void { }
            protected function loadWeakGuild() : void { }
            private function __onDander(event:LivingEvent) : void { }
            private function __showTenPersentArrow(evt:LivingEvent) : void { }
            private function __showThreeArrow(evt:LivingEvent) : void { }
            private function propOpenShow(mcStr:String) : void { }
            protected function setWeaponPropVisible(val:Boolean) : void { }
            protected function setRightPropVisible(v:Boolean, ... args) : void { }
            protected function setSelfPropBarVisible(v:Boolean) : void { }
            protected function setArrowVisible(v:Boolean) : void { }
            public function setEnergyVisible(v:Boolean) : void { }
            override public function dispose() : void { }
            public function get rescuePropBar() : RescuePropBar { return null; }
            public function get insectProBar() : InsectProBar { return null; }
            public function get rightPropBar() : RightPropBar { return null; }
            public function get arrow() : ArrowView { return null; }
   }}