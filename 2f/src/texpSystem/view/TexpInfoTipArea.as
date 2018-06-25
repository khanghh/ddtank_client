package texpSystem.view{   import bagAndInfo.tips.CharacterPropTxtTipInfo;   import bagAndInfo.tips.CharacterSecondProTxtTip;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import road7th.data.DictionaryData;      public class TexpInfoTipArea extends Sprite implements Disposeable   {                   private var _tip:CharacterSecondProTxtTip;            private var _info:PlayerInfo;            public function TexpInfoTipArea() { super(); }
            private function init() : void { }
            public function set info(value:PlayerInfo) : void { }
            private function __over(evt:MouseEvent) : void { }
            private function __out(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}