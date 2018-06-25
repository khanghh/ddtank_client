package demonChiYou.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import demonChiYou.DemonChiYouManager;   import demonChiYou.DemonChiYouModel;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.text.TextField;      public class WorldBossHPScript extends Sprite implements Disposeable   {                   private var _bloodStrip:MovieClip;            private var _bloodWidth:int;            private var _hp_text:TextField;            private var _bossName_text:TextField;            private var _scale:Number;            private var _iscuting:Boolean;            private var speed:Number = 1.0;            private var _mgr:DemonChiYouManager;            private var _model:DemonChiYouModel;            public function WorldBossHPScript() { super(); }
            private function init() : void { }
            public function refreshBlood() : void { }
            private function addEvent() : void { }
            private function showBloodText() : void { }
            private function updateBloodStrip(event:Event) : void { }
            private function playCutHpMC(value:Number) : void { }
            private function cutHpred2(e:Event) : void { }
            private function offset(off:int = 30) : int { return 0; }
            public function dispose() : void { }
   }}