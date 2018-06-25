package dayActivity.items{   import catchbeast.CatchBeastManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortionBattle.ConsortiaBattleManager;   import dayActivity.DayActiveData;   import dayActivity.DayActivityControl;   import ddt.data.player.PlayerInfo;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import entertainmentMode.EntertainmentModeManager;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import horseRace.controller.HorseRaceManager;   import lanternriddles.LanternRiddlesManager;   import rescue.RescueManager;   import sevenDouble.SevenDoubleManager;   import trainer.controller.WeakGuildManager;   import worldBossHelper.WorldBossHelperController;      public class DayActivieListItem extends Sprite implements Disposeable   {                   private var _bg:MovieClip;            private var _txt1:FilterFrameText;            private var _txt2:FilterFrameText;            private var _txt3:FilterFrameText;            private var _txt4:FilterFrameText;            private var _txt5:FilterFrameText;            private var _worldBossHelperBtn:SimpleBitmapButton;            private var _data:DayActiveData;            private var _index:int;            public var id:int;            private var clickSp:Sprite;            private var _lastCreatTime:int = 0;            public var seleLigthFun:Function;            private var _selectLight:Bitmap;            public var activityTypeID:int;            private var _levelLimit:int;            public function DayActivieListItem(number:int) { super(); }
            protected function mouseClickHander(event:MouseEvent) : void { }
            public function get data() : DayActiveData { return null; }
            public function setData(data:DayActiveData) : void { }
            public function initTxt(bool:Boolean) : void { }
            private function __worldBossHelperHandler(e:MouseEvent) : void { }
            public function upDataOpenState(bool:Boolean) : void { }
            public function updataCount(num:int) : void { }
            public function getTxt5str() : String { return null; }
            private function clickHander(event:MouseEvent) : void { }
            private function sevenDoubleCanEnterHandler(event:Event) : void { }
            public function setBg(number:int) : void { }
            private function init(number:int) : void { }
            public function setLigthVisible(value:Boolean) : void { }
            public function dispose() : void { }
            override public function get height() : Number { return 0; }
   }}