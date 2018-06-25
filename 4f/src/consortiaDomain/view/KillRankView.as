package consortiaDomain.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortiaDomain.ConsortiaDomainManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class KillRankView extends Sprite implements Disposeable   {                   private var _show_totalInfoBtnIMG:ScaleFrameImage;            private var _open_show:Boolean;            private var _show_totalInfoBtn:SimpleBitmapButton;            private var _mgr:ConsortiaDomainManager;            private var _listPanel:ListPanel;            private var _myKillTF:FilterFrameText;            public function KillRankView() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function onGetRankInfoBack(evt:Event) : void { }
            private function formatName(name:String) : String { return null; }
            private function __showTotalInfo(evt:MouseEvent) : void { }
            private function __totalViewShowOrHide(evt:Event) : void { }
            public function setOpen(isOpen:Boolean) : void { }
            public function dispose() : void { }
   }}