package ddt.view.academyCommon.graduate{   import academy.AcademyManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.text.TextFormat;      public class ApprenticeGraduate extends BaseAlerFrame implements Disposeable   {                   protected var _textBG:Bitmap;            protected var _alertInfo:AlertInfo;            protected var _explainText:FilterFrameText;            protected var _tieleText:FilterFrameText;            protected var _nameLabel:TextFormat;            public function ApprenticeGraduate() { super(); }
            protected function initContent() : void { }
            public function show() : void { }
            protected function initEvent() : void { }
            protected function update() : void { }
            protected function __frameEvent(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}