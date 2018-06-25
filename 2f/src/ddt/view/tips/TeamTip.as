package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;      public class TeamTip extends BaseTip implements ITip   {                   private var _bg:ScaleBitmapImage;            private var _teamLevel:ScaleFrameImage;            private var _teamName:Bitmap;            private var _teamWinRate:Bitmap;            private var _integraPic:Bitmap;            private var _nameField:FilterFrameText;            private var _winRateField:FilterFrameText;            private var _integralField:FilterFrameText;            private var _noTeamField:FilterFrameText;            protected var _tipWidth:int;            protected var _tipHeight:int;            private var _tipInfo:Object;            public function TeamTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            public function updateTips() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            override public function asDisplayObject() : DisplayObject { return null; }
            override public function dispose() : void { }
   }}