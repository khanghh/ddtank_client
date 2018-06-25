package worldboss.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import worldboss.WorldBossManager;   import worldboss.player.RankingPersonInfo;      public class WorldBossRoomTotalInfoView extends Sprite implements Disposeable   {                   private var _totalInfoBg:ScaleBitmapImage;            private var _totalInfo_time:FilterFrameText;            private var _totalInfo_yourSelf:FilterFrameText;            private var _totalInfo_timeTxt:FilterFrameText;            private var _totalInfo_yourSelfTxt:FilterFrameText;            private var _selfHonor:FilterFrameText;            private var _selfHonorText:FilterFrameText;            private var _txtArr:Array;            private var _show_totalInfoBtnIMG:ScaleFrameImage;            private var _open_show:Boolean = true;            private var _show_totalInfoBtn:SimpleBitmapButton;            public function WorldBossRoomTotalInfoView() { super(); }
            private function initView() : void { }
            private function creatTxtInfo() : void { }
            private function addEvent() : void { }
            protected function __onUpdata(event:Event) : void { }
            private function removeEvent() : void { }
            private function __showTotalInfo(evt:MouseEvent) : void { }
            private function __totalViewShowOrHide(evt:Event) : void { }
            public function updata_yourSelf_damage() : void { }
            public function setTimeCount(num:int) : void { }
            public function updataRanking(arr:Array) : void { }
            private function testshowRanking() : void { }
            public function restTimeInfo() : void { }
            private function setFormat(value:int) : String { return null; }
            public function dispose() : void { }
   }}