package superWinner.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import flash.display.Sprite;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      public class SuperWinnerPlayerListView extends Sprite implements Disposeable   {                   private var _data:DictionaryData;            private var _playerList:ListPanel;            public function SuperWinnerPlayerListView(data:DictionaryData) { super(); }
            private function initbg() : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __addPlayer(event:DictionaryEvent) : void { }
            private function __removePlayer(event:DictionaryEvent) : void { }
            private function __updatePlayer(event:DictionaryEvent) : void { }
            private function getInsertIndex(info:PlayerInfo) : int { return 0; }
            public function dispose() : void { }
   }}