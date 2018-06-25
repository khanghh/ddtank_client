package mainbutton{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.BossBoxManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperUIModuleLoad;   import ddt.view.bossbox.AwardsViewII;   import ddt.view.bossbox.VipInfoTipBox;   import flash.events.Event;   import flash.events.MouseEvent;   import road7th.data.DictionaryData;   import vip.view.VipViewFrame;      public class AwardFrame extends Frame   {                   private var _text:FilterFrameText;            private var _topImgBG:MutipleImage;            private var _vipBtn:BaseButton;            private var _vipInfoTipBox:VipInfoTipBox;            private var awards:AwardsViewII;            private var alertFrame:BaseAlerFrame;            public function AwardFrame() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function __vipOpen(e:MouseEvent) : void { }
            private function showVipPackage() : void { }
            private function getVIPInfoTip(dic:DictionaryData) : Array { return null; }
            private function __responseVipInfoTipHandler(event:FrameEvent) : void { }
            private function __alertHandler(event:FrameEvent) : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function showAwards(para:ItemTemplateInfo) : void { }
            private function _getStrArr(dic:DictionaryData) : Array { return null; }
            private function __sendReward(event:Event) : void { }
            private function __confirmResponse(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}