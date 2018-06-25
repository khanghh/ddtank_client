package hall{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.LoaderSavingManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.SoundManager;   import ddt.manager.StatisticManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class SaveFileWidow extends Frame   {                   private var _okBtn:TextButton;            private var _novice:Bitmap;            private var _npc:Image;            public function SaveFileWidow() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function _response(evt:FrameEvent) : void { }
            private function _okClick(evt:MouseEvent) : void { }
            private function sendStatInfo(status:String) : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}