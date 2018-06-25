package wonderfulActivity{   import calendar.CalendarControl;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SharedManager;   import ddt.manager.SoundManager;   import flash.utils.Dictionary;   import mysteriousRoullete.MysteriousManager;   import treasureHunting.TreasureControl;   import treasureHunting.TreasureManager;   import wonderfulActivity.data.ActivityCellVo;   import wonderfulActivity.views.ActivityLeftView;   import wonderfulActivity.views.WonderfulRightView;      public class WonderfulFrame extends Frame   {                   private var _bag:ScaleBitmapImage;            private var _leftView:ActivityLeftView;            private var _rightView:WonderfulRightView;            private var allMusic:Boolean;            public function WonderfulFrame() { super(); }
            public function setState(type:int, id:int) : void { }
            private function initview() : void { }
            private function addEvents() : void { }
            private function removeEvents() : void { }
            public function addElement(actArr:Array) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function clear() : void { }
            override public function dispose() : void { }
   }}