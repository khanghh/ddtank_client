package newChickenBox.view{   import baglocked.BaglockedManager;   import com.greensock.TweenLite;   import com.greensock.easing.Sine;   import com.gskinner.geom.ColorMatrix;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.filters.ColorMatrixFilter;   import flash.filters.GlowFilter;   import flash.text.TextField;   import flash.ui.Mouse;   import flash.utils.Timer;   import newChickenBox.NewChickenBoxControl;   import newChickenBox.events.NewChickenBoxEvents;   import newChickenBox.model.NewChickenBoxModel;      public class NewChickenBoxFrame extends Frame implements Disposeable   {                   private var _model:NewChickenBoxModel;            private var tipSprite:Sprite;            private var _newBoxBG:Image;            public var countNum:ScaleFrameImage;            private var openCardTimes:Image;            public var eyeBtn:BaseButton;            private var _eyeBtnSprite:Sprite;            public var openCardBtn:BaseButton;            private var _openCardBtnSprite:Sprite;            public var startBnt:BaseButton;            public var flushBnt:TextButton;            public var msgText:FilterFrameText;            public var newBoxView:NewChickenBoxView;            private var _timer:Timer;            private var _help_btn:BaseButton;            private var egg:MovieClip;            private var eyepic:MovieClip;            private var _refreshTimerTxt:FilterFrameText;            private var _helpFrame:BaseAlerFrame;            private var _freeOpenCountTxt:FilterFrameText;            private var _freeEyeCountTxt:FilterFrameText;            private var _freeRefreshCountTxt:FilterFrameText;            private var _openCardBtnColorMatrixFilter:ColorMatrixFilter;            private var _openCardBtnGlowFilter:GlowFilter;            private var _eyeBtnColorMatrixFilter:ColorMatrixFilter;            private var _eyeBtnGlowFilter:GlowFilter;            private var _timePlayTxt:FilterFrameText;            private var _timePlayTimer:Timer;            private var _isEnd:Boolean;            public function NewChickenBoxFrame() { super(); }
            private function initView() : void { }
            private function startTimePlayTimer() : void { }
            private function refreshTimePlayTxt() : void { }
            private function countChangeHandler(event:TimerEvent) : void { }
            private function disposeTimePlayTimer() : void { }
            public function setEyeLight(isLigth:Boolean) : void { }
            public function setOpenCardLight(isLigth:Boolean) : void { }
            public function refreshEagleEyeBtnTxt() : void { }
            public function refreshOpenCardBtnTxt() : void { }
            private function useEyePic(e:Event) : void { }
            public function firestGetTime() : Boolean { return false; }
            private function removeEvent() : void { }
            private function mouseoff(e:Event) : void { }
            private function initEvent() : void { }
            private function clickOpenCard(e:MouseEvent) : void { }
            public function firstEnterHelp() : void { }
            private function playMovie(e:NewChickenBoxEvents) : void { }
            private function clickStart(e:MouseEvent) : void { }
            private function flushItem(e:MouseEvent) : void { }
            private function openAlertFrame() : void { }
            private function noAlertEable(e:MouseEvent) : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function clickEye(e:MouseEvent) : void { }
            private function __start() : void { }
            private function showOutItem(e:Event) : void { }
            private function _timerComplete(e:TimerEvent) : void { }
            private function __confirmResponse(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}