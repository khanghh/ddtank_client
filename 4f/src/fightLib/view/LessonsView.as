package fightLib.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.CheckWeaponManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import fightLib.FightLibControl;   import fightLib.FightLibManager;   import fightLib.script.FightLibGuideScripit;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class LessonsView extends Sprite implements Disposeable   {                   private var _background:Bitmap;            private var _defaultImg:Bitmap;            private var _difficultyImg:Bitmap;            private var _background2:MutipleImage;            private var _background3:MutipleImage;            private var _background4:MovieClip;            private var _measureButton:LessonButton;            private var _twentyButton:LessonButton;            private var _sixtyFiveButton:LessonButton;            private var _highThrowButton:LessonButton;            private var _highGapButton:LessonButton;            private var _lassButton:LessonButton;            private var _levelGroup:SelectedButtonGroup;            private var _lowButton:LevelButton;            private var _mediumButton:LevelButton;            private var _highButton:LevelButton;            private var _startButton:MovieClip;            private var _cancelButton:SimpleBitmapButton;            private var _lessonType:int;            private var _selectedLesson:LessonButton;            private var _selectedLevel:LevelButton;            private var _lessonButtons:Vector.<LessonButton>;            private var _levelButtons:Vector.<LevelButton>;            private var _sencondType:int = 3;            private var _guildMovie:MovieClip;            private var _awardView:FightLibAwardView;            public function LessonsView() { super(); }
            private function configUI() : void { }
            private function updateLast() : void { }
            private function updateSencondType() : void { }
            private function updateLessonButtonState() : void { }
            private function updateLevelButtonState() : void { }
            private function updateAward() : void { }
            private function updateAwardGainedState() : void { }
            private function addEvent() : void { }
            private function __gainAward(evt:Event) : void { }
            private function __update(evt:PlayerPropertyEvent) : void { }
            private function removeEvent() : void { }
            private function __levelClick(evt:MouseEvent) : void { }
            private function updateModelII() : void { }
            private function __selectLesson(evt:Event) : void { }
            private function unSelectedAllLesson() : void { }
            private function unselectedAllLevel() : void { }
            private function updateModel() : void { }
            private function __start(evt:MouseEvent) : void { }
            private function __cancel(evt:MouseEvent) : void { }
            public function hideShine() : void { }
            public function showShine(type:int) : void { }
            public function getGuild() : MovieClip { return null; }
            public function dispose() : void { }
            public function set selectedLesson(val:LessonButton) : void { }
            public function get selectedLesson() : LessonButton { return null; }
            public function set selectedLevel(val:LevelButton) : void { }
            public function get selectedLevel() : LevelButton { return null; }
   }}