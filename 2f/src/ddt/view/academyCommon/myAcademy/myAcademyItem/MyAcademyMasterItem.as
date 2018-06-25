package ddt.view.academyCommon.myAcademy.myAcademyItem{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.player.PlayerInfo;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.PlayerTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import ddt.view.common.LevelIcon;   import ddt.view.common.SexIcon;   import email.MailManager;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import im.IMEvent;   import vip.VipController;      public class MyAcademyMasterItem extends Sprite implements Disposeable   {                   protected var _nameTxt:FilterFrameText;            protected var _vipName:GradientText;            protected var _offLineText:FilterFrameText;            protected var _removeBtn:TextButton;            protected var _itemBG:ScaleFrameImage;            protected var _line11:ScaleBitmapImage;            protected var _line22:ScaleBitmapImage;            protected var _line33:ScaleBitmapImage;            protected var _line44:ScaleBitmapImage;            protected var _levelIcon:LevelIcon;            protected var _sexIcon:SexIcon;            protected var _info:PlayerInfo;            protected var _isSelect:Boolean;            protected var _addFriend:TextButton;            protected var _emailBtn:TextButton;            protected var _removeGold:int;            public function MyAcademyMasterItem() { super(); }
            public function set info(value:PlayerInfo) : void { }
            public function get info() : PlayerInfo { return null; }
            protected function init() : void { }
            protected function initEvent() : void { }
            private function __addFriend(event:IMEvent) : void { }
            private function __emailBtnClick(event:MouseEvent) : void { }
            private function __addFriendClick(event:MouseEvent) : void { }
            protected function __removeClick(event:MouseEvent) : void { }
            protected function __alerFrameEvent(event:FrameEvent) : void { }
            protected function __frameEvent(event:FrameEvent) : void { }
            protected function __quickBuyResponse(event:FrameEvent) : void { }
            protected function submit() : void { }
            private function __onMouseClick(event:MouseEvent) : void { }
            protected function initComponent() : void { }
            protected function updateComponent() : void { }
            protected function getTimerOvertop() : Boolean { return false; }
            public function set isSelect(value:Boolean) : void { }
            public function get isSelect() : Boolean { return false; }
            public function dispose() : void { }
   }}