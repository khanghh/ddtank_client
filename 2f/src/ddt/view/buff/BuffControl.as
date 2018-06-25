package ddt.view.buff{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BuffInfo;   import ddt.data.GourdExpBottleInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.view.buff.buffButton.BuffButton;   import ddt.view.buff.buffButton.GourdExpBottleButton;   import ddt.view.buff.buffButton.GrowHelpBuffButton;   import ddt.view.buff.buffButton.LabyrinthBuffButton;   import ddt.view.buff.buffButton.PayBuffButton;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import oldplayergetticket.GetTicketManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import trainer.view.NewHandContainer;      public class BuffControl extends Sprite implements Disposeable   {                   private var _buffData:DictionaryData;            private var _buffList:HBox;            private var _buffBtnArr:Array;            private var _str:String;            private var _spacing:int;            private var _growHelpBuff:GrowHelpBuffButton;            private var _payBuff:PayBuffButton;            private var _labyrinthBuff:LabyrinthBuffButton;            private var _expBlessedIcon:ScaleFrameImage;            private var _getTicketBtn:BaseButton;            private var _attestBtn:ScaleFrameImage;            private var _gourdExpBottle:GourdExpBottleButton;            public function BuffControl(str:String = "", spacing:int = 0) { super(); }
            public static function isPayBuff(buffInfo:BuffInfo) : Boolean { return false; }
            private function init() : void { }
            public function set boxSpacing(value:int) : void { }
            private function initEvents() : void { }
            protected function addGourdExpBottleBuffEvent(event:PlayerPropertyEvent) : void { }
            private function removeEvents() : void { }
            private function initBuffButtons() : void { }
            private function addGourdExpBottleBuff() : void { }
            private function __addGourdExpBottleButton(event:PkgEvent) : void { }
            private function addAttestBuff() : void { }
            protected function __onAttestBtnClick(event:MouseEvent) : void { }
            private function addRegressTicketBuff() : void { }
            private function __addGetTicketBtn(event:PkgEvent) : void { }
            private function addOldPlayerGetTicketBtn() : void { }
            protected function __onGetTicketClick(event:MouseEvent) : void { }
            private function addExpBuff() : void { }
            protected function __addExpBlessedBtn(event:PkgEvent) : void { }
            private function addGrowHelpIcon() : void { }
            private function addpayBuffIcon() : void { }
            private function addLabyrinthBuff() : void { }
            public function setInfo(buffData:DictionaryData) : void { }
            private function __addBuff(evt:DictionaryEvent) : void { }
            private function setBuffButtonInfo(btnId:int, buffinfo:BuffInfo) : void { }
            private function __removeBuff(evt:DictionaryEvent) : void { }
            private function __updateBuff(evt:DictionaryEvent) : void { }
            public function set CanClick(value:Boolean) : void { }
            private function deleteGetTicketBtn() : void { }
            private function deleteExpBlessedBtn() : void { }
            private function deleteGourdExpBottleBtn() : void { }
            public function dispose() : void { }
            public function get buffBtnArr() : Array { return null; }
   }}