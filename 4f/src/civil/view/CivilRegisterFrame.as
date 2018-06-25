package civil.view{   import civil.CivilModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TextEvent;   import road7th.utils.StringHelper;      public class CivilRegisterFrame extends Frame implements Disposeable   {            public static const Modify:int = 1;            public static const Creat:int = 0;            private static var _firstOpen:Boolean;                   private var _model:CivilModel;            private var _state:int;            private var _titleImage:ScaleFrameImage;            private var _nicknameLabel:FilterFrameText;            private var _nicknameField:FilterFrameText;            private var _matrimonyLabel:FilterFrameText;            private var _introductionLabel:FilterFrameText;            private var _matrimonyField:FilterFrameText;            private var _registerBg:ScaleBitmapImage;            private var _nameBg:ScaleBitmapImage;            private var _introductionField:TextArea;            private var _publicEquipButton:SelectedCheckButton;            private var _submitButton:TextButton;            private var _cancelButton:TextButton;            private var _isPublishEquip:Boolean;            private var _introduction:String;            public function CivilRegisterFrame() { super(); }
            public function get model() : CivilModel { return null; }
            public function set model(val:CivilModel) : void { }
            public function get state() : int { return 0; }
            public function set state(val:int) : void { }
            private function updateView() : void { }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function __toStage(evt:Event) : void { }
            private function removeEvent() : void { }
            private function __onPublicEquipClick(evt:MouseEvent) : void { }
            private function __response(evt:FrameEvent) : void { }
            private function __propertyChange(evt:PlayerPropertyEvent) : void { }
            private function __getSelfInfo(evt:Event) : void { }
            private function __limit(evt:TextEvent) : void { }
            private function __onSubmitClick(evt:MouseEvent) : void { }
            override protected function __onCloseClick(event:MouseEvent) : void { }
            private function getSelfInfoForFirstIn() : void { }
            private function selfInfo() : void { }
            override public function dispose() : void { }
   }}