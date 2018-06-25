package ddt.view.common.church{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.geom.Rectangle;      public class ChurchDialogueRejectPropose extends BaseAlerFrame   {                   private var _contentTxt:FilterFrameText;            private var _cell:BagCell;            private var _alertInfo:AlertInfo;            private var _name_txt:FilterFrameText;            private var _cellPoint:Rectangle;            private var _msgInfo:String;            public function ChurchDialogueRejectPropose() { super(); }
            public function get msgInfo() : String { return null; }
            public function set msgInfo(value:String) : void { }
            private function initialize() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function confirmSubmit() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}