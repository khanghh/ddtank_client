package fightLib.view{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;      public class FightLibAlertView extends Sprite implements Disposeable   {            private static const ButtonToCenter:int = 8;                   private var _background:DisplayObject;            private var _girlImage:Bitmap;            private var _txt:FilterFrameText;            private var _infoStr:String;            private var _okLabel:String;            private var _okBtn:TextButton;            private var _okFun:Function;            private var _cancelLabel:String;            private var _cancelBtn:TextButton;            private var _cancelFun:Function;            private var _showOkBtn:Boolean;            private var _showCancelBtn:Boolean;            private var _centerPosition:Point;            private var _WeaponCellArr:Array;            public function FightLibAlertView(infoString:String, okLabel:String = null, okFun:Function = null, cancelLabel:String = null, cancelFun:Function = null, showOkBtn:Boolean = true, showCancelBtn:Boolean = false, weaponArr:Array = null) { super(); }
            private function ShowWeaponIcon(_arr:Array) : void { }
            public function dispose() : void { }
            public function show() : void { }
            private function updataWeaponIcon() : void { }
            public function hide() : void { }
            public function set alert(val:String) : void { }
            public function get alert() : String { return null; }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function __cancelClicked(evt:MouseEvent) : void { }
            private function __submitClicked(evt:MouseEvent) : void { }
            private function removeEvent() : void { }
   }}