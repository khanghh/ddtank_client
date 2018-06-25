package mark.views{   import bagAndInfo.cell.BaseCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import mark.MarkMgr;   import mark.data.MarkChipData;   import mark.data.MarkChipTemplateData;   import mark.data.MarkProData;   import mark.data.MarkSchemeModel;   import mark.data.MarkSetTemplateData;   import mark.data.MarkSuitTemplateData;   import mark.event.MarkEvent;   import mark.items.MarkChipItem;   import mark.items.MarkEquipItem;   import mark.items.MarkSuitProItem;   import mark.mornUI.views.MarkLeftViewUI;   import morn.core.handlers.Handler;      public class MarkLeftView extends MarkLeftViewUI   {            private static const MAX_SCHEME_COUNT:int = 5;            private static const FREE_SCHEME_COUNT:int = 2;                   private var _items:Vector.<MarkChipItem> = null;            private var _item:BaseCell = null;            private var _bgEffect:MovieClip = null;            private var _selectedBox:ComboBox;            private var _comboBoxArr:Array;            private var _schemeMode:MarkSchemeModel;            private var _schemePrice:int = 2000;            private var _isSwitchScheme:Boolean = false;            private var _clickNum:Number = 0;            public function MarkLeftView() { super(); }
            override protected function initialize() : void { }
            private function initComBoxSuitWay() : void { }
            private function suitRender(item:MarkSuitProItem, index:int) : void { }
            private function render(item:MarkEquipItem, index:int) : void { }
            private function chooseEquip(evt:MarkEvent) : void { }
            private function updateProps() : void { }
            private function select(index:int) : void { }
            private function initEvent() : void { }
            private function __updateCurScheme(evt:MarkEvent) : void { }
            private function __updateCurSchemeDe(evt:MarkEvent) : void { }
            private function updateSaveSchemeBtnState() : void { }
            private function __itemClickHander(evt:ListItemEvent) : void { }
            private function alertSavePrompt(newIndex:*) : void { }
            private function sendSwitchScheme(newIndex:int) : void { }
            private function __alertAllBack(event:FrameEvent) : void { }
            private function __onSaveSuitWayHandler(evt:MouseEvent) : void { }
            private function __onAddSchemeHandler(evt:MarkEvent) : void { }
            private function __onSaveSchemeHandler(e:MarkEvent) : void { }
            private function updateMarkMoney(evt:MarkEvent = null) : void { }
            protected function __onClickHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            private function putOnChip(evt:MarkEvent) : void { }
            private function playSuitEffect(type:int = 0, chipId:int = 0) : void { }
            private function clearEffect() : void { }
            private function putOffChip(evt:MarkEvent) : void { }
            private function disposeView(evt:MarkEvent) : void { }
            private function clearItems() : void { }
            private function get canClick() : Boolean { return false; }
            override public function dispose() : void { }
   }}